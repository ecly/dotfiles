-- seamless navigatio between vim and tmux splits and better clipboard support
local M = {
    'alexghergh/nvim-tmux-navigation',
    dependencies = {'roxma/vim-tmux-clipboard'},
    config = function()
        require'nvim-tmux-navigation'.setup {
            disable_when_zoomed = true, -- defaults to false
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
                last_active = "<C-\\>",
                next = "<C-Space>",
            }
        }
    end
}
return M
