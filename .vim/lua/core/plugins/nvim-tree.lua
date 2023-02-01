-- fast tree view for file navigation
local map = require('core.utils').map
local M = {
         'kyazdani42/nvim-tree.lua',
         dependencies = {'nvim-tree/nvim-web-devicons'},
         config = function()
             require'nvim-tree'.setup {
                 git = {enable = true, ignore = true}
                 -- view = {
                 -- auto_resize = true
                 -- mappings = {list = {{key = "<Tab>", action = "preview"}}}
                 -- }
             }
         end
}

return M
