-- Use system clipboard
vim.cmd [[set clipboard+=unnamedplus]]
-- Disable netrw as we use NvimTree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Enable mouse mode
vim.o.mouse = "a"
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Set completevim.o to have a better completion experience
vim.o.completeopt = 'menuone,noselect,preview'
-- Lightline shows this already
vim.o.showmode = false
-- Show last status
vim.o.laststatus = 3
-- Show command at all time until flicker is fixed with neovim 0.8
vim.o.cmdheight = 1
-- Indentation configuration
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
-- Relative line numbers but absolute for current line
vim.o.relativenumber = true
vim.wo.number = true
-- Hide buffers instead of closing them
vim.o.hidden = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Don't beep
vim.o.visualbell = true -- Don't beep
vim.o.errorbells = false -- Don't beep
-- Don't backup
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- Show matching braces when over one
vim.o.showmatch = true
vim.o.backspace = 'indent,eol,start' -- Allow backspacing everything in insert
vim.o.hlsearch = true -- Highlight searches
vim.o.incsearch = true -- Search as typing
vim.o.concealcursor = nil -- Never conceal anything on current line
-- Persistent undo handling
vim.o.undodir = vim.fn.expand('$HOME/.cache/nvim/undodir')
vim.o.undofile = true
vim.o.lazyredraw = true -- Speedup large files and macros
vim.o.updatetime = 100 -- Default 4000 is a bit high for async updates
-- Intuitive default split directions
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showtabline = 2 -- Always show tabline
vim.o.shortmess = vim.o.shortmess .. 'c' -- Don't give ins-completion-menu messages
vim.o.signcolumn = 'yes' -- Always show signcolumn

-- Use virtual text for diagnostics
vim.diagnostic.config({ virtual_text = true })

-- Set colorscheme and true colors
vim.o.termguicolors = true
vim.cmd [[filetype plugin on]]
vim.opt.background = "dark"

-- Don't auto break my lines
vim.cmd [[
    set formatoptions=cqronlj
]]

-- Use wsl32yank if in WSL context
vim.cmd [[
    let uname = substitute(system('uname'),'\n','','')
    if uname == 'Linux'
        let lines = readfile("/proc/version")
        if lines[0] =~ "Microsoft"
          let g:clipboard = {
                \   'name': 'win32yank-wsl',
                \   'copy': {
                \      '+': 'win32yank.exe -i --crlf',
                \      '*': 'win32yank.exe -i --crlf',
                \    },
                \   'paste': {
                \      '+': 'win32yank.exe -o --lf',
                \      '*': 'win32yank.exe -o --lf',
                \   },
                \   'cache_enabled': 0,
                \ }
        endif
    endif
]]
