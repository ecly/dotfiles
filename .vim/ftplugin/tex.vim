" Don't do any clever folding
"let g:Tex_FoldedSections=''
"let g:Tex_FoldedEnvironments=''
"let g:Tex_FoldedMisc=''

" Don't conceal symbols
" let g:tex_conceal = ""

" Use zathura for previewing latex
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'latexmk -pdf'
let g:tex_conceal = ''
"
" .tex files are always filetype latex
let g:tex_flavor = 'latex'

" avoid conflict between vimtex and polygot
let g:polyglot_disabled = ['latex']

" Vimtex neovim compatability
" requires pip3 install neovim-remote
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" don't open the quickfix window for warnings
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_autoclose_after_keystrokes=2
let g:vimtex_quickfix_mode=2  " open on errors without focus
