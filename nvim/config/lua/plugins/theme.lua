return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catpuccin = require("catppuccin")
    catpuccin.setup({
      flavour = "latte",
      transparent_background = true,
    })
    catpuccin.load()

    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  end,
}
