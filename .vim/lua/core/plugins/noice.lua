local M = {
    "folke/noice.nvim",
    enabled = false,
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim", -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        -- "rcarriga/nvim-notify"
    },
    config = function()
        require("noice").setup({
            lsp = {
                progress = {enabled = false},
                hover = {enabled = true},
                signature = {enabled = true},
                message = {enabled = true},
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = false,
            },
            cmdline = {view = "cmdline"}
        })
    end
}

return M
