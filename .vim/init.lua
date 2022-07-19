-- Utility section
local function map(mode, lhs, rhs, opts)
    -- https://oroques.dev/notes/neovim-init/
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function _G.abbreviate_or_noop(input, output)
    -- https://stackoverflow.com/a/69951171
    local cmdtype = vim.fn.getcmdtype()
    local cmdline = vim.fn.getcmdline()

    if (cmdtype == ":" and cmdline == input) then
        return output
    else
        return input
    end
end

local function alias_command(input, output)
    -- https://stackoverflow.com/a/69951171
    vim.api.nvim_command("cabbrev <expr> " .. input .. " " ..
                             "v:lua.abbreviate_or_noop('" .. input .. "', '" ..
                             output .. "')")
end

local function exists(file)
    -- https://stackoverflow.com/a/40195356/4000764
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                       install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Colorscheme configuration
    use {'ellisonleao/gruvbox.nvim', commit="dc6bae9"}
    use 'folke/tokyonight.nvim'

    -- LSP Setup
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'lukas-reineke/cmp-under-comparator'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind-nvim'

    -- Add git related info in the signs columns and popups
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }

    -- Extra plugin for null-ls
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Some beautification of built-in LSP
    use {
        'glepnir/lspsaga.nvim',
        config = function()
            require('lspsaga').init_lsp_saga {}
        end
    }

    -- Language/file specific plugins
    use 'elixir-editors/vim-elixir'
    use 'elzr/vim-json'
    use 'PotatoesMaster/i3-vim-syntax'
    use 'cespare/vim-toml'
    use {'chrisbra/csv.vim', ft = {"tsv", "csv"}}
    use 'ekalinin/Dockerfile.vim'
    use {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        run = "cd app && yarn install"
    }
    use 'lervag/vimtex'
    use 'vimwiki/vimwiki'

    use {
        'folke/which-key.nvim',
        config = function() require("which-key").setup {} end
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup {} end
    }
    use({
        "folke/lsp-colors.nvim",
        config = function() require('lsp-colors').setup {} end
    })

    -- Filepicker (Among other things)
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- Treesitter plugins
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'

    -- Tmux configuration
    use 'christoomey/vim-tmux-navigator'
    use 'roxma/vim-tmux-clipboard'
    use 'jpalardy/vim-slime' -- <C-c><C-c> to send chunk to tmux pane

    -- Auto-detect indentation
    use 'tpope/vim-sleuth'

    -- Statusline and bufferline
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/nvim-bufferline.lua'

    use 'lukas-reineke/indent-blankline.nvim'

    -- Tpope plugins
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    -- Automatic tags management
    use 'ludovicchabant/vim-gutentags'
    vim.g.gutentags_cache_dir = "~/.cache/gutentags"

    -- Easy commenting with gcc
    use 'b3nj5m1n/kommentary'

    -- File tree browser
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require'nvim-tree'.setup {
                git = {enable = true, ignore = true},
                -- view = {
                    -- auto_resize = true
                    -- mappings = {list = {{key = "<Tab>", action = "preview"}}}
                -- }
            }
        end
    }

    -- Update vim settings based on .editorconfig
    use 'editorconfig/editorconfig-vim'
    use 'ntpeters/vim-better-whitespace'

    -- Peek into registers with @ and \"
    use 'junegunn/vim-peekaboo'
    vim.g.peekaboo_delay = 200

    -- Split/join one-liners with gS/gJ
    use 'AndrewRadev/splitjoin.vim'
    use 'Konfekt/FastFold'

    -- Highlight matches patterns from Ex commands
    use 'markonm/traces.vim'

    -- Automatically detect sensible root directory
    use 'airblade/vim-rooter'

    -- Nice diffview for vim with DiffviewOpen
    use 'sindrets/diffview.nvim'

    -- Unit test handling
    use {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        -- Debug setup
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
      }
    }

    require("neotest").setup({
      output = {
        enabled = true,
        open_on_run = true,
      },
      adapters = {
        require("neotest-python")({
            args = {"--integration"},
            dap = { justMyCode = false, console = "integratedTerminal" },
            runner = "pytest",
        }),
        require("neotest-plenary"),
      }
    })
    -- TODO still not working perfectly and missing some keybinds
    require('dap-python').setup('.venv/bin/python')
    require('dap-python').test_runner = 'pytest'
end)

-- Use system clipboard
vim.cmd [[set clipboard+=unnamedplus]]
-- Enable mouse mode
vim.o.mouse = "a"
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Set completevim.o to have a better completion experience
vim.o.completeopt = 'menuone,noselect,preview'
-- Lightline shows this already
vim.o.showmode = false
-- Always show status line
vim.o.laststatus = 2
-- Indentation configuration
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
-- Relative line numbers but absolute for current line
vim.o.relativenumber = true
vim.wo.number = true
-- Hide buffers instead of closing them
vim.o.hidden = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Don't beep
vim.o.visualbell = true -- Don't beep
vim.o.t_vb = nil
vim.o.errorbells = false -- Don't beep
-- Don't backup
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- Show matching braces when over one
vim.o.showmatch = true
vim.o.backspace = 'indent,eol,start' -- Allow backspacing everything in insert
vim.o.hlsearch = true -- Highlight searches
vim.o.incsearch = true -- Search as typing
vim.o.concealcursor = nil -- Never conceal anything on current line
-- Persistent undo handling
vim.o.undodir = "/tmp/vim-undo"
vim.o.undofile = true
vim.o.lazyredraw = true -- Speedup large files and macros
vim.o.updatetime = 100 -- Default 4000 is a bit high for async updates
-- Intuitive default split directions
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showtabline = 2 -- Always show tabline
vim.o.shortmess = vim.o.shortmess .. 'c' -- Don't give ins-completion-menu messages
vim.o.signcolumn = 'yes' -- Always show signcolumn
-- Set colorscheme and true colors
vim.o.termguicolors = true
vim.o.t_8f = "[38;2;%lu;%lu;%lum"
vim.o.t_8b = "[48;2;%lu;%lu;%lum"
vim.cmd [[filetype plugin on]]
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.g.gruvbox_italic = 1

-- Base Keybindings
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('', '<Leader>/', ':nohlsearch<CR>')
-- Dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true})
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true})
-- Easy window/buffer navigation
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')
-- Intuitive split binds
map('', '<Tab>', ':bnext<CR>')
map('', '<S-Tab>', ':bprev<CR>')
-- Use :w!! to write with sudo even if not opened with
map('c', 'w!!', 'w !sudo tee >/dev/null %')
-- Address a few common mistakes I make when typing fast
alias_command('WQ', 'wq')
alias_command('Wq', 'wq')
alias_command('W', 'w')
alias_command('Q', 'q')
-- Clever replacement bindings courtesy of romainl
map('n', '<leader><leader>', [[ :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/ ]])
map('n', '<leader>%', [[ :%s/\<<C-r>=expand("<cword>")<CR>\>/ ]])

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Make <C-x><C-o> trigger LSP auto-completion
vim.cmd [[
  augroup Omnifunc
    autocmd!
    autocmd Filetype * setlocal omnifunc=v:lua.vim.lsp.omnifunc
  augroup end
]]

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash", "c", "c_sharp", "comment", "cpp", "cpp", "css", "dockerfile",
        "elixir", "go", "haskell", "hcl", "html", "java", "javascript", "json",
        "latex", "lua", "markdown", "python", "regex", "ruby", "rust", "toml",
        "typescript", "vim", "yaml"
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        -- override keyword.operator which otherwise isn't highlighted with gruvbox.nvim/TS combination
        custom_captures = {["keyword.operator"] = "Tag"}
    },
    refactor = {highlight_definitions = {enable = true}},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    },
    -- indent = {
    --   enable = true,
    -- },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        }
    }
}

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
    local opts = {noremap = true, silent = true}
    local bmap = vim.api.nvim_buf_set_keymap
    bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bmap(bufnr, 'n', '<leader>si', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
         opts)
    bmap(bufnr, 'n', '<leader>wa',
         '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    bmap(bufnr, 'n', '<leader>wr',
         '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    bmap(bufnr, 'n', '<leader>wl',
         '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
         opts)
    bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
         opts)
    bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    bmap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
         opts)
    bmap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
         opts)
    bmap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    bmap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    bmap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>',
         opts)
    bmap(bufnr, 'n', '<leader>so',
         [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
         opts)
    bmap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers with default configuration
local servers = {'rls', 'gopls', 'dockerls', 'bashls', 'yamlls', 'terraformls'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {on_attach = on_attach, capabilities = capabilities}
end

-- Make neovim runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
    cmd = {"lua-language-server"},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

local venv = exists("./.venv/") and "./.venv" or nil
lspconfig.pylsp.setup({
    cmd = {"pylsp", "--log-file", "/home/ecly/pylsp.log", "-v"},
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    cmd_env = {
        VIRTUAL_ENV = venv,
        PATH = require'lspconfig/util'.path.join(venv, 'bin') .. ':' ..
            vim.env.PATH
    },
    enable = true,
    settings = {
        pylsp = {
            configurationSources = {},
            plugins = {
                jedi = {
                    extra_paths = {"./dags"},
                    environment = venv,
                    enabled = true
                },
                pydocstyle = {enabled = false},
                pylint = {enabled = false},
                rope = {enabled = false},
                pyflakes = {enabled = false},
                pycodestyle = {enabled = false},
                yapf = {enabled = false},
                mccabe = {enabled = false},
                pylsp_mypy = {enabled = false},
                pylsp_black = {enabled = false},
                pylsp_isort = {enabled = false}
            }
        }
    }
})

-- null-ls as general purpose linter
require("null-ls").setup({
    -- debug = true,
    capabilities = capabilities,
    on_attach = on_attach,
    sources = {
        require("null-ls").builtins.diagnostics.pylint.with({
            prefer_local = ".venv/bin",
            -- pylint is slow for big projects, let's give it up to 10s
            timeout = 10000,
            extra_args = {
                "-d", "missing-function-docstring", "-d", "invalid-name", "-d",
                "missing-module-docstring", "-d", "missing-class-docstring",
                "-d", "W1514", -- open without explicit encoding
                "-d", "too-few-public-methods"
            },
            cwd = function(params)
                return require("lspconfig")["pylsp"]
                           .get_root_dir(params.bufname)
            end
        }), require("null-ls").builtins.formatting.black.with({
            -- still use versions that don't support --stdin-filename at work
            -- so in the meantime will use global
            -- prefer_local = ".venv/bin",
            cwd = function(params)
                return require("lspconfig")["pylsp"]
                           .get_root_dir(params.bufname)
            end
        }), require("null-ls").builtins.formatting.isort.with({
            prefer_local = ".venv/bin",
            cwd = function(params)
                return require("lspconfig")["pylsp"]
                           .get_root_dir(params.bufname)
            end
        }), require("null-ls").builtins.formatting.lua_format.with({})
    }
})

require"lspconfig".elixirls.setup {
    -- based on default arch linux 'elixir-ls' package install
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"/usr/sbin/elixir-ls"}
}

-- Configuration for completion client
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]"
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
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
        end
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'luasnip'},
        {name = 'buffer', keyword_length = 5}, {name = 'path'},
        {name = 'nvim_lua'}
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset, cmp.config.compare.exact,
            cmp.config.compare.score, require"cmp-under-comparator".under,
            cmp.config.compare.kind, cmp.config.compare.sort_text,
            cmp.config.compare.length, cmp.config.compare.order
        }
    }
}

require('lspkind').init({
    symbol_map = {
        Class = "∴",
        Color = "",
        Constant = "",
        -- Constructor = '⬡',
        Constructor = 'ᲃ',
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
        Variable = ""
    }
})

-- Telescope settings
local actions = require('telescope.actions')
require'telescope'.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-v>"] = actions.select_vertical,
                ["<C-h>"] = actions.select_horizontal
            }
        }
    }
}
map('n', '<C-p>', [[<cmd> lua require('telescope.builtin').find_files()<CR>]])
map('n', '<leader>fg',
    [[<cmd> lua require('telescope.builtin').git_files()<CR>]])
map('n', '<leader>fb', [[<cmd> lua require('telescope.builtin').buffers()<CR>]])

-- Configure statusline
require('lualine').setup {
    options = {theme = 'gruvbox'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        -- lualine_c = {'filename'},
        lualine_x = {{'diagnostics', sources = {"nvim_diagnostic"}}, 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}

-- Configure bufferline
local cfg = require('bufferline.config')
cfg.set({}) -- ensure base cfg is created
cfg.update_highlights() -- trigger default color generation
local colors = cfg.get("highlights")
local fg = colors.background.guifg
local fill_bg = colors.tab_selected.guifg

-- Adjust bufferline to with gruvbox in a more subtle way
-- and synchronize better with signcolumn
require('bufferline').setup {
    options = {show_buffer_close_icons = false, show_close_icon = false},
    highlights = {
        fill = {guibg = fill_bg},
        background = {guibg = fill_bg},
        buffer_selected = {guibg = fill_bg, gui = "bold,italic"},
        buffer_visible = {guibg = fill_bg},
        separator = {guifg = fg, guibg = fill_bg},
        separator_selected = {guifg = fg, guibg = fill_bg},
        -- make indicator invisble
        indicator_selected = {guifg = fill_bg, guibg = fill_bg},
        modified = {guibg = fill_bg},
        modified_selected = {guibg = fill_bg}
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        virtual_text = {spacing = 0, prefix = '■'},
        update_in_insert = false
    })

-- Whitespace settings
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0
vim.g.better_whitespace_filetypes_blacklist = {
    'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive',
    'vimwiki'
}
map('n', '<leader>T', ':StripWhitespace<CR>')

-- MarkdownPreview settings
vim.g.mkdp_auto_close = 0
map('n', '<C-s>', ':MarkdownPreview<CR>', {silent = false})

-- Tmux configuration for slime
vim.g.slime_target = 'tmux'
vim.g.slime_default_config = {socket_name = 'default', target_pane = '{last}'}

-- Vimwiki settings
vim.g.vimwiki_list = {
    {path = '~/Documents/work/vimwiki/', syntax = 'markdown', ext = '.md'},
    {path = '~/Documents/irl/vimwiki/', syntax = 'markdown', ext = '.md'}
}
-- Avoid VimWiki default binds overlapping with other binds
map('n', '<leader><Tab>', '<Plug>VimwikiNextLink')
map('n', '<leader><S-Tab>', '<Plug>VimwikiPrevLink')

-- Latex settings
vim.g.tex_conceal = ''
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
-- use neovim-remote for callbacks
vim.g.vimtex_compiler_progname = 'nvr'

-- Ultest settings/keybinds
map('n', '<leader>tn', ':lua require("neotest").run.run()<CR>')
map('n', '<leader>td', ':lua require("neotest").run.run({strategy = "dap"})<CR>')
map('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>')
map('n', '<leader>ts', ':lua require("neotest").run.run({suite=true})<CR>')

-- Re-source vimrc
map('n', '<leader>sv', ':luafile $MYVIMRC<CR>')

-- Nvim-tree bindings
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<C-n>', ':NvimTreeToggle<CR>')

-- Use wsl32yank if in WSL context
vim.cmd [[
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
]]
