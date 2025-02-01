# Любимые настроечки для MacOS

Используются, в основном, для консольной разработки.

## Установка

У Вас должен уже стоять `make` и `git`, а затем:

```zsh
curl -o- https://raw.githubusercontent.com/dapi/dotfiles/v0.1.1/install.sh | bash
```

или почти руками:

```zsh
cd ~
git clone git@github.com:dapi/dotfiles.git
cd ~/dotfiles
make
```

## Подсказки


Суммирование значений столбца:

```sh
awk '{ total+=$9;} END { print total }'
```

Массовое изменение текста в файлах:

```sh
perl -i.bak -p -e 's/xyz\.rice\.edu/abc.rice.edu/ig' *.html
```

Выполнение команды раз в сек. и перерисовка результата:

```sh
watch -n1 "cat /proc/interrupts"
```

Из десятичного в шестнадцатеричный вид:

```sh
echo "obase=16;ibase=10;123" | bc
```

Удаление комментариев и пустых строк:

```sh
sed '/ *#/d; /^ *$/d'
```

Объединение строк разделенных символом \

```sh
sed ':a; /\\$/N; s/\\\n//; ta'
```

Удаление граничных пробелов и табуляций:

```sh
sed 's/[ \t]*$//'
```

Организация файлов в .vimrc
* https://smarttech101.com/organizing-neovim-configuration-files
* https://tuckerchapman.com/posts/vimrc_organization/

