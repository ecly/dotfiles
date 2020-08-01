set encoding=utf-8
scriptencoding utf-8
set noshowmode                  " Lightline shows this already
set clipboard+=unnamed          " System clipboard
set laststatus=2                " Always show status line
set tabstop=4                   " 4 spaces will do
set shiftwidth=4                " Control indentation for >> bind
set expandtab                   " Spaces instead of tabs
set autoindent                  " Always set autoindenting on
set relativenumber              " Relative line numbers
set number                      " Hybrid numbering with both rnu and number
set hidden                      " Hide buffers instead of closing them
set ignorecase                  " Ignore case when searching
set smartcase                   " Ignore case if all lowercase
set visualbell                  " Don't beep
set noerrorbells                " Don't beep
set nobackup                    " Don't need swp files
set noswapfile                  " Don't need swp files
set showmatch                   " Show matching braces when over one
set backspace=indent,eol,start  " Allow backspacing everything in insert
set hlsearch                    " Highlight searches
set incsearch                   " Search as typing
set concealcursor=              " Never conceal anything on current line
set undofile                    " Use persistent undofiles
set lazyredraw                  " Speedup large files and macros

" Use comma as leader
let g:mapleader = ','

" Commands ran automatically on certain events
augroup autos
    autocmd!
    " Set dosini syntax highlighting for config files
    autocmd BufRead,BufNewFile config setf dosini
    " Auto toggle Limelight when using Goyo
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END

" Manual call to Strip whitespace from end of line
nnoremap <leader>T :StripWhitespace<CR>

" Jumps with ` are unpleasant on my keyboard
nnoremap ' `

" Intuitive split directions
set splitbelow
set splitright

" Intuitive behavior for wrapped lines
nnoremap j gj
nnoremap k gk

" Bind to clear search
nmap <leader>/ :nohlsearch<CR>

" Quick search and replace for block and selection - from romainln minivimrc
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Intuitive split binds
nnoremap <C-w><BS> <C-w>s
nnoremap <C-w>\  <C-w>v

" Tmux like close split
map <C-w>x <C-w>q

" w!! to write with sudo even if not opened with sudo
cmap w!! w !sudo tee >/dev/null %

" I constantly mess these up when going fast
command WQ wq
command Wq wq
command W w
command Q q

" Auto install Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" --- Plugin section --- "
" Coc extensions
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-html',
\ 'coc-css',
\ 'coc-yaml',
\ 'coc-elixir',
\ 'coc-rls',
\ 'coc-java',
\ 'coc-omnisharp',
\ 'coc-yaml',
\ 'coc-vimtex',
\ 'coc-python',
\ ]

call plug#begin('~/.vim/plugged')

" --- Theming --- "
Plug 'dylanaraps/wal'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" " --- Completion and syntax --- "
Plug 'neoclide/coc.nvim', {'branch': 'release'}"

" Editing and usability
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'xtal8/traces.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Konfekt/FastFold'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'roxma/vim-tmux-clipboard'
Plug 'chrisbra/csv.vim'
Plug 'janko/vim-test'
Plug 'ryanoasis/vim-devicons'
Plug 'vimwiki/vimwiki'
" Plug 'psliwka/vim-smoothie'

" --- File browsing --- "
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" --- Language/file specific plugs --- "
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'PotatoesMaster/i3-vim-syntax'
call plug#end()

" These need to be after plugin section to function correctly
syntax enable                   " syntax highlighting on
filetype plugin indent on       " filetype specific declarations
colorscheme wal

" Fugitive
nmap gs :vertical Gstatus<CR>

" Settings for fzf.vim
" https://github.com/junegunn/fzf.vim/issues/47
" Use :Files from git root if one is present, otherwise just use :files
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nmap <c-p> :ProjectFiles<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" Nerdtree binds to make it behave more like ranger
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeMapOpenSplit='<BS>'
let g:NERDTreeMapOpenVSplit='\'
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapCloseDir='h'

" Whitespace settings
let g:strip_whitespace_confirm=0
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_filetypes_blacklist=['ruby', 'markdown',
            \ 'diff', 'gitcommit', 'unite', 'qf', 'help']

" Use NVR for vimtex compilation
let g:vimtex_compiler_progname = 'nvr'
" Ensure that devicons work with lightline-bufferline
let g:lightline#bufferline#enable_devicons = 1
" vim-test mapping for running tests
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

nmap <silent> <leader><Tab> <Plug>VimwikiNextLink
nmap <silent> <leader><S-Tab> <Plug>VimwikiPrevLink
