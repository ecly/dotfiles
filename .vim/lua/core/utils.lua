local M = {}

-- Utility section
M.map = function(mode, lhs, rhs, opts)
    -- https://oroques.dev/notes/neovim-init/
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.abbreviate_or_noop = function(input, output)
    -- https://stackoverflow.com/a/69951171
    local cmdtype = vim.fn.getcmdtype()
    local cmdline = vim.fn.getcmdline()

    if (cmdtype == ":" and cmdline == input) then
        return output
    else
        return input
    end
end

M.exists = function(file)
    -- https://stackoverflow.com/a/40195356/4000764
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end


return M
