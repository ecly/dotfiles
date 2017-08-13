syntax on                       " syntax highlighting on
set clipboard=unnamed           " system clipboard
set nocompatible                " be iMproved, required
set laststatus=2                " always show status line
set background=dark             " only relevant with some emulators
set expandtab                   " spaces instead of tabs
set tabstop=4                   " 4 spaces will do
set shiftwidth=4                " control indentation for >> bind
set rnu                         " relative line numbers
set number                      " hybrid numbering with both rnu and number
filetype plugin indent on       " required

" Use comma as leader
let mapleader = ","

" Set dosini syntax highlighting for config files
autocmd BufRead,BufNewFile config setf dosini

" Autoloads and saves folds
autocmd BufWrite * mkview
autocmd BufRead * silent loadview

" Make airline look neat
let g:airline_theme='hybrid'

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'chrisbra/Colorizer'
Plugin 'Shougo/neocomplete'
Plugin 'eagletmt/neco-ghc'
Plugin 'shiena/ghcmod-vim'
Plugin 'Shougo/vimproc'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'elixir-lang/vim-elixir'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'scrooloose/nerdtree'
call vundle#end()

" Intuitive split directions
set splitbelow
set splitright

" Intuitive split binds
nnoremap <C-w><BS> <C-w>v
nnoremap <C-w>\  <C-w>s
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-bs>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<c-\>', '<RightMouse>'],
    \ }

" Nerdtree binds to make it behave more like ranger
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='\'
let NERDTreeMapOpenVSplit='<BS>'
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseDir='h'

" Use zathura for previewing latex
let g:livepreview_previewer = 'zathura'
" let g:livepreview_engine = 'pdflatex' . 'args'
