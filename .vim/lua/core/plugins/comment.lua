-- easy commenting with command `gcc`
local M = {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function() require('Comment').setup() end
}
return M
