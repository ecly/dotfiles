scriptencoding utf-8

" As seen from statico with only small modifications:
" https://github.com/statico/dotfiles/blob/202e30b23e5216ffb6526cce66a0ef4fa7070456/.vim/vimrc#L406-L453

" Lightline
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [['mode', 'paste'], [ 'gitbranch', 'modified']],
    \   'right': [['lineinfo'], ['percent'], ['readonly', 'cocstatus', 'filetype']],
    \ },
    \ 'tabline': {
    \   'left': [[ 'separator' ],
    \             [ 'buffers' ],],
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
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \   'cocstatus': 'coc#status',
    \ },
    \ 'component': {
    \   'separator': '',
    \ },
    \ }

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call s:MaybeUpdateLightline()

" Lightline buffer:
set showtabline=2  " always show tabline

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '*'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 0

" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'

" hide buffer list
" let g:lightline_buffer_excludes = ['vimfiler']

" max file name length
let g:lightline_buffer_maxflen = 30

" max file extension length
let g:lightline_buffer_maxfextlen = 3

" min file name length
let g:lightline_buffer_minflen = 16

" min file extension length
let g:lightline_buffer_minfextlen = 3

" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20
