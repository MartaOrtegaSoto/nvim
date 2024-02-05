local theme = {
	aqua = "#BEDBBB",
	bg = "#1C212A",
	blue = "#316B83",
	cyan = "#70C0BA",
	darkred = "#FB7373",
	fg = "#C7C7CA",
	gray = "#222730",
	green = "#99BC85",
	lime = "#54CED6",
	orange = "#FFD064",
	pink = "#D997C8",
	purple = "#C397D8",
	reda = "#FF8080",
	redas = "#FF8080",
	yellow = "#EFD595",
}

local mode_theme = {
	["NORMAL"] = theme.green,
	["OP"] = theme.cyan,
	["INSERT"] = theme.aqua,
	["VISUAL"] = theme.yellow,
	["LINES"] = theme.darkred,
	["BLOCK"] = theme.orange,
	["REPLACE"] = theme.purple,
	["V-REPLACE"] = theme.pink,
	["ENTER"] = theme.pink,
	["MORE"] = theme.pink,
	["SELECT"] = theme.darkred,
	["SHELL"] = theme.cyan,
	["TERM"] = theme.lime,
	["NONE"] = theme.gray,
	["COMMAND"] = theme.blue,
}

local modes = setmetatable({
	["n"] = "N",
	["no"] = "N",
	["v"] = "V",
	["V"] = "VL",
	[""] = "VB",
	["s"] = "S",
	["S"] = "SL",
	[""] = "SB",
	["i"] = "I",
	["ic"] = "I",
	["R"] = "R",
	["Rv"] = "VR",
	["c"] = "C",
	["cv"] = "EX",
	["ce"] = "X",
	["r"] = "P",
	["rm"] = "M",
	["r?"] = "C",
	["!"] = "SH",
	["t"] = "T",
}, {
	__index = function()
		return "-"
	end,
})

local get_diag = function(str)
	local count = vim.lsp.diagnostic.get_count(0, str)
	if count == 0 then
		return ""
	end
	return " " .. count .. " "
end

local components = {}

components.vim_mode = {
	provider = function()
		return modes[vim.api.nvim_get_mode().mode]
	end,
	hl = function()
		return {
			fg = "bg",
			bg = require("feline.providers.vi_mode").get_mode_color(),
			style = "bold",
			name = "NeovimModeHLColor",
		}
	end,
	left_sep = "block",
	right_sep = "block",
}

local sep_icons = {
	default = { left = "", right = "" },
	round = { left = "", right = "" },
	block = { left = "█", right = "█" },
	arrow = { left = "", right = "" },
}

components.mode = {
	provider = function()
		return modes[vim.api.nvim_get_mode().mode]
	end,
	hl = function()
		return { fg = "bg", bg = require("feline.providers.vi_mode").get_mode_color(), style = "bold" }
	end,
	left_sep = sep_icons.block.left,
	right_sep = sep_icons.block.right,
	icon = " ",
}
components.file_info = {
	provider = "file_info",
	-- icon = " 󰈚 ",
	left_sep = sep_icons.round.right,
}
components.git_branch = {
	provider = "git_branch",
	icon = "  ",
}
components.git_added = {
	provider = "git_diff_added",
	hl = {
		fg = theme.green,
	},
	icon = "  ",
}
components.git_removed = {
	provider = "git_diff_removed",
	hl = {
		fg = theme.red,
	},
	icon = "  ",
}
components.git_changed = {
	provider = "git_diff_changed",
	hl = {
		fg = theme.yellow,
	},
	icon = "  ",
}
components.lsp_errors = {
	provider = "diagnostic_errors",
	hl = {
		fg = theme.red,
	},
	icon = "  ",
}
components.lsp_warns = {
	provider = "diagnostic_warnings",
	hl = {
		fg = theme.yellow,
	},
	icon = "  ",
}
components.lsp_hints = {
	provider = "diagnostic_hints",
	hl = {
		fg = theme.lime,
	},
	icon = "  ",
}
components.lsp_infos = {
	provider = "diagnostic_hints",
	hl = {
		fg = theme.aqua,
	},
	icon = "  ",
}
components.lsp_stat = {
	provider = "lsp_client_names",
	icon = { str = "  ", hl = { fg = theme.blue } },
}
components.cwd = {
	provider = function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end,
	left_sep = "block",
	icon = { str = "  ", hl = { fg = theme.pink } },
}
components.progress = {
	provider = "line_percentage",
	left_sep = "block",
	icon = { str = "  ", hl = { fg = theme.green, style = "bold" } },
}

local options = {
	components = {
		active = {
			-- Left
			{
				components.mode,
				components.file_info,
				components.git_branch,
				components.git_added,
				components.git_changed,
				components.git_removed,
			},
			-- Middle
			{},
			-- Right
			{
				components.lsp_errors,
				components.lsp_warns,
				components.lsp_hints,
				components.lsp_infos,
				components.lsp_stat,
				components.cwd,
				components.progress,
			},
		},
	},
	theme = theme,
	vi_mode_colors = mode_theme,
}

require("feline").setup(options)
