-- send text to a tmux pane
local M = {
    'jpalardy/vim-slime',
    event = "VeryLazy",
    config = function()
        -- Tmux configuration for slime
        vim.g.slime_target = 'tmux'
        vim.g.slime_default_config = {
            socket_name = 'default',
            target_pane = '{last}'
        }
    end
}
return M
