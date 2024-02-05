local M = {}

local colorTelescope = function()
	local colors = require("rose-pine.palette")
	local TelescopeColor = {
		TelescopeMatching = { fg = colors.gold },
		TelescopeSelection = { fg = colors.text, bg = colors.surface, bold = true },

		TelescopePromptPrefix = { bg = colors.surface },
		TelescopePromptNormal = { bg = colors.surface },
		TelescopeResultsNormal = { bg = colors.overlay },
		TelescopePreviewNormal = { bg = colors._nc },
		TelescopePromptBorder = { bg = colors.surface, fg = colors.surface },
		TelescopeResultsBorder = { bg = colors.overlay, fg = colors.overlay },
		TelescopePreviewBorder = { bg = colors._nc, fg = colors._nc },
		TelescopePromptTitle = { bg = colors.rose, fg = colors.overlay },
		TelescopeResultsTitle = { fg = colors.overlay },
		TelescopePreviewTitle = { bg = colors.rose, fg = colors.overlay },
	}

	for hl, col in pairs(TelescopeColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

M.options = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_ignore_patterns = { "node_modules" },
		path_display = { "truncate" },
		border = {},
		color_devicons = true,
	},
}

M.setup = function(opts)
	require("telescope").setup(opts)
	colorTelescope()
end

return M
