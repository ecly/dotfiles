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

local settings = require("core.settings")
local servers = settings.mason_lspconfig_installer_ensure_installed

-- Only enable logging if necessary. It can cause slow performance when file grows too big.
-- https://github.com/LazyVim/LazyVim/discussions/326#discussioncomment-11454517
vim.lsp.set_log_level("off")

-- we disable the providers because mason takes care of it
-- mason takes care of the setup of the lsp.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- this needs to be called before setting up lsps
-- to ensure the right config is available.
require("mason").setup()
for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp, {
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

vim.lsp.config("yamlls", {
    -- don't complain about key ordering in yaml
    settings = {yaml = {keyOrdering = false}}
})

local lsputil = require("lspconfig/util")
local venv = utils.exists("./.venv/") and "./.venv" or nil
local cmd_env = {}
if venv then
    cmd_env = {
        VIRTUAL_ENV = venv,
        PATH = lsputil.path.join(venv, "bin") .. ":" .. vim.env.PATH
    }
end

vim.lsp.config("basedpyright", {
    capabilities = capabilities,
    on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    cmd_env = cmd_env,
    enable = false,
    settings = {
        venvPath = venv,
        -- Settings available here:
        -- https://docs.basedpyright.com/latest/configuration/language-server-settings/
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
                ignore = {"./proto/gen/pydantic", "pkgs/py/twain/models.py"},
                extraPaths = {
                    "./dags", "./pkgs/py/", "./apps", "./proto/gen/pydantic"
                }
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
