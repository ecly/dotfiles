local settings = require("core.settings")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        lazy = false,
        priority = 1000,
        dependencies = {
            {"nvim-treesitter/nvim-treesitter-textobjects", branch = "master"},
            {"nvim-treesitter/nvim-treesitter-context", branch = "master"}
        },
        -- NEW: The Advanced Interceptor & Polyfill
        init = function()
            -- 1. Stop the original `range()` crash by blocking the legacy predicates file
            package.loaded['nvim-treesitter.query_predicates'] = {}

            -- 2. Restore Markdown Code Block Highlighting
            vim.schedule(function()
                local ok, query = pcall(require, "vim.treesitter.query")
                if ok and query.add_directive then

                    -- This custom handler reads the markdown code block and injects the proper syntax
                    pcall(query.add_directive, "set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
                        -- pred[2] is the internal ID for the matched string
                        local capture_id = pred[2]
                        if not capture_id then return end

                        -- Extract the actual Treesitter node (handling 0.12's table structure)
                        local node = match[capture_id]
                        if type(node) == "table" then node = node[1] end
                        if not node then return end

                        -- Safely get the text of the node using the modern 0.12 API
                        local ok_text, text = pcall(vim.treesitter.get_node_text, node, bufnr)
                        if not ok_text or type(text) ~= "string" then return end

                        -- Grab the first word (e.g., extracting "python" from "python class")
                        local lang = text:match("^%s*([%w_%-]+)")
                        if lang then
                            -- Tell Neovim's native engine to highlight this block!
                            metadata.injection = metadata.injection or {}
                            metadata.injection.language = lang
                        end
                    end, { force = true })

                end
            end)
        end,

        config = function()
            -----------------------------------------------------------------------
            -- 1. PLUGIN CONFIGURATION
            -----------------------------------------------------------------------
            require("nvim-treesitter.configs").setup({
                ensure_installed = settings.treesitter_ensure_installed or "all",
                sync_install = false,
                auto_install = true,

                highlight = {enable = false},
                indent = {enable = false},

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer'
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer'
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer'
                        }
                    }
                }
            })

            -----------------------------------------------------------------------
            -- 2. NATIVE 0.12 HIGHLIGHTING & FOLDING
            -----------------------------------------------------------------------
            local ts_group = vim.api.nvim_create_augroup('NativeTreesitter',
                                                         {clear = true})
            vim.api.nvim_create_autocmd('FileType', {
                group = ts_group,
                callback = function(args)
                    local bufnr = args.buf
                    local bt = vim.bo[bufnr].buftype

                    -- CRITICAL GUARD: Skip LSP hover menus and floating UI
                    if bt == "nofile" or bt == "prompt" then
                        return
                    end

                    local ft = vim.bo[bufnr].filetype
                    local lang = vim.treesitter.language.get_lang(ft)

                    if lang then
                        vim.bo[bufnr].syntax = 'off'
                        local ok = pcall(vim.treesitter.start, bufnr, lang)

                        if ok then
                            vim.wo.foldmethod = 'expr'
                            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        end
                    end
                end
            })

            -----------------------------------------------------------------------
            -- 3. EXTRAS
            -----------------------------------------------------------------------
            require('treesitter-context').setup({max_lines = 3})
            vim.api.nvim_set_hl(0, "@keyword.operator", {link = "Tag"})
        end
    }
}
