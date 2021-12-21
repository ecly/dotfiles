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
if !isdirectory("/tmp/vim-undo")
    call mkdir("/tmp/vim-undo", "", 0700)
endif
set undodir=/tmp/vim-undo
set undofile                        " Use persistent undofiles
set lazyredraw                      " Speedup large files and macros
set updatetime=100                  " Default 4000 is a bit high for async updates
set splitbelow                      " Intuitive default split directions
set splitright                      " Intuitive default split directions
set showtabline=2                   " Always show tabline
set shortmess+=c                    " Don't give ins-completion-menu messages
set completeopt=menuone,noselect,preview " Better completion messages
set signcolumn=yes                  " Always show the sign column

" True color support
" https://github.com/alacritty/alacritty/issues/109
if exists('+termguicolors')
  let &t_8f='\<Esc>[38;2;%lu;%lu;%lum'
  let &t_8b='\<Esc>[48;2;%lu;%lu;%lum'
  set termguicolors
endif

" Only use wsl32yank if in WSL context
let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
    let lines = readfile("/proc/version")
    if lines[0] =~ "Microsoft"
      let g:clipboard = {
            \   'name': 'win32yank-wsl',
            \   'copy': {
            \      '+': 'win32yank.exe -i --crlf',
            \      '*': 'win32yank.exe -i --crlf',
            \    },
            \   'paste': {
            \      '+': 'win32yank.exe -o --lf',
            \      '*': 'win32yank.exe -o --lf',
            \   },
            \   'cache_enabled': 0,
            \ }
    endif
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
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'tpope/vim-fugitive'

" Auto-detect indentation
Plug 'tpope/vim-sleuth'
Plug 'lukas-reineke/indent-blankline.nvim'
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
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'janko/vim-test'
Plug 'kyazdani42/nvim-tree.lua'
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
" normally glepnir/lspsaga.nvim
" see: https://github.com/glepnir/lspsaga.nvim/issues/241
Plug 'tami5/lspsaga.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'lukas-reineke/cmp-under-comparator'
Plug 'L3MON4D3/LuaSnip'
" Dependency for telescope.nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Long list of 'folke' plugins
Plug 'folke/which-key.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'sindrets/diffview.nvim'
" :SymbolsOutline to get overview of symbols in file
Plug 'simrat39/symbols-outline.nvim'
Plug 'onsails/lspkind-nvim'

" Testing out copilot
" Plug 'github/copilot.vim'
Plug 'jose-elias-alvarez/null-ls.nvim'
call plug#end()

" Configure several trivially configured lua plugins
lua require('gitsigns').setup()
lua require('trouble').setup()
lua require('lsp-colors').setup()
lua require('todo-comments').setup()

" Enable syntax highlight and ft-plugins (need to follow Plug section)
syntax enable
filetype plugin indent on
" let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_italic = 1
augroup ColorSchemeOverrides
    " Possibly fix color strings being hard to distinguish from functions
    " autocmd ColorScheme * highlight String guifg=#0f7d09

    " Fix errorneous markdown rendering for reST style python docstrings
    " on hover. May be resolved by:
    " https://github.com/palantir/python-language-server/issues/760
    " https://github.com/nvim-lua/completion-nvim/issues/243
    " autocmd ColorSchemeOverrides ColorScheme * highlight markdownError guibg=multiple_cursors_visual
    " autocmd ColorSchemeOverrides ColorScheme * highlight markdownBold guibg=multiple_cursors_visual
    " autocmd ColorSchemeOverrides ColorScheme * highlight markdownItalic guibg=multiple_cursors_visual
augroup END

colorscheme gruvbox

" Setup all nvim lua specific configuration
lua << EOF
local nvim_lsp = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsputil = require('lspconfig/util')
local on_attach = lsputil.on_attach
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

venv = exists("./.venv/") and "./.venv" or nil
nvim_lsp.pylsp.setup({
  cmd = {"pylsp", "--log-file", "/home/ecly/pylsp.log", "-v"},
  capabilities = capabilities,
  on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
  end,
  cmd_env = {VIRTUAL_ENV = venv, PATH = lsputil.path.join(venv, 'bin') .. ':' .. vim.env.PATH},
  enable = true,
  settings = {
    pylsp = {
      configurationSources = {},
      plugins = {
        jedi = { extra_paths = {"./dags"}, environment = venv, enabled = true },
        pydocstyle = { enabled = false },
        pylint = { enabled = false },
        rope = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        yapf = { enabled = false },
        mccabe = { enabled = false },
        pylsp_mypy = { enabled = false },
        pylsp_black = { enabled = false },
        pylsp_isort = { enabled = false },
      }
    }
  }
})

-- configure null_ls as general purpose linter
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.pylint.with({
          prefer_local = ".venv/bin",
          extra_args = { "-d", "missing-function-docstring", "-d", "invalid-name", "-d", "missing-module-docstring", "-d", "missing-class-docstring"}
        }),
        require("null-ls").builtins.formatting.black.with({
          prefer_local = ".venv/bin",
          cwd = function(params)
            return require("lspconfig")["pylsp"].get_root_dir(params.bufname)
          end,
        }),
        require("null-ls").builtins.formatting.isort.with({
          prefer_local = ".venv/bin",
          cwd = function(params)
            return require("lspconfig")["pylsp"].get_root_dir(params.bufname)
          end,
        }),

    },
})
require("null-ls").setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = {"lua-language-server"},
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- setup several out of the box language servers
-- vimls currently disabled due to missing support
local servers = { 'rls', 'gopls', 'dockerls', 'bashls', 'yamlls', 'terraformls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

require"lspconfig".elixirls.setup{
    -- based on default arch linux 'elixir-ls' package install
  capabilities = capabilities,
  cmd = { "/usr/sbin/elixir-ls" }
}

-- Below need some fixing
-- require"lspconfig".sqlls.setup{}
require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "comment",
    "cpp",
    "cpp",
    "css",
    "dockerfile",
    "elixir",
    "go",
    "haskell",
    "html",
    "java",
    "javascript",
    "json",
    "latex",
    "lua",
    "python",
    "regex",
    "ruby",
    "rust",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    -- override keyword.operator which otherwise isn't highlighted with gruvbox.nvim/TS combination
    custom_captures = {
      ["keyword.operator"] = "Tag",
    }
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

-- completion
local luasnip = require'luasnip'
local cmp = require'cmp'
local lspkind = require'lspkind'
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'path' },
    { name = 'nvim_lua' },
  },
  sorting = {
      comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require "cmp-under-comparator".under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
      },
  },
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

require('lualine').setup{
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    -- lualine_c = {'filename'},
    lualine_x = {{'diagnostics', sources = {"nvim_diagnostic"}}, 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

local cfg = require('bufferline.config')
cfg.set() -- ensure base cfg is created
cfg.update_highlights() -- trigger default color generation
local colors = cfg.get("highlights")
local bg = colors.background.guibg
local fg = colors.background.guifg
local fill_bg = colors.tab_selected.guifg

-- adjust bufferline to with gruvbox in a more subtle way
-- and synchronize better with signcolumn
require('bufferline').setup{
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
  highlights = {
    fill = {
      guibg = fill_bg
    },
    background = {
      guibg = fill_bg,
    },
    buffer_selected = {
      guibg = fill_bg,
      gui = "bold,italic",
    },
    buffer_visible = {
      guibg = fill_bg
    },
    separator = {
      guifg = fg,
      guibg = fill_bg
    },
    separator_selected = {
      guifg = fg,
      guibg = fill_bg
    },
    -- make indicator invisble
    indicator_selected = {
      guifg = fill_bg,
      guibg = fill_bg
    },
    modified = {
      guibg = fill_bg
    },
    modified_selected = {
      guibg = fill_bg
    },
  }
}

require("which-key").setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    virtual_text = {
      spacing = 0,
      prefix = '■',
    },
    update_in_insert = false,
  }
)

require('lspkind').init({
  symbol_map = {
    Class = "∴",
    Color = "",
    Constant = "",
    Constructor = '⬡',
    -- Constructor = 'ᲃ',
    -- Constructor = '⌬',
    -- Constructor = '⎔',
    -- Constructor = '⚙',
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = '🠶',
    -- Field = '→',
    -- Field = '∴',
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "",
    Property = '∷',
    -- Property = '::',
    Reference = "",
    Snippet = "",
    Struct = '',
    Text = "",
    TypeParameter = "",
    Unit = '()',
    Value = "",
    Variable = "",
  },
})

require'lspsaga'.init_lsp_saga()
require'nvim-tree'.setup({
  git = {
    ignore = True
  }
})
EOF

" Fix compe documentation view
highlight link CompeDocumentation Pmenu
" nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" nnoremap <silent>K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent><leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent>rn <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Configure completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "<S-Tab>"


autocmd autos Filetype * setlocal omnifunc=v:lua.vim.lsp.omnifunc
let g:completion_trigger_on_delete = 1

" Set signs for LSP Diagnostics
sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=  texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=

" Auto strip whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'vimwiki']
nnoremap <silent> <leader>T :StripWhitespace<CR>

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

nnoremap <C-n> :NvimTreeToggle<CR>

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

let g:slime_target = 'tmux'
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{last}'}

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


