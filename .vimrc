
" Install vim-plug
" https://github.com/junegunn/vim-plug

" jumps in edit mode
" https://coderwall.com/p/fd_bea
"
imap <C-e> <C-o>$
imap <C-a> <C-o>0

set clipboard=unnamed

set encoding=utf-8

set nocompatible                " be iMproved
filetype off                    " required!

call plug#begin()

Plug 'editorconfig/editorconfig-vim' " Respect .editorconfig

Plug 'tpope/vim-pathogen'
Plug 'towolf/vim-helm'

Plug 'erikzaadi/vim-ansible-yaml'
" set tabstop=2 shiftwidth=2 expandtab
" retab
Plug 'pearofducks/ansible-vim'
au BufReadPost,BufNewFile */playbooks/*.yml,*/ansible*/*.yml,playbook.yml set filetype=yaml.ansible

"augroup ansible_vim_fthosts
  "autocmd!
  "autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
"augroup END
" au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
" let g:ansible_unindent_after_newline = 0

" Plugin 'fatih/vim-go'
" set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
Plug 'fatih/vim-go'
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

Plug 'chr4/nginx.vim'

" Plug 'syngan/vim-vimlint'
" Plug 'vim-vimlparser'

" Plug 'gmarik/vundle'
Plug 'tpope/vim-sensible'
Plug 'kien/rainbow_parentheses.vim'

" Plug 'tomlion/vim-solidity'

" Plugin 'tomlion/vim-solidity'

Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" classpath.vim: Set 'path' from the Java class path
" Plug 'tpope/vim-classpath'
"
" salve.vim: static support for Leiningen and Boot
" Plug 'tpope/vim-salve'
"
" Plug 'tpope/vim-projectionist'
"
" dispatch.vim: asynchronous build and test dispatcher 
" Plug 'tpope/vim-dispatch'

" :saveas
" Plug 'Rename'

" Evaluate Clojure buffers on load
"autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry
"autocmd Syntax clojure EnableSyntaxExtension
"autocmd VimEnter *       RainbowParenthesesToggle
"autocmd Syntax   clojure RainbowParenthesesLoadRound
"autocmd Syntax   clojure RainbowParenthesesLoadSquare
"autocmd Syntax   clojure RainbowParenthesesLoadBraces

Plug 'HerringtonDarkholme/yats.vim' " YATS: Yet Another TypeScript Syntax

" Plug 'randunel/vim-javascript'
"
" Babel shows how the current file or a snippet of Javascript will be
" transformed by Babel.
" Plug 'jbgutierrez/vim-babel'
"
" Syntax file for JavaScript libraries. 
Plug 'isRuslan/vim-es6'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'

" Make your Vim/Neovim as smart as VS Code
" Не получилось с зависимостями, добить позже
" Plug 'neoclide/coc.nvim'

let g:used_javascript_libs = 'react'

" Tagman will only build tag files if a tag file already exists. You can enable tags for a project by running :BuildTags!.
Plug 'grassdog/tagman.vim'

" Gutentags is a plugin that takes care of the much needed management of tags files in Vim. It will (re)generate tag files as you work while staying completely out of your way. It will even do its best to keep those tag files out of your way too. It has no dependencies and just works.
Plug 'ludovicchabant/vim-gutentags' " Automatic ctags management for Vim

Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'

" vim syntax for LESS (dynamic CSS)
Plug 'groenewege/vim-less'

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'elzr/vim-json'
" Ruby syntax extensions for highlighting YARD documentation.
" Plug 'noprompt/vim-yardoc'

" Plug 'guns/vim-clojure-static'
" Plug 'guns/vim-clojure-highlight'
"
Plug 'cakebaker/scss-syntax.vim'

Plug 'tpope/vim-liquid'

" Plug 'lukaszkorecki/CoffeeTags'

"Plug 'sjbach/lusty'
":LustyFilesystemExplorer
":LustyFilesystemExplorerFromHere
":LustyBufferExplorer
":LustyBufferGrep (for searching through all open buffers)

"<Leader>lf  - Opens filesystem explorer.
"<Leader>lr  - Opens filesystem explorer at the directory of the current file.
"<Leader>lb  - Opens buffer explorer.
"<Leader>lg  - Opens buffer grep. - самая фишка
"Plug 'techlivezheng/vim-plugin-minibufexpl'

"Plug 'bling/vim-bufferline'

" Vim 'goto file' on steroids!
" uses ctags and the_silver_searcher
" Plug 'gorkunov/smartgf.vim'
" gF smart find file at cursor definition
" map <F5> :SmargfRefreshTags<CR>

"
" Plug 'majutsushi/tagbar'
" :ts[elect][!] [ident]
" :tj[ump][!] [ident]
" g CTRL-] - перескок с выбором вариантов
" CTRL-T - возврат обратно
" let g:airline#extensions#tagbar#enabled = 1
" let g:airline#extensions#tagbar#flags = ''
"let g:airline#extensions#tagbar#flags = 'f'
"let g:airline#extensions#tagbar#flags = 's'
"let g:airline#extensions#tagbar#flags = 'p'
" nmap <F8> :TagbarToggle<CR>
"let g:tagbar_type_javascript = {
      "\ 'ctagstype' : 'JavaScript',
      "\ 'kinds'     : [
      "\ 'o:objects',
      "\ 'f:functions',
      "\ 'a:arrays',
      "\ 's:strings',
      "\ 'v:variables'
      "\ ]
      "\ }

" My Plugins here:
" original repos on github
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256

Plug 'sickill/vim-pasta'

" Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
" Run NERD if there is not files opened
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim is there is NERD only
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" nnoremap <F2> :NERDTreeTabsToggle<CR>
" map <C-n> :NERDTreeToggle<CR>

Plug 'scrooloose/nerdcommenter'
" [count]<leader>cc |NERDComComment|
" [count]<leader>cn |NERDComNestedComment|

" gcc Use gcc to comment out a line (takes a count),
" gc to comment out the target of a motion
" gcap  to comment out a paragraph
Plug 'tpope/vim-commentary'

Plug 'kana/vim-textobj-user'

" Для textobject-а
runtime macros/matchit.vim

" vir - select inner ruby block
" var - select all method definitios
Plug 'nelstrom/vim-textobj-rubyblock'

"am      "a method", select from "def" until matching "end"
"im      "inner method", select contents of "def"/"end" block,
"aM      "a class", select from "class" until matching "end"
"iM      "inner class", select contents of "class"/"end" "block, excluding the "class" and "end" themselves.
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

" Plug 'ngmy/vim-rubocop'

" <lead><lead>w - o trigger the word motion w
"      <cursor>Lorem {a}psum {b}olor {c}it {d}met.
" Plug 'Lokaltog/vim-easymotion'

" f you've ever tried using the . command after a plugin map, you were likely
" disappointed to discover it only repeated the last native command inside
" that map, rather than the map as a whole. That disappointment ends today.
" Repeat.vim remaps . in a way that plugins can tap into it.
"
" Должен быть ДО easyclip
" Plug 'tpope/vim-repeat'

" не подключился
"Plug 'svermeulen/vim-easyclip'

" : Gcommit
" Plug 'tpope/vim-fugitive'

" Heuristically set buffer options
Plug 'tpope/vim-sleuth'

" Want to turn fooBar into 
" foo_bar? Press crs (coerce to snake_case).
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru) are
Plug 'tpope/vim-abolish'

Plug 'prettier/vim-prettier'

Plug 'Shougo/vimproc.vim'

" gq - auto format (wrap long comment lines)
"
" <lead>==
" Plug 'KurtPreston/vim-autoformat-rails'
" Plug 'Chiel92/vim-autoformat'

" gJ - join lines
" gS - split lines
Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_ruby_hanging_args = 1
let g:splitjoin_ruby_curly_braces = 0

" :A - Alternative file
" :R - Related
" gf - goto file
" :Emodel - goto model
" :Rextract partial

" 
"Plug 'benjmin-r/vim-i18n'
"vmap <Leader>z :call I18nTranslateString()<CR>
"vmap <Leader>dt :call I18nDisplayTranslation()<CR>

"Plug 'airblade/vim-localorie'
"nnoremap <silent> <leader>lt :call localorie#translate()<CR>
"nnoremap <silent> <leader>le :call localorie#expand_key()<CR>

" vinegar.vim: combine with netrw to create a delicious salad dressing

" Plug 'tpope/vim-vinegar'
" http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
" Press - in any buffer to hop up to the directory listing and seek 
" I -  to toggle until you adapt.
" Press . on a file to pre-populate it at the end of a : command line. -

" window splitting
" <c-w>s - horixontal
" <c-w>v - vertical
" http://vimcasts.org/images/blog/cell-division.png

set wildignore+=*.log,*.o,*.obj,.git,*.rbc,*.class,.svn,.sass-cache/*,solr/*,*tags,*.lock
set wildignore+=*/images/*,*/tmp/*,*/coverage/*,*/uploads/* " ,*/node_modules/*,*/dist/*
" set wildignore+=*/vendor/gems/*,*/vendor/static/* " ,*/vendor/assets/*
set wildignore+=public/*
" set wildignore+=*/scripts/*,*/doc/*,*/bin/*
set wildignore+=*/doc/*,*/bin/*

" Plug 'flazz/vim-colorschemes'
" # after downloading; unpacking; cd'ing
" cp colors/* ~/.vim/colors

" The Most Recently Used (MRU) plugin provides an easy access to a list of 
" recently opened/edited files in Vim. This plugin automatically stores the 
" file names as you open/edit them in Vim. 
Plug 'yegappan/mru'



"""""""""""""""""""
" Fuzzy finders section
"""""""""""""""""""
"
" CTRL-T, CTRL-X or CTRL-V to open selected files in the current window, 
" in new tabs, in horizontal splits, or in vertical splits respectively.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
nnoremap <silent> <C-p> :FZF<cr>

" cs{( to change { on (
" ysiw] обернуть слово в ]
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
Plug 'gorkunov/smartpairs.vim'
" vi* -> viv
" va* -> vav
" ci* -> civ
" ca* -> cav
" di* -> div
" da* -> dav
" yi* -> yiv
" ya* -> yav
" Where * is in <, >, ", ', `, (, ), [, ], {, } or t as tag

"Plug 'tpope/vim-unimpaired'
" alternative QuickFixCurrentNumber
" http://www.vim.org/scripts/script.php?script_id=4449
"
" http://choorucode.com/2014/11/06/how-to-use-syntastic-plugin-for-vim/
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
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

nnoremap <leader>f mF:%!yarn run --silent eslint_d --stdin --fix-to-stdout<CR>`F

Plug 'othree/xml.vim'
Plug 'slim-template/vim-slim'

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'garbas/vim-snipmate'
Plug 'ervandew/supertab'
" <c-n> <c-p> to move curson in completion list

" A Vim plugin which shows a git diff in the gutter (sign column) and
" stages/undoes hunks.
" Plug 'airblade/vim-gitgutter'

" Plug 'ellisonleao/gruvbox.nvim'
Plug 'dapi/gruvbox', { 'do': 'cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors' } 
if !has("gui_running")
  let g:gruvbox_italic=0
endif
"

"Plug 'Shougo/unite.vim'
" Unite
"nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>
"nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>
"nnoremap <Leader>f :Unite grep:.<cr>

Plug 'terryma/vim-multiple-cursors'
" Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

Plug 'bling/vim-airline'
"let g:airline_enable_syntastic = 1
"let g:airline#extensions#syntastic#enabled = 1
" only on mac
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1

Plug 'junegunn/vim-easy-align'
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

Plug 'Yggdroot/indentLine'
let g:indentLine_color_term = 239
let g:indentLine_char = '|' " ¦, ┆
"
"
" Включить <Leader>ig
Plug 'nathanaelkane/vim-indent-guides'
hi IndentGuidesOdd  ctermbg=235 
hi IndentGuidesEven ctermbg=4

" Plug 'michaeljsmith/vim-indent-object'
" <count>ai         (A)n (I)ndentation level and line above.
" <count>ii         (I)nner (I)ndentation level (no line above).
" <count>aI         (A)n (I)ndentation level and lines above/below.
" <count>iI         (I)nner (I)ndentation level (no lines above/below).

" Plug 'tpope/vim-markdown'

call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" Выполняется после plug#end()
set background=dark " or light if you want light mode
colorscheme gruvbox

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

syntax enable       " Enable syntax highlighting
filetype on         " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins

set autowrite                  " automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')

" Fix rubocop: Align the parameters of a method call if they span more than
" one line.
" http://stackoverflow.com/questions/88931/lining-up-function-parameter-lists-with-vim
" https://github.com/sportngin/styleguide/issues/21
" :help cinoptions-values
" auto indent arguments
set cino=(0<Enter>

" remember last position in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

au BufRead,BufNewFile {Makefile} set filetype=make
au BufRead,BufNewFile Makefile set filetype=make
au BufRead,BufNewFile *.tsx set filetype=typescript
" au BufReadPost,BufNewFile {Makefile} setlocal noexpandtab shiftwidth=8 softtabstop=0

au BufRead,BufNewFile *.hamlc set filetype=haml
au BufRead,BufNewFile {Guardfile,Gemfile.lock,Procfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.sql setf pgsql
au BufRead,BufNewFile *.cjsx set filetype=coffee
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.rb setlocal textwidth=160
au BufRead,BufNewFile *.axlsx set filetype=ruby
set colorcolumn=160
au BufReadPost,BufNewFile *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 expandtab
au BufReadPost,BufNewFile *.cljx setfiletype clojure
au BufReadPost,BufNewFile *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4

"autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
"autocmd BufNewFile,BufRead *.jsx set filetype=javascript

autocmd FileType make 
      \ setlocal noexpandtab shiftwidth=4 softtabstop=0

autocmd BufNewFile,BufRead *.axlsx set filetype=ruby
 
" Remove trailing spaces
" http://www.bestofvim.com/tip/trailing-whitespace/
autocmd FileType ruby,javascript,css
      \ autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType python
      \ setlocal ai si et sta sw=4
      \ textwidth=80 backspace=indent,eol,start fo=croql


" Автодополнение как в bash
set wildmode=longest,list,full
set wildmenu


" airline
set laststatus=2

"set paste
"set nopaste
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
"nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" vim-pasta
let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml', 'cjsx']

setlocal spell spelllang=en_us
set showmode

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" case insensitive search
set smartcase
set ignorecase

" jumps in edit mode
" https://coderwall.com/p/fd_bea
"
imap <C-e> <C-o>$
imap <C-a> <C-o>0


" Switch to alternate file
" gvim
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>

map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

set showbreak=↪ 

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

if has('nvim')
  source ~/dotfiles/vim/neovim.vim
else
  source ~/dotfiels/vim/classic.vim
endif

" Вставляем символ TAB через Shift-TAB
inoremap <S-Tab> <C-V><Tab>

"
" autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml set ft=helm
autocmd FileType yaml execute  ':silent! %s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
"Plug 'stephpy/vim-yaml'
autocmd BufNewFile,BufRead *.yaml,*.yml set ft=yaml
autocmd BufNewFile,BufRead .envrc set ft=sh

" Use {{/* */}} as comments
autocmd FileType helm setlocal commentstring={{/*\ %s\ */}}
