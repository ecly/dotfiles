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
    "lua_ls", "ty",  "terraformls", "gopls", "protols", "yamlls"
}

-- Use the background of the terminal
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

return M
