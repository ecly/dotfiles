-- peek into registers with @ and \"
local M = {
    'junegunn/vim-peekaboo',
    lazy = true,
    config = function() vim.g.peekaboo_delay = 200 end
}
return M
