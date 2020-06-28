" https://github.com/fatih/vim-go-tutorial
augroup gocommands
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

nmap <leader>r <Plug>(go-run)
nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage-toggle)
nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

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

" this has to be set explicitly for deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
