" Haskell binds
map <silent> <leader>tw :GhcModTypeInsert<CR>
map <silent> <leader>ts :GhcModSplitFunCase<CR>
map <silent> <leader>tq :GhcModType<CR>
map <silent> <leader>te :GhcModTypeClear<CR>

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
