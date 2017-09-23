" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType elixir setlocal omnifunc=elixircomplete#Complete
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
augroup end

" completions
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  " let g:deoplete#disable_auto_complete = 1
  let g:deoplete#enable_ignore_case = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif

" more natural completion selection
"inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <Esc> pumvisible() ? "\<c-e>" : "\<Esc>"
let g:SuperTabDefaultCompletionType = "<c-n>"
