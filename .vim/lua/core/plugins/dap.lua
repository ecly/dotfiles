local utils = require("core.utils")
local venv = utils.exists("./.venv/") and "./.venv" or nil

-- debugging setup
local M = {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap-python", "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text"
        },
        -- reference: https://github.com/TheNoeTrevino/NoeVim/blob/main/lua/plugins/dap.lua
        keys = function()
          local dap = require("dap")
          return {
            -- stylua: ignore start
            { "<leader>d", group = "  Debug" },
            { "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition", },
            { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint", },
            { "<leader>dc", function() dap.continue() end, desc = "Continue", },
            { "<leader>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args", },
            { "<leader>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor", },
            { "<leader>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)", },
            { "<leader>di", function() dap.step_into() end, desc = "Step Into", },
            { "<leader>dk", function() dap.down() end, desc = "Down", },
            { "<leader>dl", function() dap.up() end, desc = "Up", },
            { "<leader>dl", function() dap.run_last() end, desc = "Run Last", },
            { "<leader>dO", function() dap.step_out() end, desc = "Step Out", },
            { "<leader>do", function() dap.step_over() end, desc = "Step Over", },
            { "<leader>dp", function() dap.pause() end, desc = "Pause", },
            { "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle REPL", },
            { "<leader>ds", function() dap.session() end, desc = "Session", },
            { "<leader>dt", function() dap.terminate() end, desc = "Terminate", },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets", },
            { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python", },
            { "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python", },
          }
        end,


    },
    {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = function()
      return {
        -- stylua: ignore start
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",   mode = { "n", "v" }, },
        {
          "<leader>df",
          function()
            require('dapui').float_element(nil, {
              height = math.floor(vim.o.lines / 2),
              width = math.floor(vim.o.columns / 2),
              position = 'center',
              enter = true
            })
          end,
          desc = "Float View"
        },
      }
    end,
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "repl",
              size = 0.15,
            },
            {
              id = "console",
              size = 0.15,
            },
            {
              id = "stacks",
              size = 0.35,
            },
            {
              id = "breakpoints",
              size = 0.35,
            },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            {
              id = "watches",
              size = 0.5,
            },
            {
              id = "scopes",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 12,
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        vim.notify("Debugging Session has Ended", vim.log.levels.INFO, { title = " " })
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    opts = { rocks = { rocks = false, hererocks = false } },
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
    },
    config = function()
      require("dap-python").setup(venv)
    end,
  },
}

return M
