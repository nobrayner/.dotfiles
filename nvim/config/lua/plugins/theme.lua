return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        local catpuccin = require("catppuccin")
        catpuccin.setup({
            flavour = "latte",
            transparent_background = true,
            no_italic = true,
            no_bold = true,
            no_underline = true,
            custom_highlights = function(C)
                local base = { fg = C.text }
                local dim = { fg = C.surface2 }
                local str = { fg = C.rosewater } -- strings + numbers
                local def = { fg = C.blue } -- function/top-level defs
                local vdef = { fg = C.lavender } -- variable declarations
                local tdef = { fg = C.pink } -- type declarations
                local com = { fg = C.subtext0, bg = C.crust } -- comments: shaded region

                return {
                    -- Base text: keywords, usages, calls, types
                    ["@variable"] = base,
                    ["@variable.member"] = base,
                    ["@variable.parameter"] = base,
                    ["@variable.declaration"] = vdef,
                    ["@property"] = base,
                    ["@field"] = base,
                    ["@parameter"] = base,
                    ["@function.call"] = base,
                    ["@function.method.call"] = base,
                    ["@constructor"] = base,
                    ["@type"] = base,
                    ["@type.builtin"] = base,
                    ["@type.qualifier"] = base,
                    ["@type.definition"] = tdef,
                    ["@namespace"] = base,
                    ["@module"] = base,
                    ["@keyword"] = base,
                    ["@keyword.function"] = base,
                    ["@keyword.return"] = base,
                    ["@keyword.operator"] = base,
                    ["@keyword.conditional"] = base,
                    ["@keyword.repeat"] = base,
                    ["@keyword.import"] = base,
                    ["@keyword.coroutine"] = base,
                    ["@conditional"] = base,
                    ["@repeat"] = base,
                    ["@exception"] = base,

                    -- Dimmed punctuation (lightness cue only)
                    ["@punctuation.delimiter"] = dim,
                    ["@punctuation.bracket"] = dim,
                    ["@punctuation.special"] = dim,
                    ["@operator"] = dim,

                    -- Strings + numbers -> teal
                    ["@string"] = str,
                    ["@string.escape"] = str,
                    ["@character"] = str,
                    ["@number"] = str,
                    ["@number.float"] = str,
                    ["@boolean"] = str,
                    ["@constant"] = str,
                    ["@constant.builtin"] = str,

                    -- Function/top-level definitions -> blue
                    ["@function"] = def,
                    ["@function.method"] = def,

                    -- Comments -> shaded region (colorblind-safe by area, not hue)
                    ["@comment"] = com,
                    ["Comment"] = com,

                    -- Other cleanup to break fallbacks
                    ["DiagnosticUnnecessary"] = { bg = "#d3daf4" },
                    ["DiagnosticLineError"] = { bg = "#f3dede" },
                    ["DiagnosticLineWarn"] = { bg = "#f1ecda" },
                }
            end,
        })
        catpuccin.load()
        vim.cmd.colorscheme("catppuccin-nvim")

        -- Telescope + float highlights (kept from the shared repo config)
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

        local function diag_hl()
            vim.api.nvim_set_hl(0, "DiagnosticVirtualLinesError", {
                bg = "#d63952",
                fg = "#fbeaee",
            })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualLinesWarn", {
                bg = "#a8842f",
                fg = "#fbf3e0",
            })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualLinesInfo", {
                bg = "#d4e4fb",
                fg = "#1c3a6e",
            })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualLinesHint", {
                bg = "#cdc4e8",
                fg = "#3a2a6e",
            })
        end
        vim.api.nvim_create_autocmd("ColorScheme", { callback = diag_hl })
        diag_hl()
    end,
}
