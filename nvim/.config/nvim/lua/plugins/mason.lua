return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup()

			mason_lspconfig.setup({
				ensure_installed = {
					"tsserver",
					"rust_analyzer",
					"lua_ls",
					"html",
					"cssls",
					"cssmodules_ls",
					-- "eslint",
					"yamlls",
					"astro",
					"tailwindcss",
					"prismals",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettierd",
					"stylua",
					-- "eslint_d",
					"codelldb",
					"node-debug2-adapter",
					"chrome-debug-adapter",
				},
			})
		end,
	},
}
