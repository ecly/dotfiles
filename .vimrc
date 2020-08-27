set encoding=utf-8
scriptencoding utf-8
set noshowmode                  " Lightline shows this already
set clipboard^=unnamed,unnamedplus " Use system clipboard
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
set nobackup                    " Don't need backup
set nowritebackup               " Don't need backup
set noswapfile                  " Don't need swp files
set showmatch                   " Show matching braces when over one
set backspace=indent,eol,start  " Allow backspacing everything in insert
set hlsearch                    " Highlight searches
set incsearch                   " Search as typing
set concealcursor=              " Never conceal anything on current line
set undofile                    " Use persistent undofiles
set lazyredraw                  " Speedup large files and macros
set updatetime=100              " Default 4000 is a bit high for async updates
set splitbelow                  " Intuitive default split directions
set splitright                  " Intuitive default split directions
if has('termguicolors')
  set termguicolors             " Use true colors
endif

let g:mapleader = ','

augroup autos
    autocmd!
    " Set dosini syntax highlighting for config files
    autocmd BufRead,BufNewFile config setf dosini
    " https://github.com/preservim/nerdtree/wiki/F.A.Q.#how-can-i-make-sure-vim-does-not-open-files-and-other-buffers-on-nerdtree-window
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
augroup END

" Jumps with ` are unpleasant on my keyboard
nnoremap ' `

" Intuitive behavior for wrapped lines
nnoremap j gj
nnoremap k gk

" Bind to clear search
nmap <leader>/ :nohlsearch<CR>

" Quick search and replace for block and selection - from romainln minivimrc
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Easy window/buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Intuitive split binds
nnoremap <C-w><BS> <C-w>s
nnoremap <C-w>\  <C-w>v

" w!! to write with sudo even if not opened with sudo
cmap w!! w !sudo tee >/dev/null %

" Address my common mistakes when typing fast
command WQ wq
command Wq wq
command W w
command Q q

" Explicitly set host programs for pynvim installations
if has('nvim')
  let g:python3_host_prog = '/usr/bin/python3'
  let g:python_host_prog = '/usr/bin/python2'
endif

" Auto install Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd autos VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Use less than default 16 threads for update/install to avoid timeouts
let g:plug_threads = 4
" Avoid vim-plug crashes when calling functions from NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'

" Coc extensions (currently excluding coc-pyright
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
" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}"

" Theming
Plug 'gruvbox-community/gruvbox'

" Git plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Automatically adjust indents
Plug 'tpope/vim-sleuth'

" Easy commenting
Plug 'tpope/vim-commentary'

" Easy change surrounding tokens
Plug 'tpope/vim-surround'
Plug 'markonm/traces.vim'
Plug 'AndrewRadev/splitjoin.vim'

" Speed up folding
Plug 'Konfekt/FastFold'

" Smooth scrolling in vim
" Plug 'psliwka/vim-smoothie'

" Peek into registers with @/"
Plug 'junegunn/vim-peekaboo'

" Handling whitespace
Plug 'ntpeters/vim-better-whitespace'
nnoremap <leader>T :StripWhitespace<CR>
let g:strip_whitespace_confirm=0
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Running tests
Plug 'janko/vim-test'
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

" File browsing
Plug 'ryanoasis/vim-devicons'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}

" NERDTree settings
Plug 'preservim/nerdtree'
nnoremap <leader>v <cmd>CHADopen<cr>
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeMapOpenSplit='<C-h>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapCloseDir='h'

" Fzf settings "
Plug 'junegunn/fzf.vim'
nmap <c-p> :Files<CR>
let g:fzf_action = {'ctrl-t': 'tab split','ctrl-h': 'split','ctrl-v': 'vsplit'}
Plug 'airblade/vim-rooter'

" Some language/file specific plugins
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'elzr/vim-json'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/Dockerfile.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
let g:mkdp_auto_close = 0
nmap <C-s> <Plug>MarkdownPreview

" Python semantic syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
let g:semshi#mark_selected_nodes=0 " this is coc's job

" Latex settings
Plug 'lervag/vimtex'
let g:tex_conceal = ''
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
" don't open the quickfix window for warnings
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
" open on errors without focus
let g:vimtex_quickfix_mode = 2
" use neovim-remote for callbacks
let g:vimtex_compiler_progname = 'nvr'

" Vimwiki settings
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [
  \ {'path': '~/Documents/work/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
  \ {'path': '~/Documents/irl/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}
  \]
nmap <silent> <leader><Tab> <Plug>VimwikiNextLink
nmap <silent> <leader><S-Tab> <Plug>VimwikiPrevLink

" --- Lightline configuration --- "
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" References:
"   https://github.com/statico/dotfiles/blob/202e30b23e5216ffb6526cce66a0ef4fa7070456/.vim/vimrc#L406-L453
"   https://github.com/neoclide/coc.nvim/issues/401

" Always show tabline
set showtabline=2
" Ensure that lightline-bufferline works with devicons
let g:lightline#bufferline#enable_devicons = 1

" Lightline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['gitbranch', 'modified']],
    \   'right': [['lineinfo'], ['percent'], ['coc_error', 'coc_warning', 'coc_info', 'coc_hint', 'coc_fix', 'readonly', 'filetype']],
    \ },
    \ 'tabline': {
    \   'left': [['buffers']],
    \   'right': [],
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \   'coc_error'        : 'LightlineCocErrors',
    \   'coc_warning'      : 'LightlineCocWarnings',
    \   'coc_info'         : 'LightlineCocInfos',
    \   'coc_hint'         : 'LightlineCocHints',
    \   'coc_fix'          : 'LightlineCocFixes',
    \ },
    \ 'component_type': {
    \   'readonly': 'error',
    \   'buffers': 'tabsel',
    \   'coc_error': 'error',
    \   'coc_warning': 'warning',
    \   'coc_info': 'tabsel',
    \   'coc_hint': 'middle',
    \   'coc_fix': 'middle',
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \ },
    \ }

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction
function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf('%s %d', a:sign, info[a:kind])
endfunction
function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', '✗')
endfunction
function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', '')
endfunction
function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', '')
endfunction
function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', '')
endfunction

autocmd autos User CocStatusChange,CocDiagnosticChange call s:MaybeUpdateLightline()

call plug#end()

" Theming - these need to be after plugin section to function correctly
" Enable syntax highlighting
syntax enable
" Filetype specific declarations
filetype plugin indent on
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column='bg0'
colorscheme gruvbox

