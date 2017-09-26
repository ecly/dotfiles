scriptencoding utf-8
" Settings for airline
" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable symbols if defined
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" No separators for empty sections
let g:airline_skip_empty_sections = 1

" straight separation
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '|'

" Customized right side sections
let g:airline_section_y = ''
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create(['%P'])
