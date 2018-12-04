" Enable syntax checking for elixir
let g:syntastic_enable_elixir_checker = 1
let g:syntastic_elixir_checkers = ['elixir']

" ,t to run tests in elixir
nmap <silent> <leader>t :Mix test<cr>
