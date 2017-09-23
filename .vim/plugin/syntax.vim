scriptencoding utf-8
" syntactic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_vim_checkers = ['vint']

let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '<>'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'

let g:neomake_warning_sign = {
 \   'text': '∆',
 \   'texthl': 'NeomakeWarningSign',
 \ }
let g:neomake_error_sign = {
 \   'text': '✗',
 \   'texthl': 'NeomakeErrorSign',
 \ }
let g:neomake_message_sign = {
  \   'text': '≈',
  \   'texthl': 'NeomakeMessageSign',
  \ }
let g:neomake_info_sign = {'text': '≈', 'texthl': 'NeomakeInfoSign'}
