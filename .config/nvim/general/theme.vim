if !has("gui_running")
  let g:gruvbox_italic=0
endif

" Выполняется после plug#end()
set background=dark " or light if you want light mode
colorscheme gruvbox

" Явный цвет курсора для Ghostty (gruvbox ставит inverse, что делает курсор невидимым).
" В Zellij OSC 12 (cursor color) не работает — explicit цвета ломают курсор.
" Оставляем gruvbox default (inverse) — reverse video блок видим в Zellij.
if empty($ZELLIJ)
  highlight Cursor gui=NONE cterm=NONE guifg=#121800 guibg=#02d5cf
  highlight TermCursor gui=NONE cterm=NONE guifg=#121800 guibg=#02d5cf
  highlight lCursor gui=NONE cterm=NONE guifg=#121800 guibg=#02d5cf
endif


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
