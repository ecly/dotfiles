local utils = require("core.utils")
local venv = utils.exists("./.venv/") and "./.venv" or nil

-- debugging setup
local M = {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
}

return M
