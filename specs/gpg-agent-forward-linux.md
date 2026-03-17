# Spec: GPG Agent Forwarding — Linux office2 / 192.168.88.10 (SSH-сервер)

## Контекст

Машина: `office2` (192.168.88.10), UID=1000, shell=fish.
Dotfiles: `~/dotfiles/`, управляются через `make`.
GPG socket на этой машине: `/run/user/1000/gnupg/S.gpg-agent`

Цель: при SSH-подключении с macOS использовать forwarded GPG-агент macOS
вместо локального, чтобы passphrase спрашивался на macOS (через pinentry-mac + Keychain).

## Уже сделано

- `~/.config/fish/conf.d/20-keychain-gpg.fish` — убивает локальный gpg-agent при SSH-сессии ✓
- `dotfiles/.gnupg/gpg-agent.conf` — `allow-loopback-pinentry`, `disable-scdaemon` ✓
- `makefiles/gnupg.mk` — `pinentry-tty` через `update-alternatives` на Linux ✓

## Задачи

### 1. Разрешить SSH перезаписывать сокет RemoteForward

Проблема: SSH создаёт сокет при RemoteForward, но если там уже есть старый сокет
(от предыдущей сессии или локального gpg-agent), соединение падает с ошибкой.

Решение: добавить `StreamLocalBindUnlink yes` в sshd_config.

```bash
# Создать файл конфигурации sshd
sudo tee /etc/ssh/sshd_config.d/gpg-forward.conf << 'EOF'
# Allow SSH RemoteForward to overwrite existing Unix socket files.
# Needed for GPG agent forwarding from macOS.
StreamLocalBindUnlink yes
EOF

# Проверить синтаксис
sudo sshd -t

# Перезагрузить sshd (без разрыва существующих соединений)
sudo systemctl reload ssh
```

> `StreamLocalBindUnlink yes` автоматически удаляет устаревший сокет при создании RemoteForward.
> Без этого SSH выдаёт "remote port forwarding failed" если сокет уже существует.

### 2. Убедиться что fish-конфиг корректен

Файл: `dotfiles/.config/fish/conf.d/20-keychain-gpg.fish`

Текущее содержимое должно быть:

```fish
status --is-interactive; or return

# Use systemd-managed ssh-agent socket (Linux only).
if test (uname) = Linux
    set -gx SSH_AUTH_SOCK /run/user/(id -u)/openssh_agent
end

# Prefer forwarded GPG agent over a locally spawned one during SSH sessions.
if set -q SSH_CONNECTION
    gpgconf --kill gpg-agent >/dev/null 2>&1
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
```

Файл уже существует и корректен — изменений НЕ требует.

> **Почему это работает**: `gpgconf --kill gpg-agent` убивает локальный агент и его сокет.
> SSH RemoteForward уже создал forwarded сокет по тому же пути ДО запуска shell.
> GPG находит сокет → запросы идут через туннель к macOS gpg-agent.

### 3. Убедиться что публичный ключ импортирован

На Linux должен быть импортирован публичный ключ (не приватный — он остаётся на macOS):

```bash
# Проверить наличие ключей
gpg --list-keys

# Если ключей нет — импортировать с macOS:
# (выполнить на macOS, передать через SSH)
# gpg --export --armor your@email.com | ssh office2 'gpg --import'
```

### 4. Проверка (выполнять после применения macOS-спеки и нового SSH-подключения)

```bash
# Подключиться с macOS с явным RemoteForward (тест без изменения ssh config)
# ssh -R /run/user/1000/gnupg/S.gpg-agent:$(gpgconf --list-dirs agent-extra-socket) office2

# На office2: проверить что сокет создан SSH (а не локальным агентом)
ls -la /run/user/1000/gnupg/S.gpg-agent

# Проверить что gpg-agent НЕ запущен локально
gpgconf --list-dirs | grep socket
ps aux | grep gpg-agent

# Тест подписания — должен появиться диалог на macOS
echo "test" | gpg --clearsign

# Тест шифрования
echo "test" | gpg --encrypt --recipient your@email.com | gpg --decrypt
```

## Checklist

- [ ] Создан `/etc/ssh/sshd_config.d/gpg-forward.conf` с `StreamLocalBindUnlink yes`
- [ ] `sudo sshd -t` прошёл без ошибок
- [ ] `sudo systemctl reload ssh` выполнен
- [ ] Публичный ключ присутствует на Linux (`gpg --list-keys`)
- [ ] **После применения macOS-спеки**: переподключиться по SSH и проверить
- [ ] `echo "test" | gpg --clearsign` показывает pinentry-mac на macOS

## Порядок применения спек

1. Сначала выполнить **macOS-спеку** (создать конфиги, `make apply`)
2. Потом выполнить **эту спеку** (sshd config, systemctl reload)
3. Закрыть и переоткрыть SSH-сессию
4. Проверить подписание
