-- show diffs from git in signcolumn
local M = {
    'lewis6991/gitsigns.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function() require('gitsigns').setup() end
}
return M
