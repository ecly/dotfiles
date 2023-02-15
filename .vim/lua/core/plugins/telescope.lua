-- quick fuzzy lookup of files
local M = {
         'nvim-telescope/telescope.nvim',
         dependencies = {
             'nvim-lua/plenary.nvim',
             {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'}
         },
         config = function()
             -- Telescope settings
             local telescope = require('telescope')
             local actions = require('telescope.actions')
             local builtin = require('telescope.builtin')
             telescope.setup {
                 defaults = {
                     mappings = {
                         i = {
                             ["<C-v>"] = actions.select_vertical,
                             ["<C-h>"] = actions.select_horizontal,
                             ["<C-->"] = actions.select_horizontal,
                             ["<C-\\>"] = actions.select_vertical,
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
