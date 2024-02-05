return {
	on_attach = function(bufnr)
		require("core.utils").load_mapping("gitsigns", { buffer = bufnr })
	end,
}
