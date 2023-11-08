-- plugin for adding unit test support
local M = {
    "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim", "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-plenary", -- Debug setup
            "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python"
        },
        config = function()
            -- TODO still not working perfectly and missing some keybinds
            require('dap-python').setup('.venv/bin/python')
            require('dap-python').test_runner = 'pytest'
            require("neotest").setup({
                output = {enabled = true},
                adapters = {
                    require("neotest-go"),
                    require("neotest-python")({
                        args = {"--integration", "--integration-skip-ready"},
                        dap = {
                            justMyCode = false,
                            console = "integratedTerminal"
                        },
                        runner = "pytest"
                    }), require("neotest-plenary")
                }
            })
        end
    }

return M
