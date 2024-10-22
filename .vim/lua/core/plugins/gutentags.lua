-- better tag support
local M = {
    'ludovicchabant/vim-gutentags',
    lazy = true,
    config = function()
        -- https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
        vim.g.gutentags_ctags_exclude = {
            '*.git', '*.svg', '*.hg', '*/tests/*', 'build', 'dist',
            '*sites/*/files/*', 'bin', 'node_modules', 'bower_components',
            'cache', 'compiled', 'docs', 'example', 'bundle', 'vendor', '*.md',
            '*-lock.json', '*.lock', '*bundle*.js', '*build*.js', '.*rc*',
            '*.json', '*.min.*', '*.map', '*.bak', '*.zip', '*.pyc', '*.class',
            '*.sln', '*.Master', '*.csproj', '*.tmp', '*.csproj.user',
            '*.cache', '*.pdb', 'tags*', 'cscope.*', '.venv', '*.exe', '*.dll',
            '*.mp3', '*.ogg', '*.flac', '*.swp', '*.swo', '*.bmp', '*.gif',
            '*.ico', '*.jpg', '*.png', '*.rar', '*.zip', '*.tar', '*.tar.gz',
            '*.tar.xz', '*.tar.bz2', '*.pdf', '*.doc', '*.docx', '*.ppt',
            '*.pptx'
        }

        local utils = require("core.utils")
        local homebrew_exe_path = "/opt/homebrew/bin/ctags"
        if utils.exists(homebrew_exe_path) then
            vim.g.gutentags_ctags_executable = homebrew_exe_path
        end

        vim.g.gutentags_add_default_project_roots = false
        vim.g.gutentags_project_root = {
            'package.json', '.git', 'poetry.lock', 'pyproject.toml'
        }
        vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/nvim/ctags/')
        vim.g.gutentags_generate_on_new = true
        vim.g.gutentags_generate_on_missing = true
        vim.g.gutentags_generate_on_write = true
        vim.g.gutentags_generate_on_empty_buffer = true
        vim.cmd(
            [[command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')]])
        vim.g.gutentags_ctags_extra_args = {
            '--tag-relative=yes', '--fields=+ailmnS'
        }
    end
}

return M
