-- preview markdown in browser, synchronized with nvim
local M = {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = {"markdown"},
    event = "VeryLazy",
    opts = {latex = {enabled = false}},
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = {
        'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'
    } -- if you prefer nvim-web-devicons
}
return M
