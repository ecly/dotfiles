-- easy installation of lsps and integration with nvim
local settings = require("core.settings")

local M = {
    "mason-org/mason.nvim",
    version = "*",
    event = "VeryLazy",
    cmd = "Mason",
    dependencies = {{"mason-org/mason-lspconfig.nvim"}},
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = settings.mason_lspconfig_installer_ensure_installed
        })
    end
}

return M
