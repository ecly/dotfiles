local M = {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = {"lua-format", "stylua", stop_after_first = true},
                python = {"isort", "black"},
                -- run only first available
                javascript = {"prettierd", "prettier", stop_after_first = true},
                yaml = {"prettierd", "prettier", stop_after_first = true},
                go = {"gofmt"}
            }
        })
        vim.o.formatexpr =
            "v:lua.require'conform'.formatexpr( lsp_fallback = true )"
    end
}

return M
