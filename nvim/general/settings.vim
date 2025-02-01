if !has("gui_running")
  let g:gruvbox_italic=0
endif
colorscheme gruvbox

set wildignore+=*.log,*.o,*.obj,.git,*.rbc,*.class,.svn,.sass-cache/*,solr/*,*tags,*.lock
set wildignore+=*/images/*,*/tmp/*,*/coverage/*,*/uploads/* " ,*/node_modules/*,*/dist/*
" set wildignore+=*/vendor/gems/*,*/vendor/static/* " ,*/vendor/assets/*
set wildignore+=public/*
" set wildignore+=*/scripts/*,*/doc/*,*/bin/*
set wildignore+=*/doc/*,*/bin/*

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

au BufReadPost,BufNewFile */playbooks/*.yml,*/ansible*/*.yml,playbook.yml set filetype=yaml.ansible
"augroup ansible_vim_fthosts
  "autocmd!
  "autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
"augroup END
" au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
" let g:ansible_unindent_after_newline = 0



" From 'fatih/vim-go'
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

nnoremap <silent> <C-p> :FZF<cr>

"let g:airline_enable_syntastic = 1
"let g:airline#extensions#syntastic#enabled = 1
" only on mac
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1

let g:used_javascript_libs = 'react'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

let g:solarized_termcolors=256
let g:indentLine_color_term = 239
let g:indentLine_char = '|' " ¦, ┆

" Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_ruby_hanging_args = 1
let g:splitjoin_ruby_curly_braces = 0

" Включить <Leader>ig
" Из Plug 'nathanaelkane/vim-indent-guides'
hi IndentGuidesOdd  ctermbg=235 
hi IndentGuidesEven ctermbg=4

vmap <Enter> :EasyAlign<CR>
nmap ga :EasyAlign<CR>
" vip<Enter>=
" gaip=

" Plug 'godlygeek/tabular'
" nmap <Leader>a= :Tabularize /=<CR>
" vmap <Leader>a= :Tabularize /=<CR>
" nmap <Leader>a: :Tabularize /:\zs<CR>
" vmap <Leader>a: :Tabularize /:\zs<CR>

" Ему нужен tabular
" Plug 'plasticboy/vim-markdown'

" Plug 'mbbill/undotree'

" Vim Workspace Controller
" Это та самая штука, которая выводит количество файлов табе буффера
" Plug 'szw/vim-ctrlspace'
" :ls - список буферов
" o Jump to File List (aka Open List)
" O Jump to File List (aka Open List) in Search Mode
" l Jump to Tab List
" L Jump to Tab List in Search Mode
"
"
" Противная опция держит файл открытым,
" в то время когда ты его уже не редактируешь
" set hidden

"https://github.com/majutsushi/tagbar/wiki#coffeescript
let g:tlist_coffee_settings = 'coffee;f:function;v:variable'
"let g:CoffeeAutoTagFile=<filename>       " Name of the generated tag file (Default: ./tags)
"let g:CoffeeAutoTagIncludeVars=<0 or 1>  " Includes variables (Default: 0 [false])
"let g:CoffeeAutoTagTagRelative=<0 or 1>  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

syntax on
"set t_Co=256
"
" С такой настройкой нормльно работает фон в tmux на vagrant-е
" set term=screen-256color
"set term=xterm-256color
"set list lcs=tab:' '
"http://andrew.stwrt.ca/posts/vim-ctags
":CtrlPTag
set tags+=gems.tags
set fileformat=unix

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>120v.\+/
"match OverLength /\%81v.\+/

set number " Shows the line numbers
set list lcs=tab:\|\ 

" Plug 'michaeljsmith/vim-indent-object'
" <count>ai         (A)n (I)ndentation level and line above.
" <count>ii         (I)nner (I)ndentation level (no line above).
" <count>aI         (A)n (I)ndentation level and lines above/below.
" <count>iI         (I)nner (I)ndentation level (no lines above/below).

" Plug 'tpope/vim-markdown'

" let g:loaded_syntastic_vim_vimlint_checker = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_debug=1
"let g:syntastic_ruby_checkers = ['mri', 'rubocop']
"let g:syntastic_ruby_checkers = ['mri', 'reek']
let g:syntastic_aggregate_errors = 1
" If you have installed Tim Pope’s unimpaired plugin, you can jump between
" errors using ]l and [l.
" /uni
" setup Syntastic to automatically load errors into the location list
" нужно чтобы :lnext сразу работало после отрытия
let g:syntastic_always_populate_loc_list = 1
" Read :h location-list for a complete list of commands.
"let g:syntastic_auto_loc_list = 1
"check for errors when a file is loaded into Vim
let g:syntastic_check_on_open = 1
" check on writing
let g:syntastic_check_on_wq = 0
" :Errors
" :lclose
" next/prev errors :lnext, :lprev
let g:syntastic_javascript_checkers = ['eslint --quiet']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'   

