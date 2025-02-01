
" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin()

" Plug 'ellisonleao/gruvbox.nvim'
Plug 'dapi/gruvbox', { 'do': 'cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors' } 
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible' " a universal set of default
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'sickill/vim-pasta' " This plugin remaps p and P (put command) in normal and visual mode to do context aware pasting
Plug 'tpope/vim-sleuth' " Heuristically set buffer options ('shiftwidth' and 'expandtab')


" System adminstration
"
"""""""""""""""""""
Plug 'chr4/nginx.vim'
Plug 'towolf/vim-helm'
Plug 'erikzaadi/vim-ansible-yaml'
Plug 'pearofducks/ansible-vim'

"""""""""""""""""""""
" Motion helpers (TODO
"

""""""""""""""""""""""
" Software Development
"
Plug 'kien/rainbow_parentheses.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'yegappan/mru'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'Shougo/vimproc.vim'
Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
" Plug 'gorkunov/smartpairs.vim'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-repeat' Должен быть ДО easyclip


""""""""""""""""""""""""
" Tags management, autocomplete, searches
"
Plug 'grassdog/tagman.vim'
Plug 'ludovicchabant/vim-gutentags' " Automatic ctags management for Vim
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


"""""""""""""""""""""""""""
" Ruby Development
"
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
" Plug 'noprompt/vim-yardoc'


""""""""""""""""""
"
" Web-development. Javascript and HTML
"
""""""""""""""""""
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim' " YATS: Yet Another TypeScript Syntax
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'othree/xml.vim'
Plug 'slim-template/vim-slim'
Plug 'prettier/vim-prettier'
" Plug 'jbgutierrez/vim-babel'
 
" Syntax file for JavaScript libraries. 
Plug 'isRuslan/vim-es6'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'

Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less' " vim syntax for LESS (dynamic CSS)
Plug 'mxw/vim-jsx'


""""""""""""""""""""""
" Other languages
"
Plug 'tpope/vim-liquid'
Plug 'fatih/vim-go'
Plug 'elzr/vim-json'
call plug#end()
