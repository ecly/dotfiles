-- better visualization and stripping of whitespace
local M = {
        'ntpeters/vim-better-whitespace',
        dependencies = { 'editorconfig/editorconfig-vim'},
        config = function()
            -- Whitespace settings
            vim.g.better_whitespace_enabled = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0
            vim.g.better_whitespace_filetypes_blacklist = {
                'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown',
                'fugitive', 'vimwiki'
            }
        end
}

return M
