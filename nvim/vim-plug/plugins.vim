
" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin()

" Theme and visual
"
Plug 'dapi/gruvbox', { 'do': 'cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors' } 

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'folke/which-key.nvim'

Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible' " a universal set of default
Plug 'sickill/vim-pasta' " This plugin remaps p and P (put command) in normal and visual mode to do context aware pasting
Plug 'tpope/vim-sleuth' " Heuristically set buffer options ('shiftwidth' and 'expandtab')

" Text manipulation
Plug 'scrooloose/nerdcommenter' " Ctrl-C
Plug 'mg979/vim-visual-multi' " Ctrl-N
Plug 'tpope/vim-abolish' " Smart substitution :%s/Facility/Building/g
Plug 'junegunn/vim-easy-align' " Enter to realign

" Plug 'gorkunov/smartpairs.vim'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-repeat' Должен быть ДО easyclip


" System adminstration
"
"""""""""""""""""""
Plug 'chr4/nginx.vim'
Plug 'towolf/vim-helm'
Plug 'mattn/vim-gotmpl' " ДОбавляет au! BufRead,BufNewFile *.tmpl setlocal filetype=gohtmltmpl, не факт что нужен
Plug 'pearofducks/ansible-vim'

""""""""""""""""""""""
" Software Development
"
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-surround' " Chanse surround by cs keystroke
Plug 'scrooloose/syntastic' " Syntax highlighing


""""""""""""""""""""""""
" Tags management, autocomplete, searches
"
Plug 'grassdog/tagman.vim'
Plug 'ludovicchabant/vim-gutentags' " Automatic ctags management for Vim
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-calc'
" Plug 'hrsh7th/cmp-spell'

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
" Plug 'prettier/vim-prettier'
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

"""""""""""""""""""""

call plug#end()

lua << END
require('lualine').setup {
  options = { theme = 'gruvbox' }
}
END
