"Needed for stack wrapper of ghc-mod
let $PATH = $PATH . ':' . expand('~/Scripts/bin')

" Haskell binds
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Fix to allow ghcmod-vim to use a stack installation of ghc-mod
let g:ghcmod_use_basedir='~/Scripts/bin'
