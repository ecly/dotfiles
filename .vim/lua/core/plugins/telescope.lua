-- quick fuzzy lookup of files
--
if vim.fn.has('macunix') then
    FZF_BUILD_CMD = "arch -arm64 make"
else
    FZF_BUILD_CMD = "make"
end
local M = {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', build = FZF_BUILD_CMD}
    },
    config = function()
        -- Telescope settings
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-h>"] = actions.select_horizontal,
                        ["<C-->"] = actions.select_horizontal,
                        ["<C-\\>"] = actions.select_vertical
                    }
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                }
            }
        }

        telescope.load_extension('fzf')

    end
}
return M
