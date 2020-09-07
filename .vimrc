set encoding=utf-8
scriptencoding utf-8
set noshowmode                      " Lightline shows this already
set clipboard^=unnamed,unnamedplus  " Use system clipboard
set laststatus=2                    " Always show status line
set tabstop=4                       " 4 spaces will do
set shiftwidth=4                    " Control indentation for >> bind
set expandtab                       " Spaces instead of tabs
set autoindent                      " Always set autoindenting on
set relativenumber                  " Relative line numbers
set number                          " Hybrid numbering with both rnu and number
set hidden                          " Hide buffers instead of closing them
set ignorecase                      " Ignore case when searching
set smartcase                       " Ignore case if all lowercase
set visualbell                      " Don't beep
set noerrorbells                    " Don't beep
set nobackup                        " Don't need backup
set nowritebackup                   " Don't need backup
set noswapfile                      " Don't need swp files
set showmatch                       " Show matching braces when over one
set backspace=indent,eol,start      " Allow backspacing everything in insert
set hlsearch                        " Highlight searches
set incsearch                       " Search as typing
set concealcursor=                  " Never conceal anything on current line
set undofile                        " Use persistent undofiles
set lazyredraw                      " Speedup large files and macros
set updatetime=100                  " Default 4000 is a bit high for async updates
set splitbelow                      " Intuitive default split directions
set splitright                      " Intuitive default split directions
set showtabline=2                   " Always show tabline
if has('termguicolors')
  set termguicolors                 " Use true colors
endif

let g:mapleader = "\<Space>"
nmap <leader>/ :nohlsearch<CR>

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
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Quick search and replace for block and selection - from romainln minivimrc
nnoremap <leader><leader> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <leader>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Explicitly set host programs for pynvim installations
if has('nvim')
  let g:python3_host_prog = '/usr/bin/python3'
  let g:python_host_prog = '/usr/bin/python2'
endif

augroup autos
  " https://github.com/preservim/nerdtree/wiki/F.A.Q.#how-can-i-make-sure-vim-does-not-open-files-and-other-buffers-on-nerdtree-window
  autocmd! BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
  " Briefly highlight yanked text (available in neovim >= 5.0
  if exists('##TextYankPost')
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 300)
  endif
augroup END

" Auto install Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd autos VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
      \ 'coc-lists',
      \ 'coc-snippets',
      \ ]

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
" Auto-detect indentation
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Ability to . repeat some plugin operations
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Highlight matches patterns from Ex commands
Plug 'markonm/traces.vim'
" Split/join one-liners with gS/gJ
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Konfekt/FastFold'
Plug 'honza/vim-snippets'
" Plug 'psliwka/vim-smoothie'
" Peek into registers with @ and \"
Plug 'junegunn/vim-peekaboo'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'janko/vim-test'
" NERDTree settings
Plug 'preservim/nerdtree'
" Fzf settings "
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Some language/file specific plugins
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'elzr/vim-json'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/Dockerfile.vim'
" Preview markdown files with :MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Use <C-c><C-c> to send chunk to tmux pane
Plug 'jpalardy/vim-slime'
Plug 'lervag/vimtex'
Plug 'vimwiki/vimwiki'
call plug#end()

" Enable syntax highlight and ft-plugins (need to follow Plug section)
syntax enable
filetype plugin indent on

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column='bg0'
let g:gruvbox_invert_selection=0
colorscheme gruvbox

" Latex settings
let g:tex_conceal = ''
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
" open on errors without focus
let g:vimtex_quickfix_mode = 2
" use neovim-remote for callbacks
let g:vimtex_compiler_progname = 'nvr'

" Vimwiki settings
let g:vimwiki_list = [
      \ {'path': '~/Documents/work/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
      \ {'path': '~/Documents/irl/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}
      \]
nmap <silent> <leader><Tab> <Plug>VimwikiNextLink
nmap <silent> <leader><S-Tab> <Plug>VimwikiPrevLink

let g:mkdp_auto_close = 0
nmap <C-s> <Plug>MarkdownPreview

" Fzf settings
nmap <c-p> :Files<CR>
let g:fzf_action = {'ctrl-t': 'tab split','ctrl-h': 'split','ctrl-v': 'vsplit'}

" Whitespace settings
nnoremap <leader>T :StripWhitespace<CR>
let g:strip_whitespace_confirm=0
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Semshi should not mark selected nodes as Coc already does this
let g:semshi#mark_selected_nodes=0

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeMapOpenSplit='<C-h>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapCloseDir='h'

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

" --- Lightline configuration --- "
" References:
"   https://github.com/statico/dotfiles/blob/202e30b23e5216ffb6526cce66a0ef4fa7070456/.vim/vimrc#L406-L453
"   https://github.com/neoclide/coc.nvim/issues/401

" Ensure that lightline-bufferline works with devicons
let g:lightline#bufferline#enable_devicons = 1
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
