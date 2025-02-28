let g:used_javascript_libs = 'react'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

let g:solarized_termcolors=256
let g:indentLine_color_term = 239
let g:indentLine_char = '|' " ¦, ┆

" Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_ruby_hanging_args = 1
let g:splitjoin_ruby_curly_braces = 0

" Ему нужен tabular
" Plug 'plasticboy/vim-markdown'

"https://github.com/majutsushi/tagbar/wiki#coffeescript
let g:tlist_coffee_settings = 'coffee;f:function;v:variable'
"let g:CoffeeAutoTagFile=<filename>       " Name of the generated tag file (Default: ./tags)
"let g:CoffeeAutoTagIncludeVars=<0 or 1>  " Includes variables (Default: 0 [false])
"let g:CoffeeAutoTagTagRelative=<0 or 1>  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])
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

