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

wk.register({
    sa = "Add surrounding",
    sd = "Delete surrounding",
    sh = "Highlight surrounding",
    sn = "Surround update n lines",
    sr = "Replace surrounding",
    sF = "Find left surrounding",
    sf = "Replace right surrounding"
})

wk.register({
    f = {
        name = "file", -- optional group name
        f = {"<cmd>Telescope find_files<cr>", "Find File"} -- create a binding with label
    }
}, {prefix = ""})

map("n", "<C-p>", [[<cmd> lua require('telescope.builtin').find_files()<CR>]],
    default_options)
map("n", "<C-n>", ":NvimTreeToggle<CR>", default_options)
map("n", "<leader>r", ":NvimTreeRefresh<CR>", default_options)
map("n", "<C-s>", ":MarkdownPreview<CR>", default_options)
map("n", "<leader><Tab>", "<Plug>VimwikiNextLink", default_options)
map("n", "<leader><S-Tab>", "<Plug>VimwikiPrevLink", default_options)

wk.register({
    f = {
        name = "Find",
        f = {"<cmd>Telescope find_files<CR>", "Find file"},
        g = {"<cmd>Telescope git_files<CR>", "Find git files"},
        b = {"<cmd>Telescope buffers<CR>", "Find buffer"},
        r = {"<cmd>Telescope live_grep<CR>", "Find live grep"},
        n = {"<cmd>NvimTreeFindFile<CR>", "Find current file in tree"}
    },
    t = {
        name = "Test",
        n = {'<cmd>lua require("neotest").run.run()<CR>', "Run nearest"},
        d = {
            '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
            "Debug nearest"
        },
        f = {
            '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
            "Run file"
        },
        s = {
            '<cmd>lua require("neotest").run.run({suite=true})<CR>', "Run suite"
        }
    },
    S = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help"},
    w = {
        name = "Workspace",
        a = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace"},
        r = {
            "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
            "Remove workspace"
        },
        l = {
            "<cmd>lua vim.lsp.buf.(list_workspace_folders)<CR>",
            "List workspaces"
        }
    },
    D = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type signature"},
    r = {n = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"}},
    g = {
        name = "Go to",
        r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Go to reference"},
        d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition"},
        D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration"},
        i = {
            "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation"
        },
        s = {
            name = "Git stage",
            h = {":Gitsigns stage_hunk<CR>", "Stage hunk"},
            r = {":Gitsigns reset_hunk<CR>", "Reset hunk"},
            b = {":Gitsigns stage_buffer<CR>", "Stage buffer"},
            p = {":Gitsigns preview_hunk<CR>", "Preview hunk"},
            u = {":Gitsigns undo_stage_hunk<CR>", "Undo stage hunk"}
        },
        b = {":Gitsigns blame_line<CR>", "Blame line"},
        t = {":Gitsigns diffthis<CR>", "Diff this"}
    },
    c = {
        name = "Code",
        a = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "Action"},
        -- f = {'<cmd>lua vim.lsp.buf.format({async = true})<CR>', "Format"},
        f = {
            '<cmd>lua require"conform".format({lsp_fallback = true})<CR>',
            "Format"
        },
        r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
        t = {"<cmd>StripWhitespace<CR>", "Strip whitespace"}
    },
    l = {
        name = "LSP",
        -- f = {'<cmd>lua vim.lsp.buf.format({async = true})<CR>', "Format"},
        f = {
            '<cmd>lua require"conform".format({lsp_fallback = true})<CR>',
            "Format"
        },
        d = {
            "<cmd>lua vim.diagnostic.setloclist()<CR>",
            "List diagnostics in loclist"
        },
        D = {
            "<cmd>lua vim.diagnostic.open_float()<CR>",
            "List diagnostics in float"
        }
    },
    b = {
        name = "Buffers",
        n = {":bnext<CR>", "Go to next buffer"},
        p = {":bprev<CR>", "Go to previous buffer"},
        d = {
            function()
                -- https://github.com/famiu/bufdelete.nvim/issues/54#issuecomment-2232964208
                local bd = require('bufdelete')
                local bufs = vim.api.nvim_list_bufs()
                local current_buf = vim.api.nvim_get_current_buf()
                for _, i in ipairs(bufs) do
                    if i ~= current_buf then
                        bd.bufdelete(i, true)
                    end
                end
            end, "Delete all buffers but this"
        }
    },
    ["\\"] = {":vsplit<CR>", "Split vertically"},
    ["-"] = {":hsplit<CR>", "Split horizontally"}
}, {prefix = "<leader>"})

wk.register({
    g = {
        name = "Go to",
        r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Go to reference"},
        d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition"},
        D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration"},
        i = {
            "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation"
        }
    },
    K = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover documentation"},
    ["]d"] = {
        "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic"
    },
    ["[d"] = {
        "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic"
    },
    ["<Tab>"] = {"<Plug>(cokeline-focus-next)", "Go to next buffer"},
    ["<S-Tab>"] = {"<Plug>(cokeline-focus-prev)", "Go to previous buffer"}
})
