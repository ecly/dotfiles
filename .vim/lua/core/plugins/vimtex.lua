-- latex ft support including visualization/make
local M = {
    'lervag/vimtex',
    config = function()
        -- Latex settings
        vim.g.tex_conceal = ''
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
        -- use neovim-remote for callbacks
        vim.g.vimtex_compiler_progname = 'nvr'
    end
}
return M
