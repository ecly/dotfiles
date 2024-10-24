-- preview markdown in browser, synchronized with nvim
local M = {
    "iamcco/markdown-preview.nvim",
    ft = {"markdown"},
    event = "VeryLazy",
    build = "cd app && yarn install",
    config = function()
        -- MarkdownPreview settings
        vim.g.mkdp_auto_close = 0
    end
}
return M
