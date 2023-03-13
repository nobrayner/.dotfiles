vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require 'cmp'
local lspkind = require 'lspkind'
local ls = require 'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-n>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
    }),
  }),
  sources = cmp.config.sources({
    { name = 'copilot' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = {
        copilot = '[COPILOT]',
        buffer = '[BUF]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[VIM API]',
        path = '[PATH]',
        luasnip = '[SNIP]',
      },
    })
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})
