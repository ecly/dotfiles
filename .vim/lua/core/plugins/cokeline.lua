-- bufferline matching the statusline
local M = {
    'willothy/nvim-cokeline',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('cokeline').setup()
    end
}
return M
