scriptencoding utf-8

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Signs used by ale
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '∆'

" Remove background colors for Ale Signs
highlight clear ALEErrorSign
highlight clear ALEWarningSign
