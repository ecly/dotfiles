-- easy commenting with command `gcc`
local M  = {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
return M
