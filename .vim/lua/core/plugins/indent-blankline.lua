-- better visualization of spaces/newlines
local M = {
 "lukas-reineke/indent-blankline.nvim",
 config = function()
     vim.opt.list = true
     vim.opt.listchars:append "space:⋅"
     vim.opt.listchars:append "eol:↴"
     require("indent_blankline").setup {
         -- for example, context is off by default, use this to turn it on
         show_current_context = true,
         show_current_context_start = true,
         show_end_of_line = true,
         space_char_blankline = " "
     }
 end
}

return M
