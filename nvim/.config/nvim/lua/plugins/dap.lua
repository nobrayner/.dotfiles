return {
  "mfussenegger/nvim-dap",
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    config = function()
      require "mason-nvim-dap".setup({
        ensure_installed = {
          "codelldb",
          "chrome-debug-adaptor",
          "node-debug2-adaptor",
        },
        automatic_setup = true,
      })
    end
  },
}
