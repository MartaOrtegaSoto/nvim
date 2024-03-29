local base_plugins = {
	"nvim-lua/plenary.nvim",
	-- Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		config = function(_, opts)
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = function()
			return require("plugins.configs.gitsigns")
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function()
			return require("plugins.configs.lsp").mason_opts
		end,
		config = function(_, opts)
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = opts.ensure_installed,
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("plugins.configs.lsp").lsp_config()
		end,
	},
	-- Java LSP
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		--	opts = function()
		--		return require("plugins.configs.lsp").jdtls_opts
		--	end,
		--	config = function(_, opts)
		--		local config = opts or {}

		--		config.capabilities = require("cmp_nvim_lsp").default_capabilities()

		--		local function attach_jdtls()
		--			-- Existing server will be reused if the root_dir matches.
		--			require("jdtls").start_or_attach(config)
		--			-- not need to require("jdtls.setup").add_commands(), start automatically adds commands
		--		end
		--		-- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
		--		-- depending on filetype, so this autocmd doesn't run for the first file.
		--		-- For that, we call directly below.
		--		vim.api.nvim_create_autocmd("FileType", {
		--			pattern = { "java" },
		--			callback = attach_jdtls,
		--		})
		--		-- Avoid race condition by calling attach the first time, since the autocmd won't fire.
		--		-- attach_jdtls()
		--	end,
	},
	-- Cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip", -- snippet engine
			"rafamadriz/friendly-snippets",
			-- Cmp sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			return require("plugins.configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("plugins.configs.conform")
		end,
		config = function(_, opts)
			require("conform").setup(opts)
			require("core.utils").load_mapping("conform", {})
		end,
	},
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		init = function()
			require("core.utils").load_mapping("nvimtree", {})
			require("plugins.configs.nvimtree").init()
		end,
		opts = function()
			return require("plugins.configs.nvimtree").options
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = "Telescope",
		init = function()
			require("core.utils").load_mapping("telescope", {})
		end,
		opts = function()
			return require("plugins.configs.telescope").options
		end,
		config = function(_, opts)
			require("plugins.configs.telescope").setup(opts)
		end,
	},
	-- Lualine
	{
		"feline-nvim/feline.nvim",
		lazy = false,
		branch = "0.5-compat",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugins.configs.feline")
		end,
	},
}

local lazy_config = require("core.base_config").lazy_nvim

require("lazy").setup(base_plugins, lazy_config)
