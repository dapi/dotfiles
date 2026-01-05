# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Обзор

Репозиторий dotfiles для синхронизации конфигураций между MacOS и Linux (Ubuntu) машинами. Используется для консольной веб-разработки с neovim, fish/zsh, tmux.

## Команды

```bash
# Установить/обновить все (пакеты + dotfiles + плагины)
make

# Обновить из git и применить
make update

# Отдельные таргеты
make packages     # Установить пакеты (ag, direnv, pass, fzf, nvim)
make dotfiles     # Создать симлинки конфигов
make apply        # Применить (nvim плагины, fisher)

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

### Makefile система
- `Makefile` - точка входа, включает все `makefiles/*.mk`
- `configuration.mk` - определяет `DOTFILES`, `PACKAGES`, `APPLIES`
- `makefiles/linker.mk` - логика создания симлинков с автобекапом

### Как работают симлинки
Файлы из `configuration.mk` (например `~/.tmux.conf`) создаются как симлинки на файлы в `~/dotfiles/`. При наличии существующего файла создаётся бекап с timestamp.

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
├── config.fish    # Основной конфиг (mise, keychain, paths)
├── conf.d/        # Автозагружаемые конфиги
└── functions/     # Пользовательские функции
```

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
