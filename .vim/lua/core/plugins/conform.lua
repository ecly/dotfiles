local M = {
    "stevearc/conform.nvim",
    lazy = true,
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = {{"lua-format", "stylua"}},
                python = {"isort", "black"},
                -- run only first available
                javascript = {{"prettierd", "prettier"}},
                yaml = {{"prettierd", "prettier"}},
                go = {"gofmt"}
            }
        })
        vim.o.formatexpr =
            "v:lua.require'conform'.formatexpr( lsp_fallback = true )"
    end
}

return M
