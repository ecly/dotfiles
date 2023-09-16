--better visualization of git conflicts
local M = {
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup()
    end
}

return M
