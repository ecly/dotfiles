local map = vim.keymap.set
local default_options = {silent = true, noremap = true}
local expr_options = {expr = true, silent = true}

-- Paste over currently selected text without yanking it
map("v", "p", '"_dp', default_options)
map("v", "P", '"_dP', default_options)

-- Resource VIMRC
map("n", "<leader>sv", ":luafile $MYVIMRC<CR>", default_options)

-- Remove search highlight
map("n", "<leader>/", ":nohlsearch<CR>", default_options)

-- Dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- Use :w!! to write with sudo even if not opened with
map("c", "w!!", "w !sudo tee >/dev/null %", default_options)

map("c", "BD",
    [[<cmd> lua require("cokeline.buffers").get_current().delete()<CR>]],
    default_options)

-- Clever replacement bindings courtesy of romainl
map("n", "<leader><leader>", [[ :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/ ]],
    default_options)
map("n", "<leader>%", [[ :%s/\<<C-r>=expand("<cword>")<CR>\>/ ]],
    default_options)

-- Address a few common mistakes I make when typing fast
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

local wk = require("which-key")

wk.add({
    {"sF", desc = "Find left surrounding"}, {"sa", desc = "Add surrounding"},
    {"sd", desc = "Delete surrounding"},
    {"sf", desc = "Replace right surrounding"},
    {"sh", desc = "Highlight surrounding"},
    {"sn", desc = "Surround update n lines"},
    {"sr", desc = "Replace surrounding"}
})

wk.add({
    {"f", group = "file"},
    {"ff", "<cmd>Telescope find_files<cr>", desc = "Find File"}
})

map("n", "<C-p>", [[<cmd> lua require('telescope.builtin').find_files()<CR>]],
    default_options)
map("n", "<C-n>", ":NvimTreeToggle<CR>", default_options)
map("n", "<leader>r", ":NvimTreeRefresh<CR>", default_options)
map("n", "<C-s>", ":MarkdownPreview<CR>", default_options)
map("n", "<leader><Tab>", "<Plug>VimwikiNextLink", default_options)
map("n", "<leader><S-Tab>", "<Plug>VimwikiPrevLink", default_options)

-- Extra vim-slime bindings to send buffer paths.
map("n", "<C-c>f", function()
    vim.cmd('SlimeSend11 ' .. vim.fn.shellescape(vim.fn.expand('%')))
end, {desc = "Slime send buffer relative path"})

map("n", "<C-c>F", function()
    vim.cmd('SlimeSend1 ' .. vim.fn.shellescape(vim.fn.expand('%:p')))
end, {desc = "Slime send buffer path to tmux target"})

wk.add({
    {"<leader>-", ":hsplit<CR>", desc = "Split horizontally"}, {
        "<leader>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        desc = "Type signature"
    }, {
        "<leader>S",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        desc = "Signature help"
    }, {"<leader>\\", ":vsplit<CR>", desc = "Split vertically"},
    {"<leader>b", group = "Buffers"}, {
        "<leader>bd",
        function()
            -- https://github.com/famiu/bufdelete.nvim/issues/54#issuecomment-2232964208
            local bd = require('bufdelete')
            local bufs = vim.api.nvim_list_bufs()
            local current_buf = vim.api.nvim_get_current_buf()
            for _, i in ipairs(bufs) do
                if i ~= current_buf then bd.bufdelete(i, true) end
            end
        end,
        desc = "Delete all buffers but this"
    }, {"<leader>bn", ":bnext<CR>", desc = "Go to next buffer"},
    {"<leader>bp", ":bprev<CR>", desc = "Go to previous buffer"},
    {"<leader>c", group = "Code"},
    {"<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Action"},
    {
        "<leader>cf",
        '<cmd>lua require"conform".format({lsp_fallback = true})<CR>',
        desc = "Format"
    }, {"<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename"},
    {"<leader>ct", "<cmd>StripWhitespace<CR>", desc = "Strip whitespace"},
    {"<leader>f", group = "Find"},
    {"<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffer"},
    {"<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file"},
    {"<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find git files"},
    {
        "<leader>fn",
        "<cmd>NvimTreeFindFile<CR>",
        desc = "Find current file in tree"
    }, {"<leader>fr", "<cmd>Telescope live_grep<CR>", desc = "Find live grep"},
    {"<leader>g", group = "Go to"}, {
        "<leader>gD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        desc = "Go to declaration"
    }, {"<leader>gb", ":Gitsigns blame_line<CR>", desc = "Blame line"}, {
        "<leader>gd",
        "<cmd>lua vim.lsp.buf.definition()<cr>",
        desc = "Go to definition"
    }, {
        "<leader>gi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        desc = "Go to implementation"
    }, {
        "<leader>gr",
        "<cmd>lua vim.lsp.buf.references()<CR>",
        desc = "Go to reference"
    }, {"<leader>gs", group = "Git stage"},
    {"<leader>gsb", ":Gitsigns stage_buffer<CR>", desc = "Stage buffer"},
    {"<leader>gsh", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk"},
    {"<leader>gsp", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk"},
    {"<leader>gsr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk"},
    {"<leader>gsu", ":Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk"},
    {"<leader>gt", ":Gitsigns diffthis<CR>", desc = "Diff this"},
    {"<leader>l", group = "LSP"}, {
        "<leader>lD",
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        desc = "List diagnostics in float"
    }, {
        "<leader>ld",
        "<cmd>lua vim.diagnostic.setloclist()<CR>",
        desc = "List diagnostics in loclist"
    }, {
        "<leader>lf",
        '<cmd>lua require"conform".format({lsp_fallback = true})<CR>',
        desc = "Format"
    }, {"<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename"},
    {"<leader>t", group = "Test"}, {
        "<leader>td",
        '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
        desc = "Debug nearest"
    }, {
        "<leader>tf",
        '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
        desc = "Run file"
    }, {
        "<leader>tn",
        '<cmd>lua require("neotest").run.run()<CR>',
        desc = "Run nearest"
    }, {
        "<leader>ts",
        '<cmd>lua require("neotest").run.run({suite=true})<CR>',
        desc = "Run suite"
    }, {"<leader>w", group = "Workspace"}, {
        "<leader>wa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        desc = "Add workspace"
    }, {
        "<leader>wl",
        "<cmd>lua vim.lsp.buf.(list_workspace_folders)<CR>",
        desc = "List workspaces"
    }, {
        "<leader>wr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        desc = "Remove workspace"
    }
})

wk.add({
    {"<S-Tab>", "<Plug>(cokeline-focus-prev)", desc = "Go to previous buffer"},
    {"<Tab>", "<Plug>(cokeline-focus-next)", desc = "Go to next buffer"},
    {"K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover documentation"}, {
        "[d",
        "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        desc = "Go to previous diagnostic"
    }, {
        "]d",
        "<cmd>lua vim.diagnostic.goto_next()<CR>",
        desc = "Go to next diagnostic"
    }, {"g", group = "Go to"},
    {"gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration"},
    {"gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition"},
    {
        "gi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        desc = "Go to implementation"
    }, {"gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to reference"}
})
