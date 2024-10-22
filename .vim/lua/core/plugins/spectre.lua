-- regex search/replace across project with visualization
local M = {
    "nvim-pack/nvim-spectre",
    lazy = true,
    config = function() return require("spectre").setup() end,
    dependencies = {'nvim-lua/plenary.nvim'}
}

return M
