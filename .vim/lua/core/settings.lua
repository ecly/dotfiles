local M = {}

M.theme = "gruvbox"

M.treesitter_ensure_installed = {
	"bash",
	"c",
	"c_sharp",
	"comment",
	"cpp",
	"cpp",
	"css",
	"dockerfile",
	"elixir",
	"go",
	"haskell",
	"hcl",
	"html",
	"java",
	"javascript",
	"json",
	"latex",
	"lua",
	"markdown",
	"markdown_inline",
	"query",
	"python",
	"proto",
	"regex",
	"ruby",
	"rust",
	"toml",
	"typescript",
	"vim",
	"yaml",
	"terraform",
}

M.mason_tool_installer_ensure_installed = {
	-- LSP
	"bash-language-server",
	"dockerfile-language-server",
	"elixir-ls",
	"json-lsp",
	"marksman",
	"typescript-language-server",
	"texlab",
	"lua-language-server",
	"python-lsp-server",
	"terraform-ls",
	"gopls",
	"buf-language-server",
	"yaml-language-server", -- Formatter
	"black",
	"stylua",
	"luaformatter",
	"prettier",
	"shfmt",
	"isort",
	"pylint",
	"ruff", -- Linter
	"pydocstyle",
	"eslint_d",
	"shellcheck",
	"tflint",
	"yamllint",
	"mypy", -- DAP
	"debugpy",
}

return M
