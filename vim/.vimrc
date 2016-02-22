set ttyfast
set lazyredraw

let $PATH='/usr/local/bin:' . $PATH

" Leader Mappings
map <Space> <leader>
" Clear out a search by typing <leader>/
nnoremap <Leader>/ :noh<CR>

" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>
" Current file in nerdtree
map <F9> :NERDTreeFind<CR>

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " highlight matches
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" All tabs expand to four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Color scheme
syntax enable
colorscheme solarized
set background=dark

" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505
set cursorline

" Folding options
set foldcolumn=3

" Number
set number
" Display how far away each line is from the current one, instead of showing
" the absolute line number
set relativenumber

set encoding=utf-8
set autoindent
set showmode
set showcmd
set hidden

" Let command-line completion operate in an enhanced mode
set wildmenu
set wildmode=list:longest

" Use visual bell instead of beeping
set visualbell

" Have always a status line
set laststatus=2

" Highlight search results
set incsearch
set showmatch
set hlsearch

" Switch on spell
set spell

" Set textwidth to 120
set textwidth=120
set colorcolumn=+1
highlight ColorColumn ctermbg=lightgrey

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

:nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
:nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'
:nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
:xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
:xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


