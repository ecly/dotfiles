local nvim_lsp = require("lspconfig")
local lsp_utils = require("core.plugins.lsp.utils")
local utils = require("core.utils")

-- setup capabilities with blink
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_blink, blink = pcall(require, "blink.cmp")
local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol
                                             .make_client_capabilities(),
                                         has_cmp and
                                             cmp_nvim_lsp.default_capabilities() or
                                             {}, has_blink and
                                             blink.get_lsp_capabilities() or {})

local servers = {
    "bashls", "dockerls", "jsonls", "marksman",
    -- "pyright", -- not currently working
    "gopls", "pylsp", "lua_ls", "terraformls", "texlab", "ts_ls", "yamlls"
}

-- we disable the providers because mason takes care of it
-- mason takes care of the setup of the lsp.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- this needs to be called before setting up lsps
require("mason").setup({})
require("mason-lspconfig").setup({automatic_installation = true})
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = function(client, bufnr)
            lsp_utils.custom_lsp_attach(client, bufnr)
        end,
        -- before_init = function(_, config)
        --   if lsp == "pyright" then
        --     config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
        --   end
        -- end,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    })
end

nvim_lsp.yamlls.setup({
    -- don't complain about key ordering in yaml
    settings = {yaml = {keyOrdering = false}}
})

local lsputil = require("lspconfig/util")
local venv = utils.exists("./.venv/") and "./.venv" or nil
local pylint_cfg = {
    enabled = false,
    args = {
        "-d", "missing-function-docstring", "-d", "invalid-name", "-d",
        "missing-module-docstring", "-d", "missing-class-docstring", "-d",
        "W1514", -- open without explicit encoding
        "-d", "too-few-public-methods", "-d", "line-too-long"
    }
}
if venv then
    if utils.exists("./.venv/bin/pylint") then
        pylint_cfg.executable = "./.venv/bin/pylint"
    end
end
local cmd_env = {}
if venv then
    cmd_env = {
        VIRTUAL_ENV = venv,
        PATH = lsputil.path.join(venv, "bin") .. ":" .. vim.env.PATH
    }
end

nvim_lsp.pylsp.setup({
    capabilities = capabilities,
    on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    cmd_env = cmd_env,
    enable = true,
    settings = {
        pylsp = {
            configurationSources = {},
            plugins = {
                jedi = {
                    extra_paths = {
                        "./dags", "./pkgs/py/", "./apps", "./proto/gen/pydantic"
                    },
                    environment = venv,
                    enabled = true
                },
                pydocstyle = {enabled = false},
                pylint = pylint_cfg,
                rope = {enabled = false},
                pyflakes = {enabled = false},
                pycodestyle = {enabled = false},
                yapf = {enabled = false},
                mccabe = {enabled = false},
                pylsp_black = {enabled = false},
                pylsp_isort = {enabled = false},
                pylsp_mypy = {enabled = false},
                pylsp_ruff = {enabled = false}
            }
        }
    }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        virtual_text = {spacing = 0, prefix = "■"},
        update_in_insert = false
    })
