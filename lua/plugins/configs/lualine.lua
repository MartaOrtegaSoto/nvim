return {
	options = {
		icons_enabled = true,
		theme = "seoul256",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = { "branch", "diff" },
		lualine_x = { "diagnostics" },
		lualine_y = { "filetype" },
		lualine_z = { "progress", "searchcount", "selectioncount" },
	},
}
