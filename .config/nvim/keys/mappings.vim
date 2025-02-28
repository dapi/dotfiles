
" let mapleader = "\"

" Вставляем символ TAB через Shift-TAB
inoremap <S-Tab> <C-V><Tab>
nnoremap <silent> <C-p> :FZF<cr>
vmap <Enter> :EasyAlign<CR>
nmap ga :EasyAlign<CR>

" Вставляем символ TAB через Shift-TAB
inoremap <S-Tab> <C-V><Tab>
" vip<Enter>=
" gaip=

" Plug 'godlygeek/tabular'
" nmap <Leader>a= :Tabularize /=<CR>
" vmap <Leader>a= :Tabularize /=<CR>
" nmap <Leader>a: :Tabularize /:\zs<CR>
" vmap <Leader>a: :Tabularize /:\zs<CR>


" Plug 'AndrewRadev/splitjoin.vim'
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.


" Plug 'mg979/vim-visual-multi' " Ctrl-N
"
" Want to turn fooBar into 
" foo_bar? Press crs (coerce to snake_case).
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru) are
" cs{( to change { on (
" ysiw] обернуть слово в ]
" https://github.com/tpope/vim-surround

" Plug 'tpope/vim-surround' " Chanse surround by cs keystroke
" cs - change surrond parenthesis
" vir - select inner ruby block
" var - select all method definitios
"am      "a method", select from "def" until matching "end"
"im      "inner method", select contents of "def"/"end" block,
"aM      "a class", select from "class" until matching "end"
"iM      "inner class", select contents of "class"/"end" "block, excluding the "class" and "end" themselves.
