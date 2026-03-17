# Spec: GPG Agent Forwarding — macOS (SSH-клиент)

## Контекст

Dotfiles живут в `~/dotfiles/`, управляются через `make`.
macOS — машина, с которой пользователь SSH-ится на Linux-серверы.
Цель: GPG passphrase спрашивается через macOS pinentry-mac (с сохранением в Keychain),
а не на удалённом сервере.

## Уже сделано (на Linux-стороне)

- `~/.config/fish/conf.d/20-keychain-gpg.fish` убивает локальный gpg-agent при SSH-сессии
- `gpg-agent.conf` имеет `allow-loopback-pinentry` и `disable-scdaemon`

## Задачи (выполнять в `~/dotfiles/` на macOS)

### 1. Создать macOS-специфичный gpg-agent.conf

Создать файл `dotfiles/.gnupg/gpg-agent.macos.conf`:

```
# Cache passphrase for 7 days since last use
default-cache-ttl 604800

# Hard maximum cache lifetime: 7 days
max-cache-ttl 604800

# macOS pinentry — интеграция с Keychain
pinentry-program /opt/homebrew/bin/pinentry-mac

# No smartcard reader on this machine
disable-scdaemon

# Поддержка SSH через gpg-agent (нужно для extra-socket форвардинга)
enable-ssh-support
```

> Путь `pinentry-mac` зависит от архитектуры: `/opt/homebrew/bin` (Apple Silicon)
> или `/usr/local/bin` (Intel). В make-таргете определять через `$(brew --prefix)/bin/pinentry-mac`.

### 2. Обновить makefiles/gnupg.mk

Добавить macOS-секцию рядом с существующей Linux-секцией:

```makefile
ifeq ($(UNAME),Darwin)
PACKAGES:=$(PACKAGES) pinentry-mac
APPLIES:=$(APPLIES) gnupg-pinentry-mac
endif

gnupg-pinentry-mac:
	@echo "Linking macOS-specific gpg-agent.conf..."
	@rm -f ~/.gnupg/gpg-agent.conf
	@DOTFILES_DIR="$$(realpath ~/dotfiles)"; \
	 PINENTRY="$$(brew --prefix)/bin/pinentry-mac"; \
	 sed "s|/opt/homebrew/bin/pinentry-mac|$$PINENTRY|g" \
	     "$$DOTFILES_DIR/.gnupg/gpg-agent.macos.conf" \
	     > ~/.gnupg/gpg-agent.conf
	@gpgconf --kill gpg-agent
	@gpgconf --launch gpg-agent
	@echo "gpg-agent restarted with pinentry-mac"
```

> Мы НЕ делаем симлинк для gpg-agent.conf на macOS, а копируем с подстановкой пути —
> это позволяет избежать хардкода пути pinentry в репо.
> Linux-симлинк `~/.gnupg/gpg-agent.conf → dotfiles/.gnupg/gpg-agent.conf` остаётся как есть.

### 3. Добавить SSH RemoteForward для office2 / 192.168.88.10

Создать файл `dotfiles/.ssh/hosts/office2.conf`:

```
Host office2 192.168.88.10
    # Форвардим macOS gpg-agent extra-socket → Linux gpg-agent socket
    # remote: /run/user/1000/gnupg/S.gpg-agent (UID=1000 на office2)
    # local:  путь к extra-socket macOS gpg-agent (определять динамически)
    RemoteForward /run/user/1000/gnupg/S.gpg-agent /Users/danil/.gnupg/S.gpg-agent.extra
```

> **Важно**: локальный путь (`/Users/danil/.gnupg/S.gpg-agent.extra`) — это extra-socket macOS gpg-agent.
> Проверить актуальный путь командой: `gpgconf --list-dirs agent-extra-socket`
> Если путь отличается — скорректировать.
> SSH не поддерживает `~` в RemoteForward для сокетов — нужен абсолютный путь.

### 4. Применить изменения

```bash
cd ~/dotfiles

# Установить pinentry-mac и применить конфиг
make apply

# Проверить что gpg-agent запущен и использует pinentry-mac
gpg-connect-agent 'getinfo version' /bye

# Убедиться что extra-socket существует
ls -la $(gpgconf --list-dirs agent-extra-socket)
```

### 5. Проверка после SSH-подключения к office2

```bash
# Подключиться к office2
ssh office2

# На office2: проверить что форвардинг работает
gpg --list-secret-keys
echo "test" | gpg --clearsign
# Должен появиться диалог pinentry-mac на macOS
```

## Checklist

- [ ] Создан `dotfiles/.gnupg/gpg-agent.macos.conf` с `pinentry-program`
- [ ] `makefiles/gnupg.mk` обновлён с macOS-секцией
- [ ] Создан `dotfiles/.ssh/hosts/office2.conf` с `RemoteForward`
- [ ] Проверен актуальный путь extra-socket: `gpgconf --list-dirs agent-extra-socket`
- [ ] `make apply` выполнен на macOS
- [ ] extra-socket существует после применения
- [ ] Подписание работает через SSH (pinentry-mac показывается на macOS)
