
" Install vim-plug
" https://github.com/junegunn/vim-plug

call plug#begin()

" Theme and visual
"
Plug 'dapi/gruvbox', { 'do': 'cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors' } 

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'
Plug 'airblade/vim-rooter'
Plug 'Yggdroot/indentLine'
Plug 'folke/which-key.nvim'

" портит табы в e2e-tests/Makefile - ОТКЛЮЧЕН для производительности
" Plug 'editorconfig/editorconfig-vim'
" vim-sensible - ОТКЛЮЧЕН для производительности, т.к. используется современная конфигурация
" Plug 'tpope/vim-sensible' " a universal set of default
Plug 'sickill/vim-pasta' " This plugin remaps p and P (put command) in normal and visual mode to do context aware pasting
Plug 'tpope/vim-sleuth' " Heuristically set buffer options ('shiftwidth' and 'expandtab')
" vim-stay - ОТКЛЮЧЕН для производительности, т.к. редко используется fold функциональность
" Plug 'zhimsel/vim-stay' " Restore cursor position

" Text manipulation
" Plug 'scrooloose/nerdcommenter' " Ctrl-C - ОТКЛЮЧЕН для производительности
" Plug 'mg979/vim-visual-multi' " Ctrl-N - ОТКЛЮЧЕН для производительности
" Plug 'tpope/vim-abolish' " Smart substitution - ОТКЛЮЧЕН для производительности
Plug 'junegunn/vim-easy-align' " Enter to realign
" NerdCommenter альтернатива - встроенная команда gc (если nvim >= 0.6)
" vim-visual-multi заменяем на встроенный мультикурсор или просто без него

" Plug 'gorkunov/smartpairs.vim'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-repeat' Должен быть ДО easyclip


" System adminstration
"
"""""""""""""""""""
Plug 'chr4/nginx.vim'
Plug 'towolf/vim-helm'
Plug 'mattn/vim-gotmpl' " ДОбавляет au! BufRead,BufNewFile *.tmpl setlocal filetype=gohtmltmpl, не факт что нужен
Plug 'gotgenes/golang-template.vim'
Plug 'pearofducks/ansible-vim'

""""""""""""""""""""""
" Software Development
"
" Plug 'AndrewRadev/splitjoin.vim' " ОТКЛЮЧЕН для производительности
" Plug 'tpope/vim-surround' " Chanse surround - ОТКЛЮЧЕН для производительности
" Plug 'scrooloose/syntastic' " Syntax highlighting - ОТКЛЮЧЕН для производительности
" Syntastic - главный тормоз! Заменяем на встроенную подсветку синтаксиса илиtreesitter
" не знаю почему не включил
"Plug 'stephpy/vim-yaml'


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
" require'lspconfig'.ruby_lsp.setup{}

lua << END
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    -- Минимальная конфигурация для производительности
    icons_enabled = false,
    component_separators = '',
    section_separators = ''
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}
END
