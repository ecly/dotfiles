local M = {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        latex = { enabled = false },
        render_modes = { 'n', 'c', 'i' },
        anti_conceal = { enabled = false },
        -- CRITICAL: This stops the 'range (nil value)' crash when pressing K
        exclude = {
            buftypes = { 'nofile' },
        },
    },
}

return M
