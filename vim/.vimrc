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
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Font
if has('gui_running')
  set guifont=Monospace\ 16
endif

if filereadable($HOME . "/.vim.abbr")
  source ~/.vim.abbr
endif

" Fix screen's key bindings.
"
" showkey -a
"
if &term == "screen-256color"
  map <Esc>[D           <C-Left>
  map <Esc>[C           <C-Right>
  map <Esc><Esc>OP      <A-F1>
  map <Esc><Esc>OQ      <A-F2>
  map <Esc><Esc>OR      <A-F3>
  map <Esc><Esc>OS      <A-F4>
  map <Esc><Esc>15~     <A-F5>
  map <Esc><Esc>[17~    <A-F6>
  map <Esc><Esc>[18~    <A-F7>
  map <Esc><Esc>[19~    <A-F8>
  map <Esc><Esc>[20~    <A-F9>
  map <Esc><Esc>[21~    <A-F10>
  map <Esc><Esc>[23~    <A-F11>
  map <Esc><Esc>[24~    <A-F12>
  map <Esc><Esc>[5~     <A-PageUp>
  map <Esc><Esc>[6~     <A-PageDown>


endif

" Mappings
"
"
" Leader Mappings
map <Space> <leader>
" Clear out a search by typing <leader>/
nnoremap <Leader>/ :noh<CR>

" vimwiki
" <Leader>ww

map <leader>f :Ranger<CR>
map <leader>r :Ranger<CR>

" Tab navigation
nnoremap <C-n> :tabnew<CR>
nnoremap <C-m> :tabclose<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-RighT> :tabnext<CR>
nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F0> 10gt
nnoremap <silent> <A-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-PageDown> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>


" vimwiki
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'bash': 'bash'}
let g:vimwiki_list = [wiki]


" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
