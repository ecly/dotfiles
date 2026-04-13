-- treesitter for wonderful coloring and navigation of textobjects
local M = {
    -- 1. The new lightweight manager replacing nvim-treesitter
    'romus204/tree-sitter-manager.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        -- Note: 'nvim-treesitter-refactor' is removed. It's unmaintained and
        -- mostly replaced by native LSP features (like vim.lsp.buf.rename).
    },
    config = function()
        local settings = require("core.settings")

        -----------------------------------------------------------------------
        -- A. PARSER INSTALLATION
        -----------------------------------------------------------------------
        require("tree-sitter-manager").setup({
            -- It uses standard data paths by default. You install languages
            -- via the `:TSManager` TUI command.
        })

        -----------------------------------------------------------------------
        -- B. NATIVE HIGHLIGHTING & FOLDING (Neovim 0.12+)
        -----------------------------------------------------------------------
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('NativeTreesitter', { clear = true }),
            callback = function(args)
                -- 1. Start Highlighting
                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if lang then
                    pcall(vim.treesitter.start, args.buf, lang)
                end

                -- 2. Enable Native Folds
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
            end,
        })

        -----------------------------------------------------------------------
        -- C. CUSTOM CAPTURES -> NATIVE HIGHLIGHT GROUPS
        -----------------------------------------------------------------------
        -- Overriding keyword.operator (Replaces `custom_captures`)
        vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Tag" })

        -----------------------------------------------------------------------
        -- D. CONTEXT (Sticky Headers)
        -----------------------------------------------------------------------
        require('treesitter-context').setup({
            max_lines = 3,
            multiline_threshold = 1,
            min_window_height = 20
        })

        -----------------------------------------------------------------------
        -- E. TEXTOBJECTS
        -----------------------------------------------------------------------
        -- Even though the base plugin is archived, the textobjects extension
        -- still hooks into the legacy configs module for now.
        require('nvim-treesitter.configs').setup({
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
        })
    end
}

return M
