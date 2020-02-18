set ttyfast
set lazyredraw

let $PATH='/usr/local/bin:' . $PATH


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

syntax enable
syntax on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" All tabs expand to two spaces
set tabstop=8
set shiftwidth=4
set softtabstop=4
set noexpandtab
" set expandtab

" Color scheme
syntax enable
set t_Co=256
try
  colorscheme solarized
catch
endtry
set background=dark

" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505
set cursorline

" Folding options
set foldcolumn=3

" Number
set number

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

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set wmh=0

" Font
if has('gui_running')
  set guifont=Monospace\ 16
  "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 17
endif

if filereadable($HOME . "/.vim.abbr")
  source ~/.vim.abbr
endif

let g:airline_theme='term'

" Mappings
"
"

" Leader Mappings
map <Space> <leader>
" Clear out a search by typing <leader>/
nnoremap <Leader>/ :noh<CR>

" vimwiki
" <Leader>ww

map <leader>r :Ranger<CR>

" Tab navigation
nnoremap <C-c> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>
nnoremap <A-j> :tabprevious<CR>
nnoremap <A-k> :tabnext<CR>
nnoremap <A-`> :tabnext<CR>
nnoremap <A-1> 1gt<CR>
nnoremap <A-2> 2gt<CR>
nnoremap <A-3> 3gt<CR>
nnoremap <A-4> 4gt<CR>
nnoremap <A-5> 5gt<CR>
nnoremap <A-6> 6gt<CR>
nnoremap <A-7> 7gt<CR>
nnoremap <A-8> 8gt<CR>
nnoremap <A-9> 9gt<CR>
nnoremap <A-0> 10gt<CR>
nnoremap <silent> <A-%> :vsplit<Cr>
nnoremap <silent> <A-"> :split<Cr>
nnoremap <silent> <A-q> :q<Cr>
nnoremap <C-p> :Files<Cr>
nnoremap <C-N> :Files<Cr>
nnoremap <F3> :source %<CR>

" vimwiki
let wiki = {}
let wiki.path = '~/vimwiki/'
if len($WIKI_PATH) > 0
  let wiki.path = $WIKI_PATH
endif
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'bash': 'bash'}
let g:vimwiki_list = [wiki]

" haskell
" enable completion enginesi driven by YouCompleteMe
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"
"" File indentation settings
"
au FileType csv setl sts=4 noexpandtab

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
