local null_ls = require'null-ls'

-- local with_root_file = function(...)
--     local files = { ... }
--     return function(utils)
--         return utils.root_has_file(files)
--     end
-- end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions

local Format = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup {
  sources = {
    formatting.prettier,
    formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = Format, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = Format,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
}
