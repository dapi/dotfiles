" Install Vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 
" Install vundles
" :BundleInstall
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
 
imap ;; <Esc>
set nocompatible                " be iMproved
syntax on
filetype off                    " required!
set t_Co=256
"set list lcs=tab:' '
set tags+=gems.tags
set fileformat=unix

set tabstop=2
set softtabstop=2
set shiftwidth=2
"#set expandtab

" Show line numbers
set nu

set t_Co=256
let g:solarized_termcolors=256
if !has("gui_running")
   let g:gruvbox_italic=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Для textobject-а
runtime macros/matchit.vim

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'kikijump/tslime.vim'
Bundle 'guns/vim-clojure-static'
Bundle 'jelera/vim-javascript-syntax'


" My Bundles here:
"
" original repos on github
Bundle 'groenewege/vim-less'
"Bundle 'altercation/vim-colors-solarized'
Bundle 'sickill/vim-pasta'
"Bundle 'Lokaltog/powerline'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
"Bundle 'tpope/vim-fugitive'
Bundle 'morhetz/gruvbox'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'kien/ctrlp.vim'
Bundle 'mxw/vim-jsx'

Bundle 'groenewege/vim-less'
Bundle 'cakebaker/scss-syntax.vim'

Bundle 'ervandew/supertab'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'bling/vim-airline'
" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'

Bundle 'scrooloose/syntastic'

Bundle 'othree/html5.vim'
Bundle 'othree/xml.vim'

set list lcs=tab:\|\ 
Bundle 'Yggdroot/indentLine'
"let g:indentLine_color_term = 239
"let g:indentLine_char = '|' " ¦, ┆

" Включить <Leader>ig
"Bundle 'nathanaelkane/vim-indent-guides'


set tabstop=2 shiftwidth=2 expandtab
syntax enable
filetype plugin indent on     " required!
set nohlsearch

"color desert
"colorscheme solarized
colorscheme gruvbox
set background=dark 

au BufRead,BufNewFile *.hamlc set filetype=haml
au BufRead,BufNewFile {Guardfile,Gemfile.lock,Procfile}    set ft=ruby
au BufNewFile,BufRead *.sql setf pgsql
au BufRead,BufNewFile *.csxj set filetype=coffee

set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/assets*,tmp/*,app/assets/images*,public/ima,coverage/*,public/*,vendor/assets/*,.sass-cache/*,solr/*,*/uploads/*,doc/*,doc

" http://www.pixelbeat.org/settings/.vimrc


" Автодополнение как в bash
set wildmode=longest,list,full
set wildmenu

nnoremap <Leader>e :CtrlP<CR>
nmap ; :CtrlPBuffer<CR>

" ctrlP
" the nearest ancestor that contains one of these directories or files: .git
let g:ctrlp_working_path_mode = 2
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" vim-pasta
let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml', 'csxj']

" airline
set laststatus=2

"set paste
"set nopaste
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

autocmd BufRead,BufNewFile *.hamlc set filetype=haml
 filetype plugin indent on     " required!

autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 expandtab
au BufRead,BufNewFile {Guardfile,Gemfile.lock,Procfile}    set ft=ruby

set tags+=gems.tags

set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/assets*,tmp/*,app/assets/images*,public/ima,coverage/*,public/*,vendor/assets/*,.sass-cache/*,solr/*,*/uploads/*,doc/*,doc

" http://www.pixelbeat.org/settings/.vimrc


" Автодополнение как в bash
set wildmode=longest,list,full
set wildmenu

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" vim-pasta
let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml']


" jumps in edit mode
" https://coderwall.com/p/fd_bea
"
imap <C-e> <C-o>$
imap <C-a> <C-o>0