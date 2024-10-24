local M = {
    "utilyre/barbecue.nvim",
    dependencies = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons"},
    config = function()
        require("barbecue").setup({
            symbols = {separator = ""}
            -- icons defaulted from https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/lspkind.lua
        })
    end
}

return M
