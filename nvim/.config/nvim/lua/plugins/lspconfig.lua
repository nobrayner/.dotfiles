return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
				keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<cr>", opts)
				keymap.set("n", "gS", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
				keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)

				keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts)
				keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, opts)

				keymap.set("n", "<leader>rs", ":LspRestart<cr>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
								path = runtime_path,
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = {
								enable = false,
							},
						},
					},
				})
			end,
		})
	end,
}
