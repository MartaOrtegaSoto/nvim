local M = {}

M.options = {
	filters = {
		dotfiles = false,
		exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
	},
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = false,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		side = "left",
		width = 40,
		preserve_window_proportions = false,
	},
	git = {
		enable = false,
		ignore = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	renderer = {
		highlight_git = false,
		highlight_opened_files = "none",
		group_empty = true,

		indent_markers = {
			enable = false,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},

			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}

M.init = function()
	vim.api.nvim_create_autocmd({ "VimEnter", "BufReadPost" }, {
		callback = function(data)
			-- buffer is a directory
			local directory = vim.fn.isdirectory(data.file) == 1

			if not directory then
				return
			end

			require("nvim-tree.api").tree.toggle({ focus = true, find_file = false })
		end,
	})
end

return M
