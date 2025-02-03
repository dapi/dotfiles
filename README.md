# Настроечки для разоработчки и администрирования под MacOS/Linux

Меня зовут Данил и я занимаюсь веб-разработкой и администрированием. У меня много компьютеров с операционной системой MacOS/Linux между которыми я
перемещаюсь в течении недели. Некоторые компьютеры это сервера без GUI, которым, например не требуется терминал типа `ghostty`. 

Я стараюсь держать на всех компьютерах держать идентичный набор настроек и
плагинов для:

* `nvim/vim`
* `fish/zsh`
* `goenv/rbenv/nvm`
* `tmux`
* `git`
* Разработка под ruby: `.gemrc, .pryrc, .irbrc, .rdebugrc`
*** `ag`
* Шрифты для macos
* Темы для fish, nvim/vim, ghostty

Для этого я склонировал этот репозиторий на все свои компьютеры. Когда необходимо
что-то изменить, я меняю на том компьютере на котормо нахожусь, комичу и пушаю в
репозиторий, а затем на остальных компах делаю `make`. Это приводит к обновлению
всех настроек, сохраняя бакапы не учтенных изменний.

# Первоначальная устновка

У Вас должен уже стоять `make` и `git`

## Установка

Вариант #1

```sh
curl -o- https://raw.githubusercontent.com/dapi/dotfiles/refs/heads/master/scripts/install.sh | bash
```

Вариант #2

```sh
cd ~; git clone git@github.com:dapi/dotfiles.git; cd ~/dotfiles; make
```

# Использование

# TODO

* Сделать `make` по умолчанию и для установки и для обновления

## Управление фоном терминала в зависимости от ssh-сессии

* https://github.com/fboender/sshbg
* https://askubuntu.com/questions/310498/change-terminal-colour-based-on-ssh-session
* https://superuser.com/questions/603909/how-to-change-terminal-colors-when-connecting-to-ssh-hosts
