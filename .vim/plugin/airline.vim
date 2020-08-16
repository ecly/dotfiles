scriptencoding utf-8

" References:
" https://github.com/statico/dotfiles/blob/202e30b23e5216ffb6526cce66a0ef4fa7070456/.vim/vimrc#L406-L453
" https://github.com/neoclide/coc.nvim/issues/401

" Set warning/error icons for coc_status
let g:coc_status_error_sign = '✗'
let g:coc_status_warning_sign = '•'

" Always show tabline
set showtabline=2
" Ensure that lightline-bufferline works with devicons
let g:lightline#bufferline#enable_devicons = 1

" Lightline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['gitbranch', 'modified']],
    \   'right': [['lineinfo'], ['percent'], ['cocstatus', 'readonly', 'filetype']],
    \ },
    \ 'tabline': {
    \   'left': [['buffers']],
    \   'right': [],
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \ },
    \ 'component_type': {
    \   'readonly': 'error',
    \   'buffers': 'tabsel',
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'cocstatus': 'coc#status',
    \ },
    \ }

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call s:MaybeUpdateLightline()

