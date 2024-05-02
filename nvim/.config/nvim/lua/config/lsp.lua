local servers = {
	"tsserver",
	"rust_analyzer",
	"lua_ls",
	"html",
	"cssls",
	"cssmodules_ls",
	"eslint",
	"yamlls",
	"astro",
  "tailwindcss",
  "prismals",
  "gleam",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

local shared_on_attach = function()
	-- Utility mappings
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
	vim.keymap.set("n", "<leader>rf", vim.lsp.buf.format, { buffer = 0 })

	-- Go commands - i.e. "jump" commands
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = 0 })
	vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { buffer = 0 })
	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = 0 })
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = 0 })
	vim.keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = 0 })
	vim.keymap.set("n", "gS", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = 0 })

	-- Diagnostics
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = 0 })
	vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, { buffer = 0 })
	vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, { buffer = 0 })
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
end

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
	local has_settings, settings = pcall(require, string.format("lsp_servers/%s", server))
	if not has_settings then
		settings = {}
	end

	local server_on_attach = settings.on_attach

	-- Set on attach for every server
	settings.on_attach = function(client, bufnr)
		if server_on_attach ~= nil then
			server_on_attach(client, bufnr)
		end
		shared_on_attach()
	end
	settings.capabilities = capabilities

	lspconfig[server].setup(settings)
end
