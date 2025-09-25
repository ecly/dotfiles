-- easy installation of lsps and integration with nvim
vim.notify_once("Setting up mason")
local settings = require("core.settings")

local M = {
    "mason-org/mason.nvim",
    version = "*",
    cmd = "Mason",
    dependencies = {"mason-org/mason-lspconfig.nvim", "neovim/nvim-lspconfig"},
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = settings.mason_lspconfig_installer_ensure_installed
        })
    end
}

return M
