scriptencoding utf-8

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'


" Remove background colors for Ale Signs
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
