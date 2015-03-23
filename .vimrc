" Install Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
" :PluginInstall
 " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
imap ;; <Esc>
 
set nocompatible                " be iMproved
filetype off                    " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Для textobject-а
runtime macros/matchit.vim

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'
" Plugin 'kikijump/tslime.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'mtscout6/vim-cjsx'

Plugin 'sjbach/lusty'
":LustyFilesystemExplorer
":LustyFilesystemExplorerFromHere
":LustyBufferExplorer
":LustyBufferGrep (for searching through all open buffers)

"<Leader>lf  - Opens filesystem explorer.
"<Leader>lr  - Opens filesystem explorer at the directory of the current file.
"<Leader>lb  - Opens buffer explorer.
"<Leader>lg  - Opens buffer grep. - самая фишка
"Plugin 'techlivezheng/vim-plugin-minibufexpl'

Plugin 'bling/vim-bufferline'
"Plugin 'majutsushi/tagbar'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = ''
"let g:airline#extensions#tagbar#flags = 'f'
"let g:airline#extensions#tagbar#flags = 's'
"let g:airline#extensions#tagbar#flags = 'p'
nmap <F8> :TagbarToggle<CR>


" My Plugins here:
"
" original repos on github
Plugin 'groenewege/vim-less'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-pasta'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Run NERD if there is not files opened
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim is there is NERD only
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <F2> :NERDTreeTabsToggle<CR>
" map <C-n> :NERDTreeToggle<CR>

Plugin 'scrooloose/nerdcommenter'
Plugin 'kana/vim-textobj-user'
Plugin 'vim-ruby/vim-ruby'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'
Plugin 'thoughtbot/vim-rspec'
Plugin 'kchmck/vim-coffee-script'

Plugin 'kien/ctrlp.vim'
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/assets*,tmp/*,app/assets/images*,public/ima,coverage/*,public/*,vendor/assets/*,.sass-cache/*,solr/*,*/uploads/*,doc/*,doc
nnoremap <Leader>e :CtrlP<CR>
"let g:ctrlp_cmd = 'CtrlPMRU'

"nmap ; :CtrlPBuffer<CR>
" the nearest ancestor that contains one of these directories or files: .git
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|bin$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

Plugin 'slim-template/vim-slim'
" Plugin 'flazz/vim-colorschemes'
" # after downloading; unpacking; cd'ing
" cp colors/* ~/.vim/colors
Plugin 'mxw/vim-jsx'

Bundle 'lukaszkorecki/CoffeeTags'

Plugin 'noprompt/vim-yardoc'
Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-clojure-highlight'

Plugin 'rking/ag.vim'

Plugin 'cakebaker/scss-syntax.vim'

" vim-scripts repos
"Plugin 'L9'
"Plugin 'FuzzyFinder'
" non github repos
"Plugin 'git://git.wincent.com/command-t.git'
Plugin 'tpope/vim-repeat'

" cs{( to change { on (
" ysiw] обернуть слово в ]
" https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


Plugin 'othree/html5.vim'
Plugin 'othree/xml.vim'

"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'garbas/vim-snipmate'
Plugin 'ervandew/supertab'
" <c-n> <c-p> to move curson in completion list

Plugin 'airblade/vim-gitgutter'
Plugin 'dapi/gruvbox'
" cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors

Plugin 'Shougo/unite.vim'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'bling/vim-airline'
"let g:airline_enable_syntastic = 1
"let g:airline#extensions#syntastic#enabled = 1
" only on mac
let g:airline_powerline_fonts = 1
" git repos on your local machine (ie. when working on your own plugin)
"Plugin 'file:///Users/gmarik/path/to/plugin'
" ...
 
Plugin 'szw/vim-ctrlspace'
let g:airline_exclude_preview = 1
set hidden

call vundle#end() 

"https://github.com/majutsushi/tagbar/wiki#coffeescript
let g:tlist_coffee_settings = 'coffee;f:function;v:variable'
"let g:CoffeeAutoTagFile=<filename>       " Name of the generated tag file (Default: ./tags)
"let g:CoffeeAutoTagIncludeVars=<0 or 1>  " Includes variables (Default: 0 [false])
"let g:CoffeeAutoTagTagRelative=<0 or 1>  " Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

syntax on
set t_Co=256
"set list lcs=tab:' '
"http://andrew.stwrt.ca/posts/vim-ctags
":CtrlPTag
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

set list lcs=tab:\|\ 
"Plugin 'Yggdroot/indentLine'
"let g:indentLine_color_term = 239
"let g:indentLine_char = '|' " ¦, ┆

" Включить <Leader>ig
"Plugin 'nathanaelkane/vim-indent-guides'

set tabstop=2 shiftwidth=2 expandtab softtabstop=2
syntax enable
filetype on
filetype indent on  
filetype plugin on

"color desert
" colorscheme solarized
colorscheme gruvbox
set background=dark 

au BufRead,BufNewFile *.hamlc set filetype=haml
au BufRead,BufNewFile {Guardfile,Gemfile.lock,Procfile}    set ft=ruby
au BufNewFile,BufRead *.sql setf pgsql
au BufRead,BufNewFile *.cjsx set filetype=coffee
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.cljx setfiletype clojure


" Автодополнение как в bash
set wildmode=longest,list,full
set wildmenu


" airline
set laststatus=2

"set paste
"set nopaste
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
" vim-pasta
let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml', 'cjsx']

set showmode

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" jumps in edit mode
" https://coderwall.com/p/fd_bea
"
imap <C-e> <C-o>$
imap <C-a> <C-o>0


" Switch to alternate file
" gvim
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>

" Unite
nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>
nnoremap <Leader>f :Unite grep:.<cr>

" CtrlP search
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('file_rec/async','sorters','sorter_rank')
" replacing unite with ctrl-p
"nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>
