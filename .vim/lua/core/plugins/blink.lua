local M = {
    -- add blink.compat
    {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {}
    }, {
        "saghen/blink.cmp",
        version = '*',
        enabled = true,
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        dependencies = {
            "rafamadriz/friendly-snippets", -- add blink.compat to dependencies
            {"saghen/blink.compat", opts = {}}, "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua", "lukas-reineke/cmp-under-comparator",
            "onsails/lspkind-nvim", "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lsp-signature-help"
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
                kind_icons = {Copilot = ""}
            },
            -- experimental signature help support
            -- -- signature = {enabled = true},
            cmdline = {sources = {}},
            sources = {
                default = {
                    "lsp", "path", "snippets", "buffer", "nvim_lua",
                    "nvim_lsp_signature_help"
                },
                providers = {
                    nvim_lua = {
                        name = "nvim_lua",
                        module = "blink.compat.source"
                    },
                    nvim_lsp_signature_help = {
                        name = "nvim_lsp_signature_help",
                        module = "blink.compat.source"
                    },
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
                ["<Enter>"] = {"select_and_accept", "fallback"},
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
