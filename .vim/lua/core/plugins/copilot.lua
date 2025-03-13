M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    enabled = false,
    opts = {
        suggestion = {
            auto_trigger = false,
            debounce = 500,
            keymap = {
                accept = "<M-space>",
                accept_line = "<M-l>",
                accept_word = "<M-w>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<M-c>"
            }
        }
    }
}
return M
