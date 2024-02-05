local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local home = os.getenv("HOME")
local workspace_path = home .. "/.cache/jdtls/workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local os_config = nil

if vim.loop.os_uname().sysname == "Darwin" then
	os_config = "mac"
elseif vim.loop.os_uname().sysname == "Linux" then
	os_config = "linux"
else
	os_config = "win"
end

local config = {
	cmd = {
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
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	init_options = {
		bundles = {},
	},
}

require("jdtls").start_or_attach(config)
