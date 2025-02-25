-- plugin for adding unit test support
local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python", "nvim-neotest/neotest-go",
        -- Debug setup
        "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python"
    },
    event = "VeryLazy",
    config = function()
        -- TODO still not working perfectly and missing some keybinds
        local cwd = vim.fn.getcwd()
        local args = string.find(cwd, "twain") and
                         {"--integration", "--corrector-integration"} or {}

        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    python = ".venv/bin/python",
                    args = args,
                    dap = {justMyCode = false, console = "integratedTerminal"}
                })
            }
        })

        -- Example keybinds to add for DAP
        -- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
        -- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
        -- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
        -- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
        -- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
        -- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
        -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
        -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
        --

        require('dap-python').setup('.venv/bin/python')
        require('dap-python').test_runner = 'pytest'
    end
}

return M
