require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {strings = false, operators = false, comments = true},
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    dim_inactive = false,
    -- we use same colorscheme in terminal/tmux
    transparent_mode = true
})
vim.cmd([[colorscheme gruvbox]])
