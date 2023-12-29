-- bufferline matching the statusline
local M = {
	"willothy/nvim-cokeline",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	branch = "main",
	config = function()
		local get_hex = require("cokeline.hlgroups").get_hl_attr
		local mappings = require("cokeline/mappings")

		local comments_fg = get_hex("Comment", "fg")
		local errors_fg = get_hex("DiagnosticError", "fg")
		local warnings_fg = get_hex("DiagnosticWarn", "fg")

		local red = vim.g.terminal_color_1
		local green = vim.g.terminal_color_8
		local yellow = vim.g.terminal_color_3

		local components = {
			space = { text = " ", truncation = { priority = 1 } },

			two_spaces = { text = "  ", truncation = { priority = 1 } },

			separator = {
				text = function(buffer)
					return buffer.index ~= 1 and "▏" or ""
				end,
				truncation = { priority = 1 },
			},

			devicon = {
				text = function(buffer)
					return (mappings.is_picking_focus() or mappings.is_picking_close())
							and buffer.pick_letter .. " "
						or buffer.devicon.icon
				end,
				fg = function(buffer)
					return (mappings.is_picking_focus() and yellow)
						or (mappings.is_picking_close() and red)
						or buffer.devicon.color
				end,
				style = function(_)
					return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
				end,
				truncation = { priority = 1 },
			},

			index = {
				text = function(buffer)
					return buffer.index .. ": "
				end,
				truncation = { priority = 1 },
			},

			unique_prefix = {
				text = function(buffer)
					return buffer.unique_prefix
				end,
				fg = comments_fg,
				style = "italic",
				truncation = { priority = 3, direction = "left" },
			},

			filename = {
				text = function(buffer)
					return buffer.filename
				end,
				style = function(buffer)
					return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
						or (buffer.is_focused and "bold")
						or (buffer.diagnostics.errors ~= 0 and "underline")
						or nil
				end,
				truncation = { priority = 2, direction = "left" },
			},

			diagnostics = {
				text = function(buffer)
					return (buffer.diagnostics.errors ~= 0 and " E" .. buffer.diagnostics.errors)
						or (buffer.diagnostics.warnings ~= 0 and " W" .. buffer.diagnostics.warnings)
						or ""
				end,
				fg = function(buffer)
					return (buffer.diagnostics.errors ~= 0 and errors_fg)
						or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
						or nil
				end,
				truncation = { priority = 1 },
			},

			close_or_unsaved = {
				text = function(buffer)
					return buffer.is_modified and "●" or "x"
				end,
				fg = function(buffer)
					return buffer.is_modified and warnings_fg or nil
				end,
				delete_buffer_on_left_click = true,
				truncation = { priority = 1 },
			},
		}

		require("cokeline").setup({
			default_hl = {
				fg = function(buffer)
					return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
				end,
				bg = function(buffer)
					return buffer.is_focused and get_hex("Normal", "fg") or get_hex("ColorColumn", "bg")
				end,
			},
			components = {
				components.space,
				components.space,
				components.devicon,
				components.space,
				components.unique_prefix,
				components.filename,
				components.diagnostics,
				components.space,
				components.close_or_unsaved,
				components.space,
			},

			buffers = {
				filter_visible = function(buffer)
					return buffer.type ~= "terminal" and buffer.type ~= "quickfix" and buffer.filename ~= "[No Name]"
				end,
				filter_valid = function(buffer)
					return buffer.type ~= "terminal" and buffer.type ~= "quickfix" and buffer.filename ~= "[No Name]"
				end,
			},

			sidebar = {
				filetype = { "NvimTree", "neo-tree" },
				components = {
					{
						text = function(buf)
							return buf.filetype
						end,
						fg = yellow,
						bg = function()
							return get_hex("NvimTreeNormal", "bg")
						end,
						bold = true,
					},
				},
			},
		})
	end,
}
return M
