return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
      },
    })

    vim.cmd("colorscheme nordfox")

    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  end,
}
