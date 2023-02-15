-- browse key bindings
local M = {
    'folke/which-key.nvim',
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 100

        require("which-key").setup({})
    end
}
return M
