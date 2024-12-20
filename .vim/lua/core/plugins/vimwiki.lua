-- support for wiki handling through nvim
local M = {
    "vimwiki/vimwiki",
    lazy = false, -- lazy can ruin inital formatting
    ft = {"vimwiki", "markdown"},
    config = function()
        vim.g.vimwiki_list = {
            {
                path = "~/Documents/work/vimwiki/",
                syntax = "markdown",
                ext = ".md"
            },
            {
                path = "~/Documents/irl/vimwiki/",
                syntax = "markdown",
                ext = ".md"
            }
        }
        vim.g.vimwiki_key_mappings = {table_mappings = 0}
    end
}

return M
