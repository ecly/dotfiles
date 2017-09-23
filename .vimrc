set encoding=utf-8
scriptencoding utf-8
set clipboard=unnamed           " system clipboard
set laststatus=2                " always show status line
set expandtab                   " spaces instead of tabs
set tabstop=4                   " 4 spaces will do
set shiftwidth=4                " control indentation for >> bind
set autoindent                  " always set autoindenting on
set relativenumber              " relative line numbers
set number                      " hybrid numbering with both rnu and number
set hidden                      " hide buffers instead of closing them
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if all lowercase
set visualbell                  " don't beep
set noerrorbells                " don't beep
set nobackup                    " don't need swp files
set noswapfile                  " don't need swp files
set showmatch                   " Show matching braces when over one
set backspace=indent,eol,start  " allow backspacing everything in insert
set hlsearch                    " highlight searches
set incsearch                   " search as typing

" Use comma as leader
let g:mapleader = ','

" Commands ran automatically on certain events
augroup autos
    autocmd!
    " Set dosini syntax highlighting for config files
    autocmd BufRead,BufNewFile config setf dosini
    " Treat .eex files as html for elixir
    autocmd BufEnter *.eex :setlocal filetype=html
    " new files start in insert
    autocmd BufNewFile * start

    " Run Neomake automatically
    autocmd BufWritePost * Neomake
    autocmd BufReadPost * Neomake
augroup END

"Remove all trailing whitespace by pressing <leader>T
"Avoids messing with search terms - from vim wiki
nnoremap <leader>T :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" binds for finding matches
nnoremap [I [I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>
nnoremap ]I ]I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>

" juggling with changes
nnoremap <leader>; g;
nnoremap <leader>, g,

" juggling with jumps - because ` is unpleasant
nnoremap ' `

" Intuitive split directions
set splitbelow
set splitright

" Intuitive behavior for wrapped lines
nnoremap j gj
nnoremap k gk

" Bind to clear search
nmap <leader>/ :nohlsearch<CR>

" Quick search and replace for block and selection
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Intuitive split binds
nnoremap <C-w><BS> <C-w>s
nnoremap <C-w>\  <C-w>v

" Tmux like close split
map <C-w>x <C-w>q

" w!! to write with sudo even if not opened with sudo
cmap w!! w !sudo tee >/dev/null %

" --- Vundle section --- "
call plug#begin('~/.vim/plugged')

" Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dylanaraps/wal'

" Editing and usability
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'chrisbra/Colorizer'
Plug 'christoomey/vim-tmux-navigator'

" Git for vim
Plug 'tpope/vim-fugitive'

" Various syntax
Plug 'scrooloose/syntastic'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'Yggdroot/indentLine'
Plug 'neomake/neomake'

" File browsing
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Haskell
Plug 'eagletmt/neco-ghc'
Plug 'shiena/ghcmod-vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Go
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Java
Plug 'artur-shaik/vim-javacomplete2'

" Latex and markdown
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview'

" Initialize plugin system
call plug#end()

" These need to be after plugin section to function correctly
syntax enable                   " syntax highlighting on
filetype plugin indent on       " filetype specific declarations
colorscheme wal

let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" CtrlP split binds
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-bs>', '<c-h>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<c-\>', '<c-v>', '<RightMouse>'],
    \ }

" CtrlP settings for when started without explicit stating dir
let g:ctrlp_working_path_mode = 'cr'

" Nerdtree binds to make it behave more like ranger
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeMapOpenSplit=':h'
let g:NERDTreeMapOpenVSplit=':v'
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapCloseDir='h'

" Use zathura for previewing latex
let g:livepreview_previewer = 'zathura'
" let g:livepreview_engine = 'latexmk -pdf'
