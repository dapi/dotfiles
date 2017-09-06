" Install Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
" :PluginInstall
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" :so ~/.vimrc

" jumps in edit mode
" https://coderwall.com/p/fd_bea
"
imap <C-e> <C-o>$
imap <C-a> <C-o>0

set clipboard=unnamed

set encoding=utf-8

"imap jk <Esc>
"imap kj <Esc>
"imap ;; <Esc>

" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"imap ;; <Esc>

set nocompatible                " be iMproved
filetype off                    " required!

" https://github.com/junegunn/fzf
set rtp+=~/.fzf
nnoremap <silent> <C-p> :FZF<cr>

set rtp+=~/.vim/bundle/vundle/

call vundle#begin()
" let Vundle manage Vundle
" required! 
Plugin 'pearofducks/ansible-vim'
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-sensible'
Plugin 'kien/rainbow_parentheses.vim'

" classpath.vim: Set 'path' from the Java class path
" Plugin 'tpope/vim-classpath'
"
" salve.vim: static support for Leiningen and Boot
" Plugin 'tpope/vim-salve'
"
" Plugin 'tpope/vim-projectionist'
"
" dispatch.vim: asynchronous build and test dispatcher 
" Plugin 'tpope/vim-dispatch'

" :saveas
" Plugin 'Rename'

" Evaluate Clojure buffers on load
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry
autocmd Syntax clojure EnableSyntaxExtension
autocmd VimEnter *       RainbowParenthesesToggle
autocmd Syntax   clojure RainbowParenthesesLoadRound
autocmd Syntax   clojure RainbowParenthesesLoadSquare
autocmd Syntax   clojure RainbowParenthesesLoadBraces

" https://github.com/clojuredocs/guides/blob/master/articles/tutorials/vim_fireplace.md
"
" `cpr` (my mnemonic: clojure please require) takes the content from the active buffer and requires it inside the REPL.
" `cpp` (my mnemonic: clojure please print) evaluates the outermost form under the cursor and prints it at the bottom of the screen.
" `cqp` (my mnemonic: clojure quick print) gives you a one-line REPL prompt at the bottom of the screen (for quick one-liner evals).
" cqc to bring up a command-line window similar to what you'd get with q: in normal Vim
" `[` jumps to the definition for the symbol under your cursor, even if it’s inside the Clojure source!
" `K` gives you documentation for symbol under cursor.
" `:A` takes you to the test (if you’re in the implementation) or vice-versa,
" and `:AS` or `:AV` gives it to you in a horizontal or vertical split.
"
" Hit % to jump to the matching paren.
" Hit d% to delete the parens and everything they contain.
" Hit y% to "yank"/copy the parens and everything in them.
" Hit c% to delete the parens and the text they contain and start editing.
" Hit v% to select the parens and the text they contain visually.
"
" Hit dab ("delete all block") to delete the entire form.
" Hit cab ("change all block") to delete the entire form and enter insert mode.
" Hit yab ("yank all block") to copy the entire form including parens.
"
" fireplace.vim: Clojure REPL support
" Plugin 'tpope/vim-fireplace'

" Sparkup lets you write HTML code faster. 
" div#header expands to:   <div id="header"></div>
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Legacy. Не используется из-за слабой поддержки ES6
" Plugin 'jelera/vim-javascript-syntax'

" YAJS.vim: Yet Another JavaScript Syntax for Vim
Plugin 'othree/yajs.vim'
Plugin 'isRuslan/vim-es6'

" Plugin 'randunel/vim-javascript'
"
" Babel shows how the current file or a snippet of Javascript will be
" transformed by Babel.
" Plugin 'jbgutierrez/vim-babel'
"
" Syntax file for JavaScript libraries. 
Plugin 'othree/javascript-libraries-syntax.vim'

Plugin 'othree/es.next.syntax.vim'

let g:used_javascript_libs = 'react'

" Vim plugin for managing ctags files
Plugin 'grassdog/tagman.vim'

Plugin 'kchmck/vim-coffee-script'
Plugin 'mtscout6/vim-cjsx'

" vim syntax for LESS (dynamic CSS)
Plugin 'groenewege/vim-less'

Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Ruby syntax extensions for highlighting YARD documentation.
" Plugin 'noprompt/vim-yardoc'

" Plugin 'guns/vim-clojure-static'
" Plugin 'guns/vim-clojure-highlight'
"
Plugin 'cakebaker/scss-syntax.vim'

Plugin 'tpope/vim-liquid'

" Plugin 'lukaszkorecki/CoffeeTags'

"Plugin 'sjbach/lusty'
":LustyFilesystemExplorer
":LustyFilesystemExplorerFromHere
":LustyBufferExplorer
":LustyBufferGrep (for searching through all open buffers)

"<Leader>lf  - Opens filesystem explorer.
"<Leader>lr  - Opens filesystem explorer at the directory of the current file.
"<Leader>lb  - Opens buffer explorer.
"<Leader>lg  - Opens buffer grep. - самая фишка
"Plugin 'techlivezheng/vim-plugin-minibufexpl'

"Plugin 'bling/vim-bufferline'

" Vim 'goto file' on steroids!
" uses ctags and the_silver_searcher
Plugin 'gorkunov/smartgf.vim'
" gF smart find file at cursor definition
map <F5> :SmargfRefreshTags<CR>

"
" Plugin 'majutsushi/tagbar'
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
"
" original repos on github
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256

Plugin 'sickill/vim-pasta'

" Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
" Run NERD if there is not files opened
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim is there is NERD only
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" nnoremap <F2> :NERDTreeTabsToggle<CR>
" map <C-n> :NERDTreeToggle<CR>

Plugin 'scrooloose/nerdcommenter'
" [count]<leader>cc |NERDComComment|
" [count]<leader>cn |NERDComNestedComment|

" gcc Use gcc to comment out a line (takes a count),
" gc to comment out the target of a motion
" gcap  to comment out a paragraph
Plugin 'tpope/vim-commentary'

Plugin 'kana/vim-textobj-user'

" Для textobject-а
runtime macros/matchit.vim

" vir - select inner ruby block
" var - select all method definitios
Plugin 'nelstrom/vim-textobj-rubyblock'

"am      "a method", select from "def" until matching "end"
"im      "inner method", select contents of "def"/"end" block,
"aM      "a class", select from "class" until matching "end"
"iM      "inner class", select contents of "class"/"end" "block, excluding the "class" and "end" themselves.
Plugin 'vim-ruby/vim-ruby'

" Plugin 'ngmy/vim-rubocop'

" <lead><lead>w - o trigger the word motion w
"      <cursor>Lorem {a}psum {b}olor {c}it {d}met.
" Plugin 'Lokaltog/vim-easymotion'

" f you've ever tried using the . command after a plugin map, you were likely
" disappointed to discover it only repeated the last native command inside
" that map, rather than the map as a whole. That disappointment ends today.
" Repeat.vim remaps . in a way that plugins can tap into it.
"
" Должен быть ДО easyclip
" Plugin 'tpope/vim-repeat'

" не подключился
"Plugin 'svermeulen/vim-easyclip'

" : Gcommit
" Plugin 'tpope/vim-fugitive'

" Heuristically set buffer options
" tpope/vim-sleuth

" Want to turn fooBar into 
" foo_bar? Press crs (coerce to snake_case).
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru) are
Plugin 'tpope/vim-abolish'

" gq - auto format (wrap long comment lines)
"
" <lead>==
" Plugin 'KurtPreston/vim-autoformat-rails'
" Plugin 'Chiel92/vim-autoformat'

" gJ - join lines
" gS - split lines
Plugin 'AndrewRadev/splitjoin.vim'
let g:splitjoin_ruby_hanging_args = 1
let g:splitjoin_ruby_curly_braces = 0


Plugin 'tpope/vim-rails'
" :A - Alternative file
" :R - Related
" gf - goto file
" :Emodel - goto model
" :Rextract partial

" Plugin 'stefanoverna/vim-i18n'
" Visual select and `:call I18nTranslateString()`
vmap <Leader>z :call I18nTranslateString()<CR>

" vinegar.vim: combine with netrw to create a delicious salad dressing

" Plugin 'tpope/vim-vinegar'
" http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
" Press - in any buffer to hop up to the directory listing and seek 
" I -  to toggle until you adapt.
" Press . on a file to pre-populate it at the end of a : command line. -

" window splitting
" <c-w>s - horixontal
" <c-w>v - vertical
" http://vimcasts.org/images/blog/cell-division.png

" This is a simple vim script to send portion of text from a vim buffer to a
" running tmux session.
"Plugin 'jgdavey/tslime.vim'



" Plugin 'janx/vim-rubytest'
"
Plugin 'achm/vim-rspec'
let g:RspecBin = 'spring rspec'
map <Leader>T :RunSpec<CR>
map <Leader>S :RunSpecLine<CR>

Plugin 'thoughtbot/vim-rspec', {'name': 'vim-rspec-thoughbot'}
" With tslime
" В этом случае выводится в терминале
let g:rspec_command = '!spring rspec {spec}'
" В этом случае выводится в quickfix
"let g:rspec_command = 'Dispatch spring rspec {spec}'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" Plugin 'kien/ctrlp.vim'
set wildignore+=*.log,*.o,*.obj,.git,*.rbc,*.class,.svn,.sass-cache/*,solr/*,*tags,*.lock
set wildignore+=*/images/*,*/tmp/*,*/coverage/*,*/uploads/*,*/node_modules/*,*/dist/*
set wildignore+=*/vendor/gems/*,*/vendor/static/* " ,*/vendor/assets/*
set wildignore+=public/*
" set wildignore+=*/scripts/*,*/doc/*,*/bin/*
set wildignore+=*/doc/*,*/bin/*
" Отключил в пользу FZF
"nnoremap <Leader>e :CtrlP<CR>
"nnoremap <leader>. :CtrlPTag<cr>
"
"let g:ctrlp_cmd = 'CtrlPMRU'
":CtrlPBuffer
" ctrl-<f> - cicles between modes
" the nearest ancestor that contains one of these directories or files: .git
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)|bin$',
      \ 'file': '\v\.(exe|so|dll|bin/rake)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

" Plugin 'sgur/ctrlp-extensions.vim'
" CtrlPCmdline
" CtrlPYankring
" CtrlPMenu

" Plugin 'mhinz/vim-startify'
":SLoad    load a session
":SSave    save a session
":SDelete  delete a session

" Plugin 'flazz/vim-colorschemes'
" # after downloading; unpacking; cd'ing
" cp colors/* ~/.vim/colors



" Plugin 'mileszs/ack.vim'
"if executable('ag')
" let g:ackprg = 'ag --nogroup --nocolor --column'
"let g:ackprg = 'ag --vimgrep'
"endif
"
" Plugin 'rking/ag.vim'

" The Most Recently Used (MRU) plugin provides an easy access to a list of 
" recently opened/edited files in Vim. This plugin automatically stores the 
" file names as you open/edit them in Vim. 
Plugin 'yegappan/mru'

" vim-scripts repos
"Plugin 'L9'
"Plugin 'FuzzyFinder'
" non github repos
"Plugin 'git://git.wincent.com/command-t.git'


" cs{( to change { on (
" ysiw] обернуть слово в ]
" https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'
Plugin 'gorkunov/smartpairs.vim'
" vi* -> viv
" va* -> vav
" ci* -> civ
" ca* -> cav
" di* -> div
" da* -> dav
" yi* -> yiv
" ya* -> yav
" Where * is in <, >, ", ', `, (, ), [, ], {, } or t as tag

"Plugin 'tpope/vim-unimpaired'
" alternative QuickFixCurrentNumber
" http://www.vim.org/scripts/script.php?script_id=4449
"
" http://choorucode.com/2014/11/06/how-to-use-syntastic-plugin-for-vim/
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
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
" let g:syntastic_javascript_checkers = ['eslint']

Plugin 'othree/html5.vim'
Plugin 'othree/xml.vim'
Plugin 'slim-template/vim-slim'

"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'garbas/vim-snipmate'
Plugin 'ervandew/supertab'
" <c-n> <c-p> to move curson in completion list

" A Vim plugin which shows a git diff in the gutter (sign column) and
" stages/undoes hunks.
" Plugin 'airblade/vim-gitgutter'

Plugin 'dapi/gruvbox'
if !has("gui_running")
  let g:gruvbox_italic=0
endif

Plugin 'editorconfig/editorconfig-vim'

" cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors
" https://github.com/hukl/Smyck-Color-Scheme
" https://github.com/endel/vim-github-colorscheme

"Plugin 'Shougo/unite.vim'
" Unite
"nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>
"nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>
"nnoremap <Leader>f :Unite grep:.<cr>

Plugin 'terryma/vim-multiple-cursors'
" Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

Plugin 'bling/vim-airline'
"let g:airline_enable_syntastic = 1
"let g:airline#extensions#syntastic#enabled = 1
" only on mac
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1

Plugin 'junegunn/vim-easy-align'
vmap <Enter> :EasyAlign<CR>
nmap ga :EasyAlign<CR>
" vip<Enter>=
" gaip=

" Plugin 'godlygeek/tabular'
" nmap <Leader>a= :Tabularize /=<CR>
" vmap <Leader>a= :Tabularize /=<CR>
" nmap <Leader>a: :Tabularize /:\zs<CR>
" vmap <Leader>a: :Tabularize /:\zs<CR>

" Ему нужен tabular
Plugin 'plasticboy/vim-markdown'

" Plugin 'mbbill/undotree'

" Vim Workspace Controller
" Это та самая штука, которая выводит количество файлов табе буффера
" Plugin 'szw/vim-ctrlspace'
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

call vundle#end() 

"https://github.com/majutsushi/tagbar/wiki#coffeescript
let g:tlist_coffee_settings = 'coffee;f:function;v:variable'
"let g:CoffeeAutoTagFile=<filename>       " Name of the generated tag file (Default: ./tags)
"let g:CoffeeAutoTagIncludeVars=<0 or 1>  " Includes variables (Default: 0 [false])
"let g:CoffeeAutoTagTagRelative=<0 or 1>  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

syntax on
"set t_Co=256
"
" С такой настройкой нормльно работает фон в tmux на vagrant-е
set term=screen-256color
"set term=xterm-256color
"set list lcs=tab:' '
"http://andrew.stwrt.ca/posts/vim-ctags
":CtrlPTag
set tags+=gems.tags
set fileformat=unix

set tabstop=2
set softtabstop=2
set shiftwidth=2
"#set expandtab

set colorcolumn=160
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>120v.\+/
"match OverLength /\%81v.\+/

" Show line numbers
set nu

set list lcs=tab:\|\ 

Plugin 'Yggdroot/indentLine'
let g:indentLine_color_term = 239
let g:indentLine_char = '|' " ¦, ┆
"
"
" Включить <Leader>ig
Plugin 'nathanaelkane/vim-indent-guides'
hi IndentGuidesOdd  ctermbg=235 
hi IndentGuidesEven ctermbg=4

" Plugin 'michaeljsmith/vim-indent-object'
" <count>ai         (A)n (I)ndentation level and line above.
" <count>ii         (I)nner (I)ndentation level (no line above).
" <count>aI         (A)n (I)ndentation level and lines above/below.
" <count>iI         (I)nner (I)ndentation level (no lines above/below).

" Plugin 'tpope/vim-markdown'

set tabstop=2 shiftwidth=2 expandtab softtabstop=2
syntax enable       " Enable syntax highlighting
filetype on         " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins

set autowrite                  " automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')

"color desert
" colorscheme solarized
"
" Почему-то не подключается по-умолчанию
colorscheme gruvbox
set background=dark 

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
" au BufRead,BufNewFile {Makefile} setlocal noexpandtab shiftwidth=8 softtabstop=0
au BufRead,BufNewFile *.hamlc set filetype=haml
au BufRead,BufNewFile {Guardfile,Gemfile.lock,Procfile}    set ft=ruby
au BufNewFile,BufRead *.sql setf pgsql
au BufRead,BufNewFile *.cjsx set filetype=coffee
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.cljx setfiletype clojure
au BufRead,BufNewFile *.md setlocal textwidth=80

"autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
"autocmd BufNewFile,BufRead *.jsx set filetype=javascript

autocmd FileType make 
      \ setlocal noexpandtab shiftwidth=8 softtabstop=0

" Remove trailing spaces
" http://www.bestofvim.com/tip/trailing-whitespace/
autocmd FileType ruby,javascript
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

" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Leader>y :w! ~/.vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! ~/.vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r ~/.vbuf<CR>

" CtrlP search
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('file_rec/async','sorters','sorter_rank')
" replacing unite with ctrl-p
"nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

set showbreak=↪ 

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
