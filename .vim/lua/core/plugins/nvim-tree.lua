-- fast tree view for file navigation
local M = {
    "kyazdani42/nvim-tree.lua",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("nvim-tree").setup({
            git = {enable = true, ignore = true},
            view = {adaptive_size = true},
            update_cwd = true,
            renderer = {icons = {show = {folder = false}}}
        })
    end
}

return M
