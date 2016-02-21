execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
syntax enable
set background=dark
colorscheme solarized
set t_Co=16

"all tabs expand to four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"folding options
set foldcolumn=3

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
"let command-line completion operate in an enhanced mode
set wildmenu
set wildmode=list:longest
"use visual bell instead of beeping
set visualbell
set cursorline
set ttyfast
"show the line and column number of the cursor position
set ruler
set backspace=indent,eol,start
"have always a status line
set laststatus=2
set number
"display how far away each line is from the current one, instead of showing
"the absolute line number
set relativenumber
"create <FILENAME>.un~ files whenever a file is edited. These files contain
"undo information so previous actions can be undone even after closing and
"reopening a file.
set undofile

"highlight search results
set incsearch
set showmatch
set hlsearch
"clear out a search by typing <leader><space>
nnoremap <leader><space> :noh<cr>

set spell

set textwidth=119
set colorcolumn=+1
highlight ColorColumn ctermbg=lightgrey

"Plugins configuration
call pathogen#helptags()
"autocmd vimenter * NERDTree

" Add triggers to ycm for LaTeX-Box autocompletion
let g:ycm_semantic_triggers = {
\  'tex'  : ['{'],
\ }

"use omnicomplete whenever there's no completion engine in youcompleteme
set omnifunc=syntaxcomplete#Complete
