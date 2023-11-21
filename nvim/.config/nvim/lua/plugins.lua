local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local get_config = function(name)
  return string.format('require("util").load("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  execute('packadd packer.nvim')
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
    {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'onsails/lspkind.nvim' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'L3MON4D3/LuaSnip' },
      },
      config = get_config('cmp'),
    },
    {
      'L3MON4D3/LuaSnip',
      config = get_config('luasnip'),
    },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    {
      'jay-babu/mason-null-ls.nvim',
      after = { 'mason.nvim', 'null-ls.nvim' },
      config = get_config('mason-null-ls'),
    },
    'mfussenegger/nvim-dap',
    {
      'jay-babu/mason-nvim-dap.nvim',
      after = { 'mason.nvim', 'nvim-dap' },
      config = get_config('mason-nvim-dap'),
    },
    {
      'neovim/nvim-lspconfig',
      config = get_config('lsp')
    },
  }

  -- Copilot
  use {
    {
      'zbirenbaum/copilot.lua',
      cmd = "Copilot",
      event = "InsertEnter",
    },
    {
      'zbirenbaum/copilot-cmp',
      after = { "copilot.lua" },
      config = get_config('copilot'),
    }
  }

  -- Utility
  use {
    {
      'tpope/vim-fugitive',
      config = get_config('fugitive'),
    },
    'tpope/vim-surround',
    'tpope/vim-repeat',
    {
      'folke/todo-comments.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = get_config('todo-comments'),
    },
    {
      'numToStr/Comment.nvim',
      config = get_config('comment'),
    },
    {
      "kdheepak/lazygit.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = get_config('lazygit'),
    },
  }

  -- Languages
  use {
    'jparise/vim-graphql',
    'tomlion/vim-solidity',
    'pantharshit00/vim-prisma',
  }

  -- Telescope
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
      config = get_config('telescope'),
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  }

  -- Code Authoring
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = get_config('treesitter'),
    },
    {
      'windwp/nvim-ts-autotag',
      config = get_config('nvim-ts-autotag'),
    },
    {
      'windwp/nvim-autopairs',
      config = get_config('nvim-autopairs'),
    }
  }

  -- Theme
  use {
    'EdenEast/nightfox.nvim',
    config = get_config('nightfox'),
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    event = 'VimEnter',
    config = get_config('lualine'),
  }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  }
end)
