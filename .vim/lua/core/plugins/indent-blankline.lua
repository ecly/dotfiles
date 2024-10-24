-- better visualization of spaces/newlines
local M = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        vim.opt.list = true
        vim.opt.listchars:append "space:⋅"
        vim.opt.listchars:append "eol:↴"
        require("ibl").setup {scope = {enabled = true}}
    end
}

return M
