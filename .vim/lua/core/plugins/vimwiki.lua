-- support for wiki handling through nvim
local M = {
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/Documents/work/vimwiki/',
                    syntax = 'markdown',
                    ext = '.md'
                },
                {
                    path = '~/Documents/irl/vimwiki/',
                    syntax = 'markdown',
                    ext = '.md'
                }
            }
        end
}

return M
