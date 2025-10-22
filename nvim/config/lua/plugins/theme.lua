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

        local colors = require("catppuccin.palettes").get_palette()
        local Highlights = {
            -- Telescope
            TelescopeMatching = { fg = colors.flamingo },
            TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
            TelescopeNormal = { bg = "NONE" },
            TelescopePromptPrefix = { bg = "NONE" },
            TelescopePromptBorder = { bg = "NONE", fg = colors.surface0 },
            TelescopeResultsBorder = { bg = "NONE", fg = colors.surface0 },
            TelescopePreviewBorder = { bg = "NONE", fg = colors.surface0 },
            TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
            TelescopeResultsTitle = { bg = colors.flamingo, fg = colors.mantle },
            TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },

            -- Other
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE", fg = colors.surface0 },
            -- Pmenu = { bg = "NONE", fg = colors.surface0 },
        }

        for hl, col in pairs(Highlights) do
            vim.api.nvim_set_hl(0, hl, col)
        end
    end,
}
