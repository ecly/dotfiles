" https://github.com/fatih/vim-go-tutorial
augroup gocommands
    autocmd!
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    " Build for files and tests
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

    " Ideal settings for spaces/tabs with go
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
augroup END

" Auto import
let g:go_fmt_command = 'goimports'

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


" Linting
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
