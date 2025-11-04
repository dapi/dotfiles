if has('persistent_undo')
  if (has("nvim"))
    set undodir=~/.nvim/backups
  else
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
  endif
  set undofile
  " Ограничить количество undo-файлов для производительности
  set undolevels=1000
  set undoreload=1000
endif
