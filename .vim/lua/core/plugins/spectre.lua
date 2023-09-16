-- regex search/replace across project with visualization
local M = {
    "nvim-pack/nvim-spectre",
    config = function() return require("spectre").setup() end,
    dependencies = {'nvim-lua/plenary.nvim'},
}

return M
