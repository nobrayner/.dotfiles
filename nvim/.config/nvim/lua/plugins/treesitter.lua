return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
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
