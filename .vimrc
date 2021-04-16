set encoding=utf-8
scriptencoding utf-8
set noshowmode                      " Lightline shows this already
set clipboard^=unnamed,unnamedplus  " Use system clipboard
set laststatus=2                    " Always show status line
set tabstop=4                       " 4 spaces will do
set shiftwidth=4                    " Control  for >> bind
set expandtab                       " Spaces instead of tabs
set autoindent                      " Always set autoindenting on
set relativenumber                  " Relative line numbers
set number                          " Hybrid numbering with both rnu and number
set hidden                          " Hide buffers instead of closing them
set ignorecase                      " Ignore case when searching
set smartcase                       " Ignore case if all lowercase
set visualbell                      " Don't beep
set t_vb=
set noerrorbells                    " Don't beep
set nobackup                        " Don't need backup
set nowritebackup                   " Don't need backup
set noswapfile                      " Don't need swp files
set showmatch                       " Show matching braces when over one
set backspace=indent,eol,start      " Allow backspacing everything in insert
set hlsearch                        " Highlight searches
set incsearch                       " Search as typing
set concealcursor=                  " Never conceal anything on current line
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undofile                        " Use persistent undofiles
set lazyredraw                      " Speedup large files and macros
set updatetime=100                  " Default 4000 is a bit high for async updates
set splitbelow                      " Intuitive default split directions
set splitright                      " Intuitive default split directions
set showtabline=2                   " Always show tabline
set shortmess+=c                    " Don't give ins-completion-menu messages
set completeopt=menuone,noinsert,noselect " Better completion messages
set signcolumn=yes                  " Always show the sign column

" Support true color
" https://github.com/alacritty/alacritty/issues/109
if exists('+termguicolors')
  let &t_8f='\<Esc>[38;2;%lu;%lu;%lum'
  let &t_8b='\<Esc>[48;2;%lu;%lu;%lum'
  set termguicolors
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
  autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
  " Briefly highlight yanked text (available in neovim >= 5.0
  if exists('##TextYankPost')
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
  endif
augroup END
let g:plug_window = 'noautocmd vertical topleft new'

" Auto install Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd autos VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
" Auto-detect indentation
Plug 'tpope/vim-sleuth'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Ability to . repeat some plugin operations
Plug 'tpope/vim-repeat'
" Dependency for gitsigns.nvim and telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
" Highlight matches patterns from Ex commands
Plug 'markonm/traces.vim'
" Split/join one-liners with gS/gJ
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Konfekt/FastFold'
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
Plug 'preservim/nerdtree'
Plug 'airblade/vim-rooter'
" Use <C-c><C-c> to send chunk to tmux pane
Plug 'jpalardy/vim-slime'
" Some language/file specific plugins
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/Dockerfile.vim'
" Preview markdown files with :MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lervag/vimtex'
Plug 'vimwiki/vimwiki'
" LSP/linting configuration
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/diagnostic-nvim'
" Dependency for telescope.nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
call plug#end()

" Setup gitsigns with default setup
lua require('gitsigns').setup()

" Enable syntax highlight and ft-plugins (need to follow Plug section)
syntax enable
filetype plugin indent on
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_italic = 1
augroup ColorSchemeOverrides
    " Possibly fix color strings being hard to distinguish from functions
    " autocmd ColorScheme * highlight String guifg=#0f7d09

    " Fix errorneous markdown rendering for reST style python docstrings
    " on hover. May be resolved by:
    " https://github.com/palantir/python-language-server/issues/760
    " https://github.com/nvim-lua/completion-nvim/issues/243
    autocmd ColorSchemeOverrides ColorScheme * highlight markdownError guibg=multiple_cursors_visual
    autocmd ColorSchemeOverrides ColorScheme * highlight markdownBold guibg=multiple_cursors_visual
    autocmd ColorSchemeOverrides ColorScheme * highlight markdownItalic guibg=multiple_cursors_visual
augroup END

colorscheme gruvbox

" Setup all nvim lua specific configuration
lua << EOF
-- https://stackoverflow.com/a/40195356/4000764
function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

-- hacky solution to problem with using jedi both with/without .venv
-- https://github.com/palantir/python-language-server/issues/872
jedi_env = exists("./.venv") and "./.venv" or nil


require"lspconfig".pyls.setup{
  settings = {
    pyls = {
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        jedi = { extra_paths = {"./dags"}, environment = jedi_env },
      }
    }
  }
}
-- this configuration almost works, but is missing configuration for
-- executionEnvironment which seems to not work when provided. If provided
-- through a pyrightconfig.json, like in: https://github.com/microsoft/pyright/issues/30
-- then it works
-- require'lspconfig'.pyright.setup{
--   settings = {
--     python = {
--       venvPath = jedi_env,
--     }
--   }
-- }


-- setup several out of the box language servers
require"lspconfig".rls.setup{}
require"lspconfig".vimls.setup{}
require"lspconfig".gopls.setup{}
require"lspconfig".dockerls.setup{}
require"lspconfig".bashls.setup{}
require"lspconfig".yamlls.setup{}
require"lspconfig".elixirls.setup{
    -- based on default arch linux 'elixir-ls' package install
    cmd = { "/usr/sbin/elixir-ls" };
}
-- Below need some fixing
-- require"lspconfig".sqlls.setup{}

require'nvim-treesitter.configs'.setup{
  ensure_installed = {"python", "bash", "go", "html", "css", "c_sharp", "javascript", "cpp", "rust"},
  highlight = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}

-- setup for completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

-- telescope settings
local actions = require('telescope.actions')
require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-v>"] = actions.select_vertical,
        ["<C-h>"] = actions.select_horizontal
      },
    },
  },
}
EOF

" Configure LSP and Ale mappings
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

nmap     <silent> [g    <Plug>(ale_previous_wrap)
nmap     <silent> ]g    <Plug>(ale_next_wrap)
nmap     <silent> <leader>f <Plug>(ale_fix)

" Configure completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "<S-Tab>"
" autocmd autos BufEnter * lua require'completion'.on_attach()
autocmd autos Filetype * setlocal omnifunc=v:lua.vim.lsp.omnifunc
let g:completion_trigger_on_delete = 1


" Configure linting overrides with ALE
let g:ale_virtualtext_cursor = 1
" Change directory messes with pylint/pyproject.toml compatibility
let g:ale_python_pylint_change_directory = 0
let g:ale_linters = {'python': ['pylint', 'pydocstyle']}
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace',],
  \ 'python': ['black', 'isort',],
  \ }

" Don't open peekaboo bar immediately (ms)
let g:peekaboo_delay = 200

" Latex settings
let g:tex_conceal = ''
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
" use neovim-remote for callbacks
let g:vimtex_compiler_progname = 'nvr'

" Vimwiki settings
let g:vimwiki_list = [
      \ {'path': '~/Documents/work/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
      \ {'path': '~/Documents/irl/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}
      \]
" Avoid VimWiki overlapping with other binds
nmap <silent> <leader><Tab> <Plug>VimwikiNextLink
nmap <silent> <leader><S-Tab> <Plug>VimwikiPrevLink

let g:mkdp_auto_close = 0
nmap <C-s> <Plug>MarkdownPreview

" Filefinder settings
nmap <C-p> <cmd>Telescope find_files<cr>
nmap <leader>ff <cmd>Telescope find_files<cr>
nmap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeMapOpenSplit='<C-h>'
let g:NERDTreeMapOpenVSplit='<C-v>'
let g:NERDTreeMapActivateNode='l'
let g:NERDTreeMapCloseDir='h'

let g:slime_target = 'tmux'
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{last}'}

" --- Lightline configuration --- "
" Ensure that lightline-bufferline works with devicons
let g:lightline#bufferline#enable_devicons = 1
" let g:lightline#ale#indicator_checking = ''
" let g:lightline#ale#indicator_infos = ''
" let g:lightline#ale#indicator_warnings = ''
" let g:lightline#ale#indicator_errors = ''
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'modified']],
      \   'right': [['lineinfo'],
      \             ['percent'],
      \             ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos'],
      \             ['readonly', 'filetype'],
      \            ],
      \ },
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [],
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_infos': 'lightline#ale#infos',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'buffers': 'tabsel',
      \   'linter_checking': 'right',
      \   'linter_infos': 'right',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
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
