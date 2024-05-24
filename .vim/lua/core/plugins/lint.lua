local utils = require("core.utils")

local M = {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff", "mypy" },
		}

		require("lint").linters.pylint.args = {
			"-d",
			"missing-function-docstring",
			"-d",
			"invalid-name",
			"-d",
			"missing-module-docstring",
			"-d",
			"missing-class-docstring",
			"-d",
			"W1514", -- open without explicit encoding
			"-d",
			"too-few-public-methods",
			"-d",
			"line-too-long",
		}

		local mypy = require("lint").linters.mypy
		mypy.args = vim.list_extend(mypy.args, {
			"--ignore-missing-imports",
			"--disable-error-code",
			"import-untyped",
		})

		local venv = utils.exists("./.venv/") and "./.venv" or nil
		if venv then
			if utils.exists("./.venv/bin/mypy") then
				-- vim.notify_once("Running `mypy` in .venv")
				mypy.cmd = ".venv/bin/python"
				mypy.args = vim.list_extend({ "-m", "mypy" }, mypy.args)
			else
				-- vim.notify_once("Running `mypy` without .venv")
			end

			if utils.exists("./.venv/bin/ruff") then
				-- vim.notify_once("Running `ruff` in .venv")
				local ruff = require("lint").linters.ruff
				ruff.cmd = ".venv/bin/python"
				ruff.args = vim.list_extend({ "-m", "ruff" }, ruff.args)
			else
				-- vim.notify_once("Running `ruff` without .venv")
			end
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}

return M
