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
                nerd_font_variant = 'mono'
            },
            -- experimental signature help support
            -- -- signature = {enabled = true},
            sources = {
                default = {
                    "lsp", "path", "snippets", "buffer", "nvim_lua",
                    "nvim_lsp_signature_help"
                },
                cmdline = {},
                providers = {
                    nvim_lua = {
                        name = "nvim_lua",
                        module = "blink.compat.source"
                    },
                    nvim_lsp_signature_help = {
                        name = "nvim_lsp_signature_help",
                        module = "blink.compat.source"
                    }
                }
            },

            keymap = {
                ["<Tab>"] = {"select_next", "fallback"},
                ["<S-Tab>"] = {"select_prev", "fallback"},
                ["<C-y>"] = {"select_and_accept", "fallback"},
                ["<Enter>"] = {"select_and_accept", "fallback"}

            }
        },
        opts_extend = {
            "sources.completion.enabled_providers", "sources.compat",
            "sources.default"
        }
    }
}

return M
