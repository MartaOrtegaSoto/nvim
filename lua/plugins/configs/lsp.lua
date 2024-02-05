local M = {}

local servers = {
	"lua_ls",
	"jdtls",
	"tsserver",
	"pyright",
	"bashls",
	"cssls",
	"lemminx",
	"yamlls",
	"marksman",
}

M.mason_opts = {
	ensured_installed = servers,
}

M.lsp_config = function()
	local lspconfig = require("lspconfig")
	local mappings = require("core.mappings")

	local on_attach = function(client, bufnr)
		require("core.utils").load_mapping("lspconfig", { buffer = bufnr })
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- General language setup
	for _, server in ipairs(servers) do
		if server ~= "jdtls" then
			lspconfig[server].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
	end

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
end

local function get_jdtls_cmd()
	local home = os.getenv("HOME")
	local workspace_path = home .. "/.local/share/nvimlazy/jdtls-workspace/"
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = workspace_path .. project_name

	local os_config = "config"
	return {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		home
			.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar",
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
		"-data",
		workspace_dir,
	}
end

M.jdtls_opts = {
	-- root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,
	cmd = get_jdtls_cmd(),
	init_options = {
		bundles = {},
	},
}

M.jdtls_setup = function()
	local config = M.jdtls_opts or {}
	config.capabilities = require("cmp_nvim_lsp").default_capabilities()

	local function attach_jdtls()
		-- Existing server will be reused if the root_dir matches.
		require("jdtls").start_or_attach(config)
		-- not need to require("jdtls.setup").add_commands(), start automatically adds commands
	end
	-- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
	-- depending on filetype, so this autocmd doesn't run for the first file.
	-- For that, we call directly below.
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "java" },
		callback = attach_jdtls,
	})
	-- Avoid race condition by calling attach the first time, since the autocmd won't fire.
	attach_jdtls()
end

-- "--jvm-arg=-javaagent:/Users/martaortegasoto/.local/share/nvim/mason/packages/jdtls/lombok.jar",
return M
