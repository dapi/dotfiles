# Подтягиваемые настройки для консольной веб-разработки и администрирования под MacOS/Linux

Меня зовут [Данил](https://pismenny.ru), я занимаюсь разработкой и администрированием веб-приложений. 

В работе я использую несколько компьютеров с операционной системой MacOS/Linux между которыми постоянно
перемещаюсь. Это могут быть как сервера под управлением Linux Ubuntu 24.02 LTS по SSH/TMUX без GUI, так и MacOS на ноутбуке или десктопе.

Предпочитаю работать из консоли, с минимальным привлечением мыши, поэтому cтараюсь на всех компьютерах 
держать идентичный набор настроек, плагинов и цветовые темы для утилит которым я часто пользуюсь, а именно:

* `neovim`, `vim` с набором [плагинов](nvim/vim-plug/plugins.vim)
* `fish`, `zsh`, `tmux`
* `direnv`, `goenv`, `rbenv`, `nvm`
* `git`, `ag`, `ctags`
* `ghostty`
* Моноширинные шрифты поддерживающие statusline в fish, tmux, neovim для MacOS.

# Как это выглядит?

<img width="1330" alt="Screenshot 2025-02-04 at 11 28 00" src="https://github.com/user-attachments/assets/075d788b-28af-4fbb-9739-5f29cff6866e" />
<img width="1330" alt="Screenshot 2025-02-04 at 11 28 13" src="https://github.com/user-attachments/assets/66933ac1-f9fa-4ca9-908e-826362e561f6" />
<img width="1126" alt="Screenshot 2025-02-04 at 12 30 29" src="https://github.com/user-attachments/assets/b3e1c673-6a2c-4bbd-b6b1-35cdcf291866" />

# Как это работает?

1. Клонирую репоизторий на новый компьютер в каталог `~/dotfiles`
2. Запускаю в нем `make`. Конфигурационные файлы автоматически разбегаются по своим местам, утилиты устанавливаются.
3. Когда необходимо изменить настройки, я меняю на том компьютере на котормо нахожусь в данный момент, комичу и пушаю в
этот репозиторий, затем на остальных компах делаю `make` чтобы подтянуть изменения. Это приводит к обновлению
всех настроек, сохраняя бакапы неучтенных изменний.

Данный механизм подоходит как для того чтобы синхронизировать настройки между
компьютерами, так и для того чтобы установить в один клик на свежую OS необходимые
программы с привычными настройками.

# Как начать работать с этим?

Скопируйте этот репозиторий к себе в `~/dotfiles`, перейдите в него и запустите `make`. Небойтесь, ваши текущие настройки будут сохранены рядом.

Например так:

```sh
cd ~; git clone git@github.com:dapi/dotfiles.git; cd ~/dotfiles; make
```

или так:

```sh
curl -o- https://raw.githubusercontent.com/dapi/dotfiles/refs/heads/master/scripts/install.sh | bash
```

# TODO

Добавить управление фоном терминала в зависимости от ssh-сессии

* https://github.com/fboender/sshbg
* https://askubuntu.com/questions/310498/change-terminal-colour-based-on-ssh-session
* https://superuser.com/questions/603909/how-to-change-terminal-colors-when-connecting-to-ssh-hosts
