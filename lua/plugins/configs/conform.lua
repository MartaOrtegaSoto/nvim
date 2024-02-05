return {
	formatters_by_ft = {
		lua = { "stylua" },
		java = { "google-java-format" },
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		graphql = { { "prettierd", "prettier" } },
		markdown = { { "prettierd", "prettier" } },
		html = { "htmlbeautifier" },
		bash = { "beautysh" },
		yaml = { "yamlfix" },
		css = { { "prettierd", "prettier" } },
		scss = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
}
