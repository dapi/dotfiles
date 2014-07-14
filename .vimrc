" Install Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Install vundles
" :PluginInstall
 "
 " Brief help
 " :PluginList          - list configured bundles
 " :PluginInstall(!)    - install(update) bundles
 " :PluginSearch(!) foo - search(or refresh cache first) for foo
 " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Plugin command are not allowed..
 
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

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Для textobject-а
runtime macros/matchit.vim

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'
Plugin 'kikijump/tslime.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'jelera/vim-javascript-syntax'


" My Plugins here:
"
" original repos on github
Plugin 'groenewege/vim-less'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-pasta'
"Plugin 'Lokaltog/powerline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
"Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
" cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
" Plugin 'flazz/vim-colorschemes'
" # after downloading; unpacking; cd'ing
" cp colors/* ~/.vim/colors
Plugin 'mxw/vim-jsx'

Plugin 'cakebaker/scss-syntax.vim'

Plugin 'ervandew/supertab'

" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
" non github repos
" Plugin 'git://git.wincent.com/command-t.git'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'bling/vim-airline'
" git repos on your local machine (ie. when working on your own plugin)
"Plugin 'file:///Users/gmarik/path/to/plugin'
" ...

Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

Plugin 'scrooloose/syntastic'

Plugin 'othree/html5.vim'
Plugin 'othree/xml.vim'

set list lcs=tab:\|\ 
"Plugin 'Yggdroot/indentLine'
"let g:indentLine_color_term = 239
"let g:indentLine_char = '|' " ¦, ┆

" Включить <Leader>ig
"Plugin 'nathanaelkane/vim-indent-guides'


set tabstop=2 shiftwidth=2 expandtab
syntax enable
filetype plugin indent on     " required!
set nohlsearch

"color desert
" colorscheme solarized
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
