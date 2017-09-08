"set background=dark            " only relevant with some emulators
set clipboard=unnamed           " system clipboard
set nocompatible                " be iMproved, required
set laststatus=2                " always show status line
set expandtab                   " spaces instead of tabs
set tabstop=4                   " 4 spaces will do
set shiftwidth=4                " control indentation for >> bind
set autoindent                  " always set autoindenting on
set rnu                         " relative line numbers
set number                      " hybrid numbering with both rnu and number
set hidden                      " hide buffers instead of closing them
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if all lowercase
set visualbell                  " don't beep
set noerrorbells                " don't beep
set nobackup                    " don't need swp files
set noswapfile                  " don't need swp files
set backspace=indent,eol,start  " allow backspacing everything in insert

" Use comma as leader
let mapleader = ","

" Set dosini syntax highlighting for config files
autocmd BufRead,BufNewFile config setf dosini
" Treat .eex files as html for elixir
autocmd BufEnter *.eex :setlocal filetype=html

" Autoloads and saves folds
autocmd BufWrite * mkview
autocmd BufRead * silent loadview
autocmd BufNewFile * start " new files start in insert

" If :make is called, write the file first
set autowrite

" Intuitive split directions
set splitbelow
set splitright

" Intuitive behavior for wrapped lines
nnoremap j gj
nnoremap k gk

" Don't have to clear search every time
nmap <silent> ,/ :nohlsearch<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" w!! to write with sudo even if not opened with sudo
cmap w!! w !sudo tee >/dev/null %

" --- Vundle section --- "
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Theming
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dylanaraps/wal'

" Git for vim
Plugin 'tpope/vim-fugitive'

" Various syntax
Plugin 'scrooloose/syntastic'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'Yggdroot/indentLine'

" File browsing
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'chrisbra/Colorizer'

" General usability
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplete'

" Haskell
Plugin 'eagletmt/neco-ghc'
Plugin 'shiena/ghcmod-vim'
Plugin 'Shougo/vimproc'
Plugin 'godlygeek/tabular'

" Elixir
Plugin 'elixir-lang/vim-elixir'
Plugin 'slashmili/alchemist.vim'

" Go
Plugin 'fatih/vim-go'

" Java
Plugin 'artur-shaik/vim-javacomplete2'

" Latex and markdown
Plugin 'plasticboy/vim-markdown'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'

call vundle#end()
" --- End of Vundle section --- "

" These need to be after plugin section to function correctly
syntax enable                   " syntax highlighting on
filetype plugin indent on       " filetype specific declarations
colorscheme wal

" Intuitive split binds
nnoremap <C-w><BS> <C-w>s
nnoremap <C-w>\  <C-w>v
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-bs>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<c-\>', '<RightMouse>'],
    \ }

" Nerdtree binds to make it behave more like ranger
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='<BS>'
let NERDTreeMapOpenVSplit='\'
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseDir='h'

" Use zathura for previewing latex
let g:livepreview_previewer = 'zathura'
" let g:livepreview_engine = 'latexmk -pdf'
