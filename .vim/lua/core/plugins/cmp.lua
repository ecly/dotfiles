-- better completion support
-- functions for super tab like support
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

local M = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lua', 'lukas-reineke/cmp-under-comparator',
        'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', 'onsails/lspkind-nvim',
        'hrsh7th/cmp-calc', 'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    event = "InsertEnter",
    config = function()
        local cmp = require 'cmp'
        local lspkind = require('lspkind')
        cmp.setup {
            window = {
                -- currently using noice instead
                documentation = cmp.config.disable
            },
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end
            },
            formatting = {
                format = function(entry, vim_item)
                    -- fancy icons and a name of kind
                    vim_item.kind = lspkind.presets.default[vim_item.kind] ..
                                        " " .. vim_item.kind
                    -- set a name for each source
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        vsnip = "[Snippet]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]"
                    })[entry.source.name]
                    return vim_item
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete({}),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.fn["vsnip#available"](1) == 1 then
                        feedkey("<Plug>(vsnip-expand-or-jump)", "")
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                    end
                end, {"i", "s"}),

                ["<S-Tab>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                        feedkey("<Plug>(vsnip-jump-prev)", "")
                    end
                end, {"i", "s"})
            }),
            sources = cmp.config.sources({
                {name = 'nvim_lsp'}, {name = 'vsnip'},
                {name = 'buffer', keyword_length = 5}, {name = 'path'},
                {name = 'nvim_lua'}, {name = 'nvim_lsp_signature_help'}
            }),
            sorting = {
                comparators = {
                    cmp.config.compare.offset, cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require"cmp-under-comparator".under,
                    cmp.config.compare.kind, cmp.config.compare.sort_text,
                    cmp.config.compare.length, cmp.config.compare.order
                }
            }
        }
    end
}

return M
