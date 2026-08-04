local M = {
    {
        "saghen/blink.cmp",
        version = '*',
        enabled = true,
        dependencies = {
            "rafamadriz/friendly-snippets"
            -- "fang2hou/blink-copilot",
            -- {
            --     "zbirenbaum/copilot.lua",
            --     opts = {max_completions = 1, max_attempts = 2}
            -- }
        },
        event = "InsertEnter",
        opts = {
            completion = {
                list = {selection = {preselect = false, auto_insert = true}},
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {enabled = false}
                },
                menu = {
                    draw = {
                        treesitter = {"lsp"},
                        columns = {
                            {"label", "label_description", gap = 2},
                            {"kind_icon", "kind"}
                        }
                    }
                },
                documentation = {auto_show = true, auto_show_delay_ms = 200}
            },
            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
                kind_icons = {Copilot = ""}
            },
            signature = {enabled = true},
            cmdline = {enabled = true},
            sources = {
                default = {"lsp", "path", "snippets", "buffer"},
                providers = {
                    -- copilot = {
                    --     name = "copilot",
                    --     module = "blink-copilot",
                    --     score_offset = 100,
                    --     async = true,
                    --     opts = {
                    --         -- Local options override global ones
                    --         -- Final settings: max_completions = 3, max_attempts = 2, kind = "Copilot"
                    --         max_completions = 3 -- Override global max_completions
                    --     }
                    -- }
                }
            },

            keymap = {
                ["<Tab>"] = {"select_next", "fallback"},
                ["<S-Tab>"] = {"select_prev", "fallback"},
                ["<Enter>"] = {"select_and_accept", "fallback"}
                -- ["<C-y>"] = {
                --     function()
                --         local copilot = require 'copilot.suggestion'
                --         if copilot.is_visible() then
                --             copilot.accept()
                --         end
                --     end, "fallback"
                -- },
                -- ["<C-]>"] = {
                --     function()
                --         local copilot = require 'copilot.suggestion'
                --         if copilot.is_visible() then
                --             copilot.next()
                --         end
                --     end, "fallback"
                -- },
                -- -- this one seems to not work at the moment
                -- ["<C-[>"] = {
                --     function()
                --         local copilot = require 'copilot.suggestion'
                --         if copilot.is_visible() then
                --             copilot.prev()
                --         end
                --     end, "fallback"
                -- }
            }
        },
        opts_extend = {"sources.default"}
    }
}

return M
