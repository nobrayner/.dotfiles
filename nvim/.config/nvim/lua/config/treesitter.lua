local languages = {
  'typescript',
  'javascript',
  'rust',
  'solidity',
  'lua',
  'html',
  'css',
  'scss',
  'prisma',
  'yaml',
  'toml',
  'tsx',
  'markdown',
  'json',
  'graphql',
  'dockerfile',
  'astro',
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = languages,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true }
}
