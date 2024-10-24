-- prettification of todo comments and similar in code
local M = {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function() require("todo-comments").setup {} end
}
return M
