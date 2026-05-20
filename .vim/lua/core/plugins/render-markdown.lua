local M = {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        latex = { enabled = false },
        render_modes = { 'n', 'c', 'i' },
        anti_conceal = { enabled = false },

        -- THE V6.0 FIX: Safely ignore hover windows
        overrides = {
            buftype = {
                nofile = { enabled = false }
            }
        }
    },
}

return M
