-- treesitter for wonderful coloring and navigation of textobjects
local M = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-context'
    },
    config = function()
        local settings = require("core.settings")
        require'treesitter-context'.setup({
            max_lines = 3,
            multiline_threshold = 1,
            min_window_height = 20
        })
        require('nvim-treesitter.configs').setup {
            ensure_installed = settings.treesitter_ensure_installed,
            highlight = {
                enable = true,
                -- override keyword.operator which otherwise isn't highlighted with gruvbox.nvim/TS combination
                custom_captures = {["keyword.operator"] = "Tag"}
            },
            refactor = {highlight_definitions = {enable = true}},
            indent = {enable = true, disable = {"python"}},
            context_commentstring = {enable = true, enable_autocmd = false},
            incremental_selection = {
                enable = true,
                keymaps = {
                    -- shoutout cristi
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-backspace>",
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
    end
}

return M
