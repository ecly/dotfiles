-- fast statusline with good theming/lsp support
local M = {
         'nvim-lualine/lualine.nvim',
         config = function()
            local settings = require("core.settings")
             require('lualine').setup {
                 options = {theme = settings.theme},
                 sections = {
                     lualine_a = {'mode'},
                     lualine_b = {'branch'},
                     -- lualine_c = {'filename'},
                     lualine_x = {
                         {'diagnostics', sources = {"nvim_diagnostic"}},
                         'filetype'
                     },
                     lualine_y = {'progress'},
                     lualine_z = {'location'}
                 }
             }
         end
}

return M
