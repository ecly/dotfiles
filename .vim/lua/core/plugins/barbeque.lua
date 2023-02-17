local M = {
    "utilyre/barbecue.nvim",
    dependencies = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons"},
    config = function()
        require("barbecue").setup({
            symbols = {separator = ""},
            -- icons from https://github.com/glepnir/lspsaga.nvim/blob/main/lua/lspsaga/lspkind.lua
            kinds = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = '了',
                Interface = ' ',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                EnumMember = ' ',
                Struct = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' ',
                TypeAlias = ' ',
                Parameter = ' ',
                StaticMethod = 'ﴂ ',
                Macro = ' ',
                Text = ' ',
                Snippet = ' ',
                Folder = ' ',
                Unit = ' ',
                Value = ' '
            }
        })
    end
}

return M
