return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			sync_install = false,
			auto_install = false,
			ignore_install = {},
			modules = {},
			ensure_installed = {
				"typescript",
				"javascript",
				"rust",
				"lua",
				"html",
				"css",
				"scss",
				"prisma",
				"yaml",
				"toml",
				"tsx",
				"markdown",
				"json",
				"graphql",
				"dockerfile",
				"astro",
				"bash",
				"vim",
				"gitignore",
				"vimdoc",
			},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				-- keymaps = {
				-- 	init_selection = "<C-Space>",
				-- 	node_incremental = "<C-Space>",
				-- 	scope_incremental = false,
				-- 	node_decremental = "<bs>",
				-- },
			},
		})
	end,
}
