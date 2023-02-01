
-- generic lsp supporting integration with many different tools
local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
        local nls = require("null-ls")
        nls.setup({
            sources = {
                nls.builtins.diagnostics.pylint.with({
                    cwd = function(params)
                        return vim.fn.fnamemodify(params.bufname, ':h')
                    end,
                    prefer_local = ".venv/bin",
                    -- pylint is slow for big projects, let's give it up to 10s
                    timeout = 10000,
                    extra_args = {
                        "-d", "missing-function-docstring", "-d", "invalid-name", "-d",
                        "missing-module-docstring", "-d", "missing-class-docstring",
                        "-d", "W1514", -- open without explicit encoding
                        "-d", "too-few-public-methods"
                    },
                }), nls.builtins.formatting.black.with({
                    cwd = function(params)
                        return vim.fn.fnamemodify(params.bufname, ':h')
                    end,
                    prefer_local = ".venv/bin",
                }), nls.builtins.formatting.isort.with({
                    cwd = function(params)
                        return vim.fn.fnamemodify(params.bufname, ':h')
                    end,
                    prefer_local = ".venv/bin",
                }), nls.builtins.formatting.lua_format.with({}),
            }
        })
  end
}

return M
