local settings = require("core.settings")

if settings.theme == "catpuccin" then
  return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  }

elseif settings.theme == "tokyonight" then
  return {
    "folke/tokyonight.nvim",
    lazy = false,
    branch = "main",
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  }
else
  return {
      'ellisonleao/gruvbox.nvim',
      lazy = false,
      config = function()
        require("core.plugins.themes.gruvbox")
      end
  }
end
