-- bufferline matching the statusline
local M = {
    'noib3/nvim-cokeline',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('cokeline').setup()
    end
}
return M
