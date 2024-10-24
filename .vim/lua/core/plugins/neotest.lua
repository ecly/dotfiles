-- plugin for adding unit test support
local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim", "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go", 'nvim-neotest/nvim-nio',
        "nvim-neotest/neotest-plenary", -- Debug setup
        "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python"
    },
    event = "VeryLazy",
    config = function()
        -- TODO still not working perfectly and missing some keybinds
        local cwd = vim.fn.getcwd()
        local args = string.find(cwd, "twain") and
                         {"--integration", "--corrector-integration"} or {}
        require('dap-python').setup('.venv/bin/python')
        require('dap-python').test_runner = 'pytest'
        require("neotest").setup({
            output = {enabled = true},
            adapters = {
                require("neotest-go"), require("neotest-python")({
                    python = ".venv/bin/python",
                    args = args,
                    dap = {justMyCode = false, console = "integratedTerminal"},
                    runner = "pytest"
                }), require("neotest-plenary")
            }
        })
    end
}

return M
