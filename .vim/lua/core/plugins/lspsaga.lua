-- prettier visualization of LSP integrations
local M = {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = { {"nvim-tree/nvim-web-devicons"} },
    config = function()
        require("lspsaga").setup({
            scroll_in_preview = {
              scroll_down = "<C-d>",
              scroll_up = "<C-u>",
            },
        })
    end
}

return M
