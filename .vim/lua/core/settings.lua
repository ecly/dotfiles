local M = {}

M.theme = "gruvbox"

M.treesitter_ensure_installed = {
    "bash", "c", "c_sharp", "comment", "cpp", "cpp", "css", "dockerfile",
    "elixir", "go", "haskell", "hcl", "html", "java", "javascript", "json",
    "latex", "lua", "markdown", "markdown_inline", "query", "python", "proto",
    "regex", "ruby", "rust", "toml", "typescript", "vim", "yaml", "terraform"
}
M.mason_lspconfig_installer_ensure_installed = {
    -- LSP
    "bashls", "dockerls", "elixirls", "jsonls", "marksman", "vtsls", "texlab",
    "lua_ls", "basedpyright", "terraformls", "gopls", "protols", "yamlls",
    "vint"
}

return M
