" If we're in diff mode, use shortcuts
if &diff
    map <leader>l :diffget LOCAL<CR>
    map <leader>b :diffget BASE<CR>
    map <leader>r :diffget REMOTE<CR>
endif
