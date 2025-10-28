-- fast statusline with good theming/lsp support
local M = {
    'nvim-lualine/lualine.nvim',
    config = function()
        local settings = require("core.settings")
        require('lualine').setup {
            options = {theme = settings.theme},
            -- mostly default with lower refresh.
            -- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#default-configuration
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
                refresh_time = 32, -- ~30
                events = {
                    'WinEnter', 'BufEnter', 'BufWritePost', 'SessionLoadPost',
                    'FileChangedShellPost', 'VimResized', 'Filetype',
                    'CursorMoved', 'CursorMovedI', 'ModeChanged'
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch'},
                -- lualine_c = {'filename'},
                lualine_x = {
                    {'diagnostics', sources = {"nvim_diagnostic"}}, 'filetype'
                },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            }
        }
    end
}

return M
