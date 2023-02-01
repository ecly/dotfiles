local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "glepnir/lspsaga.nvim",
    "onsails/lspkind-nvim",
    { "folke/neodev.nvim", config = true }
  },
  config = function()
    -- neodev needs to be setup before lspconfig
    require("neodev").setup({})
    require("core.plugins.lsp.lsp")
  end,
}

return M
