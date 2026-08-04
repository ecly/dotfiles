-- better quickfix visualization and extra functionality
local M = {
    'kevinhwang91/nvim-bqf',
    dependencies = {
        {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
    }
}

return M
