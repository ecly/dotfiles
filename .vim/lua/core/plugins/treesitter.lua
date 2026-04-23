local settings = require("core.settings")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master", -- CRITICAL: Forces the stable API
        lazy = false,      -- Load immediately on boot
        priority = 1000,
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
            { "nvim-treesitter/nvim-treesitter-context", branch = "master" },
        },
        config = function()
            -----------------------------------------------------------------------
            -- 1. PLUGIN CONFIGURATION (Parsers & Textobjects)
            -----------------------------------------------------------------------
            -- Because we pinned to "master", this module actually exists again!
            require("nvim-treesitter.configs").setup({
                ensure_installed = settings.treesitter_ensure_installed or "all",
                sync_install = false,
                auto_install = true,

                -- Keep these false so native Neovim 0.12 takes over
                highlight = { enable = false },
                indent = { enable = false },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
                        goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
                        goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
                        goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' }
                    }
                }
            })

            -----------------------------------------------------------------------
            -- 2. NATIVE 0.12 HIGHLIGHTING & FOLDING
            -----------------------------------------------------------------------
            local ts_group = vim.api.nvim_create_augroup('NativeTreesitter', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = ts_group,
                callback = function(args)
                    local bufnr = args.buf
                    local ft = vim.bo[bufnr].filetype
                    local lang = vim.treesitter.language.get_lang(ft)

                    if lang then
                        -- Prevent the 'white text' fallback
                        vim.bo[bufnr].syntax = 'off'

                        -- Start native Treesitter safely
                        local ok = pcall(vim.treesitter.start, bufnr, lang)

                        -- Apply folding only to real files (ignores hover windows)
                        if ok and vim.bo[bufnr].buftype == "" then
                            vim.wo.foldmethod = 'expr'
                            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        end
                    end
                end,
            })

            -----------------------------------------------------------------------
            -- 3. EXTRAS (Context & Captures)
            -----------------------------------------------------------------------
            require('treesitter-context').setup({ max_lines = 3 })
            vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Tag" })
        end
    }
}
