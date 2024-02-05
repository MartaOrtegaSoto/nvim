local M = {}

M.base = {
	v = {
		["<"] = { "<gv", "Indent line" },
		[">"] = { ">gv", "Indent line" },
	},
}

M.gitsigns = {
	n = {
		["<leader>gb"] = {
			function()
				package.loaded.gitsigns.blame_line()
			end,
			"Blame line",
		},
		["<leader>gd"] = {
			function()
				package.loaded.gitsigns.diffthis("~")
			end,
			"Blame line",
		},
	},
}

M.nvimtree = {
	n = {
		-- toggle
		["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

		-- focus
		["<leader>b"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
	},
}

M.conform = {
	n = {
		["<leader>F"] = {
			function()
				require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
			end,
			"LSP Format buffer",
		},
	},
}

M.telescope = {
	n = {
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find Files" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find Buffers" },
		["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "Live Grep" },
		["<leader>fw"] = { "<cmd> Telescope grep_string <CR>", "Grep str under cursor" },
		["<leader>fm"] = { "<cmd> Telescope marks <CR>", "Find Marks" },
		["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
		["<leader>fds"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find in current buffer" },

		["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
		["<leader>gl"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
	},
}

M.lspconfig = {
	n = {
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"LSP declaration",
		},
		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},
		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},
		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"LSP hover",
		},
		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"LSP implementation",
		},
		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},
		["<leader>rn"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP rename",
		},
		["[d"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"Prev diagnostic",
		},
		["]d"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"Next diagnostic",
		},
	},
}

return M
