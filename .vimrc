set encoding=utf-8
scriptencoding utf-8
set noshowmode                  " lightline shows this already
set clipboard+=unnamed          " system clipboard
set laststatus=2                " always show status line
set tabstop=4                   " 4 spaces will do
set shiftwidth=4                " control indentation for >> bind
set expandtab                   " spaces instead of tabs
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
set concealcursor=              " never conceal anything on current line

" Use comma as leader
let g:mapleader = ','

" Commands ran automatically on certain events
augroup autos
    autocmd!
    " Set dosini syntax highlighting for config files
    autocmd BufRead,BufNewFile config setf dosini
    " ensure all .js files are treated as javascript
    autocmd BufEnter *.js :setlocal filetype=javascript
    " new files start in insert
    autocmd BufNewFile * start

    " Auto toggle Limelight when using Goyo
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END

" Manual call to Strip whitespace from end of line
nnoremap <leader>T :StripWhitespace<CR>

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

" since I constantly write accidentally mess these up when going fast
command WQ wq
command Wq wq
command W w
command Q q

" --- Plugin section --- "
call plug#begin('~/.vim/plugged')

" --- Theming --- "
Plug 'dylanaraps/wal'
Plug 'itchyny/lightline.vim'
Plug 'taohex/lightline-buffer'

" --- Completion and syntax --- "
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'w0rp/ale'

" Editing and usability
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'chrisbra/Colorizer'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'xtal8/traces.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Chiel92/vim-autoformat'

" --- Git for vim --- "
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" --- File browsing --- "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }"
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'

" --- Programming languages --- "
Plug 'sheerun/vim-polyglot'
" Haskell
Plug 'eagletmt/neco-ghc'
Plug 'shiena/ghcmod-vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Elixir
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'
" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
" Python
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

" --- Latex and markdown --- "
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview'
" Initialize plugin system
call plug#end()

" These need to be after plugin section to function correctly
syntax enable                   " syntax highlighting on
filetype plugin indent on       " filetype specific declarations
colorscheme wal

" Autoformat bindings
nmap <silent> <leader>f :Autoformat<cr>
let g:formatdef_black = '"black"'
let g:formatters_python = ['black']

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '-'

" fzf.vim settings
"https://github.com/junegunn/fzf.vim/issues/47
" Use :Files from git root if one is present, otherwise just use :files
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" nmap ; :Buffers<CR>
command! ProjectFiles execute 'Files' s:find_git_root()
nmap <c-p> :ProjectFiles<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }


" Ale error goto bindings
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" Nerdtree binds to make it behave more like ranger
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeMapOpenSplit='gh'
let g:NERDTreeMapOpenVSplit='gv'
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapCloseDir='h'

" Whitespace settings
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_filetypes_blacklist=['ruby', 'markdown',
            \ 'diff', 'gitcommit', 'unite', 'qf', 'help']

" Latex preview settings
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'latexmk -pdf'

" Let deoplete-jedi complete instead
let g:jedi#completions_enabled = 0

" Latex/Markdown conceal settings
let g:vim_markdown_conceal = 0
let g:tex_conceal = ''
let g:vim_markdown_math = 1
