local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local server_settings = {
  tsserver = {},
  rust_analyzer = {},
  solidity_ls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  html = {},
  cssls = {},
  cssmodules_ls = {},
  eslint = {},
  prismals = {},
  yamlls = {},
  graphql = {},
}

local servers = {}
for k, _ in pairs(server_settings) do
  table.insert(servers, k)
end

require('nvim-lsp-installer').setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local shared_on_attach = function()
  -- Utility mappings
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, { buffer = 0 })

  -- Go commands - i.e. "jump" commands
  vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = 0 })
  vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { buffer = 0 })
  vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { buffer = 0 })
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = 0 })
  vim.keymap.set('n', 'gs', '<cmd>Telescope lsp_document_symbols<cr>', { buffer = 0 })
  vim.keymap.set('n', 'gS', '<cmd>Telescope lsp_workspace_symbols<cr>', { buffer = 0 })

  -- Diagnostics
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { buffer = 0 })
  vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set('n', '<leader>db', vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', { buffer = 0 })
end

local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

for server, settings in pairs(server_settings) do
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
