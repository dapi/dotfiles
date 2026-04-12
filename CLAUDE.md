# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Обзор

Репозиторий dotfiles для синхронизации конфигураций между MacOS и Linux (Ubuntu) машинами. Используется для консольной веб-разработки с neovim, fish/zsh, tmux.
Node.js и Ruby version management в репозитории идут только через `mise.toml`; `nvm` и `rbenv` не используются.

## Команды

```bash
# Установить/обновить базовые dotfiles
make

# Установить AI-слой: Codex, Claude Code, agent CLI, plugins и curated skills
make ai

# Обновить из git и применить
make update

# Отдельные таргеты
make packages     # Установить пакеты (ag, direnv, pass, fzf, nvim)
make dotfiles     # Создать симлинки конфигов
make apply        # Применить (nvim плагины, fisher)
make agents-skills-install  # Установить curated agent skills
make agents-skills-list     # Показать curated agent skills

# Neovim
make nvim-install      # Установить vim-plug и плагины
make nvim-reinstall    # Полная переустановка nvim конфига
nvim -R +PlugInstall +qall  # Установить плагины nvim

# Fish
make fisher            # Установить fisher и плагины
./scripts/install-fisher.fish
./scripts/install-fish-plugins.fish
```

## Архитектура

### Структура Репозитория

```
dotfiles/
├── Makefile              # Точка входа, включает все makefiles/*.mk
├── configuration.mk      # Определяет DOTFILES, PACKAGES, APPLIES
├── makefiles/            # Модульные конфигурации
│   ├── linker.mk        # ⭐ Логика симлинков с автобекапом
│   ├── agents.mk        # AI tooling bootstrap and curated skills list
│   ├── nvim.mk          # Neovim setup
│   ├── fish.mk          # Fish shell setup
│   ├── packages.mk      # Установка через brew/apt
│   └── ...              # Другие инструменты
├── .config/              # XDG конфиги (nvim, fish, zellij)
├── .[tool]rc             # Root-level конфиги (.tmux.conf, .zshrc)
└── scripts/              # Вспомогательные скрипты
```

### Три Уровня Конфигурации

**1. DOTFILES** - Симлинкуемые файлы/директории
```makefile
# configuration.mk - базовый список
DOTFILES=~/.ackrc ~/.tmux.conf ~/.psqlrc ~/.agignore

# Модули расширяют список:
# nvim.mk
DOTFILES:=${DOTFILES} ~/.config/nvim

# fish.mk
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d ~/.config/fish/config.fish

```

**2. PACKAGES** - Устанавливаемые пакеты
```makefile
# configuration.mk
PACKAGES=ag direnv pass fzf

# Модули добавляют свои:
PACKAGES:=${PACKAGES} nvim fish mise
```

Установка: `which ${PACKAGE} || (brew install || apt-get install)`

**3. APPLIES** - Пост-установочные действия
```makefile
# nvim.mk
APPLIES:=${APPLIES} nvim-install
nvim-install: nvim-plug-install nvim-plugins-install

# fish.mk
APPLIES:=$(APPLIES) fisher
fisher: fisher-install fisher-plugins
```

### Механизм Симлинков (linker.mk)

**Умная логика бекапов:**
```makefile
# Определяем пути
DST_REFERENCE=$(readlink $(DST))              # Куда указывает текущий симлинк
REAL_REFERENCE=$(realpath $(REFERENCE))       # Реальный путь в dotfiles
BACKUP_FILE=${DST}-${TEMP_DATE}               # Бекап с timestamp

backup-config:
    # Пропускаем, если уже правильный симлинк (idempotent)
    if [ симлинк на правильный путь ]; then skip
    # Бекапим существующий файл/директорию/неправильный симлинк
    elif [ существует ]; then mv $(DST) $(BACKUP_FILE)
```

**Создание симлинка:**
```makefile
# ~/.tmux.conf → .tmux.conf → ~/dotfiles/.tmux.conf
REFERENCE_FILE=$(echo $(DST) | sed -e 's:$(HOME)/::g')
REFERENCE=~/dotfiles/${REFERENCE_FILE}

link-home-config: backup-config
    ln -s ${REAL_REFERENCE} ${DST}
```

**Примеры сценариев:**

1. **Файл не существует**: Создаётся симлинк без бекапа
2. **Существующий файл**: `mv ~/.tmux.conf ~/.tmux.conf-2026-02-14-16:54:23` → симлинк
3. **Правильный симлинк**: Ничего не делаем (idempotent)
4. **Неправильный симлинк**: Бекапим старый симлинк → создаём новый

### Workflow Выполнения

```bash
make  # = make all
```

**Последовательность:**
1. `make packages` - Установка утилит (ag, nvim, fish, ...)
2. `make dotfiles` - Создание симлинков с автобекапом
3. `make apply` - Пост-установка (плагины, настройки)

### Паттерны Организации Конфигов

**Root-level файлы:**
```
~/dotfiles/.tmux.conf     → ~/.tmux.conf
~/dotfiles/.zshrc         → ~/.zshrc
~/dotfiles/.gitconfig     → ~/.gitconfig
```

**XDG директории:**
```
~/dotfiles/.config/nvim/    → ~/.config/nvim/
~/dotfiles/.config/fish/    → ~/.config/fish/
~/dotfiles/.config/zellij/  → ~/.config/zellij/
```

**Granular симлинки** (отдельные поддиректории):
```makefile
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d ~/.config/fish/config.fish ~/.config/fish/functions
```

### Neovim конфигурация
```
.config/nvim/
├── init.lua          # Точка входа, OSC52 clipboard
├── vim-plug/plugins.vim  # vim-plug и lualine конфиг
├── general/          # settings.vim, theme.vim, plugins-config.vim
└── keys/mappings.vim
```

Плагин менеджер: vim-plug. Тема: gruvbox. Statusline: lualine.

### Fish конфигурация
```
.config/fish/
├── config.fish    # Минимальный: только non-interactive guard
├── conf.d/        # Автозагружаемые конфиги (вся логика здесь)
└── functions/     # Пользовательские функции
```

**Правило: config.fish должен быть минимальным.** Вся логика выносится в `conf.d/` как отдельные сниппеты с нумерованными префиксами (05-, 10-, 15-, ...). Каждый сниппет начинается с `status --is-interactive; or return`. Для опциональных зависимостей добавлять `test -f` проверку.

Плагин менеджер: fisher. Prompt: tide.

### Tmux
Плагин менеджер: tpm. Тема: catppuccin. Prefix: `C-b`.

Ключевые биндинги:
- `C-b r` - перезагрузить конфиг
- `C-b "` / `C-b %` - split panes
- `C-b h/j/k/l` - навигация по panes
- Vi-mode в copy-mode (`v` - selection, `y` - copy)

## Особенности

- OSC52 clipboard для работы через SSH (настроен в nvim)
- Пакеты устанавливаются через homebrew (MacOS) или apt-get (Linux)
- Поддержка mise для version management
- keychain для переиспользования ssh-agent
- Idempotent операции: повторный `make dotfiles` безопасен
- Автоматические бекапы существующих конфигов с timestamp

## Добавление Нового Конфига

### Шаблон для создания модуля `makefiles/<tool>.mk`

```makefile
# Добавить конфиг в список симлинков
DOTFILES:=${DOTFILES} ~/.<tool>rc          # для root-level
# ИЛИ
DOTFILES:=${DOTFILES} ~/.config/<tool>      # для XDG

# Добавить пакет для установки (опционально)
PACKAGES:=${PACKAGES} <tool>

# Добавить пост-установочные действия (опционально)
APPLIES:=$(APPLIES) <tool>-setup

<tool>-setup:
	@echo "Configure <tool>..."
	# Команды настройки плагинов, тем и т.д.
```

### Процедура добавления

**1. Создать модуль**
```bash
# Пример: добавить btop
cat > makefiles/btop.mk << 'EOF'
DOTFILES:=${DOTFILES} ~/.config/btop
PACKAGES:=${PACKAGES} btop
APPLIES:=$(APPLIES) btop-theme

btop-theme:
	@echo "Apply btop theme..."
EOF
```

**2. Поместить конфиг в репозиторий**
```bash
# Для XDG конфигов
mkdir -p ~/dotfiles/.config/<tool>
cp -r ~/.config/<tool>/* ~/dotfiles/.config/<tool>/

# Для root-level
cp ~/.<tool>rc ~/dotfiles/.<tool>rc
```

**3. Применить изменения**
```bash
make dotfiles  # Создаст симлинки с автобекапом
make packages  # Установит пакет если отсутствует
make apply     # Выполнит пост-установку
```

**4. Проверить idempotent**
```bash
make dotfiles  # Повторный запуск не должен создавать дубликаты
```

### Пример: curated skills list в makefile

Для agent skills держим простой список install-команд в `makefiles/agents.mk` и ставим их только для поддерживаемых агентов:

```makefile
# makefiles/agents.mk
ai: bootstrap
	$(MAKE) agents-install

agents-cli:
	brew upgrade mmctl 2>/dev/null || brew install mmctl

agents-skills-install:
	$(SKILLS) add dapi/tgcli --skill tgcli -g -a codex -a claude-code -y
```

Результат:

```text
makefiles/agents.mk          # curated skills list в git
make ai                      # отдельный bootstrap AI-инструментов
```

### Примеры Специальных Модулей

**С установкой плагинов (nvim.mk):**
```makefile
APPLIES:=${APPLIES} nvim-install

nvim-install: nvim-plug-install nvim-plugins-install

nvim-plug-install:
	curl -fLo ${NVIM_PLUG_FILE} https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim-plugins-install:
	nvim -R +PlugInstall +qall
```

**С внешними скриптами (fish.mk):**
```makefile
fisher: fisher-install fisher-plugins

fisher-install:
	./scripts/install-fisher.fish

fisher-plugins:
	./scripts/install-fish-plugins.fish
```

**Со скачиванием бинарников (zellij.mk):**
```makefile
zellij-plugins: $(ZELLIJ_TAB_STATUS)

$(ZELLIJ_TAB_STATUS):
	mkdir -p $(ZELLIJ_PLUGINS_DIR)
	curl -fL https://github.com/.../plugin.wasm -o $(ZELLIJ_TAB_STATUS)
```

### Чеклист для Агента

При добавлении нового инструмента:

- [ ] Создать модуль `makefiles/<tool>.mk`
- [ ] Определить тип конфига: root-level (`~/.<tool>rc`) или XDG (`~/.config/<tool>`)
- [ ] Добавить в `DOTFILES` (обязательно)
- [ ] Добавить в `PACKAGES` (если требуется установка)
- [ ] Добавить в `APPLIES` (если нужна пост-установка)
- [ ] Скопировать конфиг в `~/dotfiles/`
- [ ] Проверить idempotent: `make dotfiles` дважды
- [ ] Обновить документацию в `CLAUDE.md` (при необходимости)
- [ ] Для directory-level конфигов проверить сценарий миграции с backup
