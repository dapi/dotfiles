if has('persistent_undo')
  if (has("nvim"))
    silent !mkdir ~/.nvim/backups > /dev/null 2>&1
    set undodir=~/.nvim/backups
  else
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
  endif
  set undofile
endif
