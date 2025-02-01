set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers
set smartindent
set autoindent " Indent a new line
set inccommand=split " Show replacements in a split screen
set mouse=a " Allow to use the mouse in the editor
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set ttyfast " Speed up scrolling in Vim


syntax enable       " Enable syntax highlighting
set number " Shows the line numbers
set list lcs=tab:\|\ 
set clipboard=unnamed

" Allow auto-indenting depending on file type
filetype on         " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins

set showmode

" Автодополнение как в bash
set wildmode=longest,list,full
set wildmenu


" airline
set laststatus=2
set autowrite                  " automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')

set encoding=utf-8
set nocompatible                " be iMproved
set pumheight=10 " Popup menu

set iskeyword+=-

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" case insensitive search
set smartcase
set ignorecase

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set tags+=gems.tags
set fileformat=unix

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Show extra spaces
" set list listchars+=eol:↴,tab:>·,trail:-,extends:>,precedes:<,space:␣



set wildignore+=*.log,*.o,*.obj,.git,*.rbc,*.class,.svn,.sass-cache/*,solr/*,*tags,*.lock
set wildignore+=*/images/*,*/tmp/*,*/coverage/*,*/uploads/* " ,*/node_modules/*,*/dist/*
set wildignore+=public/*
set wildignore+=*/doc/*,*/bin/*

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set autochdir

set spelllang=en_us
set spell " enable spell check (may need to download language package)
set complete+=kspell

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>120v.\+/
"match OverLength /\%81v.\+/

set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim

" highlight yank
" source: https://smarttech101.com/how-to-configure-neovim#treat-dash-separated-words-as-a-word-text-object
"
lua << EOF
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
EOF

" Window title
let &titlestring = expand('%:~') . ' — nvim'
autocmd FileType man let &titlestring = expand('%:t') . ' — nvim'
set title
