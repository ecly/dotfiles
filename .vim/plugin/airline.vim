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
    \   'right': [['lineinfo'], ['percent'], ['coc_error', 'coc_warning', 'coc_info', 'coc_hint', 'coc_fix', 'readonly', 'filetype']],
    \ },
    \ 'tabline': {
    \   'left': [['buffers']],
    \   'right': [],
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers',
    \   'coc_error'        : 'LightlineCocErrors',
    \   'coc_warning'      : 'LightlineCocWarnings',
    \   'coc_info'         : 'LightlineCocInfos',
    \   'coc_hint'         : 'LightlineCocHints',
    \   'coc_fix'          : 'LightlineCocFixes',
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

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf('%s %d', a:sign, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', '✗')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', '')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', '')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', '')
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call s:MaybeUpdateLightline()
