local lsp_servers = {
	gopls = "gopls",
}

vim.lsp.config("*", {
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
		local keymap = vim.keymap
		local opts = { buffer = bufnr, silent = true }

		keymap.set("n", "K", vim.lsp.buf.hover, opts)
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		keymap.set("n", "<leader>rf", vim.lsp.buf.format, opts)
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
		keymap.set("n", "<leader>dB", vim.diagnostic.goto_prev, opts)

        -- toggle inlay hints
        -- vim.keymap.set("n", "<leader>di", function()
        --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        -- end, opts)

		keymap.set("n", "<leader>rs", function()
            for server_name, lsp_executable in pairs(lsp_servers) do
                if vim.fn.executable(lsp_executable) == 1 then
                    vim.lsp.enable(server_name, false)
                    vim.lsp.enable(server_name, true)
                end
            end
        end, opts)

        vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
            buffer = bufnr,
            callback = function(event)
                local enabled = event.event == "InsertLeave"
                local clients = vim.lsp.get_clients({ bufnr = bufnr })

                vim.diagnostic.enable(enabled)
            end,
        })
    end,
})

for server_name, lsp_executable in pairs(lsp_servers) do
	if vim.fn.executable(lsp_executable) == 1 then
		vim.lsp.enable(server_name)
	end
end

vim.diagnostic.config({
    signs = false,
    underline = true,
    virtual_text = false,
    virtual_lines = true,
    float = {
        -- border = "rounded",
        source = "always",
    },
})
