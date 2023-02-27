-- generic lsp supporting integration with many different tools
local M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        local nls = require("null-ls")
        nls.setup({
            sources = {
                nls.builtins.diagnostics.pylint.with({
                    cwd = function(params)
                        return vim.fn.fnamemodify(params.bufname, ':h')
                    end,
                    debounce = 1000,
                    prefer_local = ".venv/bin",
                    method = nls.methods.DIAGNOSTICS_ON_SAVE,
                    -- pylint is slow for big projects, let's give it up to 10s
                    timeout = 10000,
                    extra_args = {
                        "-d", "missing-function-docstring", "-d",
                        "invalid-name", "-d", "missing-module-docstring", "-d",
                        "missing-class-docstring", "-d", "W1514", -- open without explicit encoding
                        "-d", "too-few-public-methods", "-d", "line-too-long",
                    }
                }), nls.builtins.formatting.black.with({
                    cwd = function(params)
                        return vim.fn.fnamemodify(params.bufname, ':h')
                    end,
                    prefer_local = ".venv/bin"
                }), nls.builtins.formatting.isort.with({
                    cwd = function(params)
                        return vim.fn.fnamemodify(params.bufname, ':h')
                    end,
                    prefer_local = ".venv/bin"
                }), nls.builtins.formatting.lua_format.with({}),
                nls.builtins.diagnostics.ruff.with({extra_args={"--ignore", "E501"}}) -- ignore line length
            }
        })
    end
}

return M
