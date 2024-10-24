-- seamless navigation between vim and tmux splits and better clipboard support
local M = {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    config = function() return require("tmux").setup() end
}

return M
