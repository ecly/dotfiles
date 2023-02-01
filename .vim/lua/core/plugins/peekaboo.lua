-- peek into registers with @ and \"
local M = {
        'junegunn/vim-peekaboo',
        config = function() vim.g.peekaboo_delay = 200 end
}
return M
