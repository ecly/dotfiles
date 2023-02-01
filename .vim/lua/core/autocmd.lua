-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Make <C-x><C-o> trigger LSP auto-completion
vim.cmd [[
  augroup Omnifunc
    autocmd!
    autocmd Filetype * setlocal omnifunc=v:lua.vim.lsp.omnifunc
  augroup end
]]
