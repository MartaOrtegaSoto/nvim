return {
	formatters_by_ft = {
		lua = { "stylua" },
		java = { "google-java-format" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
}
