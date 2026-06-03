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
        })

        local C = require("catppuccin.palettes").get_palette("latte")

        -- Palette — your semantic colors. Reference these when opting a group
        -- back into color in `colored` below.
        local base = { fg = C.text } -- neutral foreground (the default for everything)
        local dim = { fg = C.surface2 } -- lightness-only cue (e.g. punctuation)
        local str = { fg = C.rosewater } -- strings + numbers
        local def = { fg = C.blue } -- function/type "declarations"
        local vdef = { fg = C.lavender } -- variable declarations
        local tdef = { fg = C.pink } -- type declarations
        local com = { fg = C.subtext0, bg = C.crust } -- comments: shaded region

        -- The ONLY treesitter capture groups that carry color. Everything else
        -- is flattened to `base` (see apply_theme). Add a line here whenever you
        -- decide a group is worth a hue — that's the whole maintenance surface.
        -- Note: children inherit nothing automatically here (flatten sets each
        -- leaf to base individually), so list a child explicitly if you want it
        -- colored — e.g. @function is `def` but @function.call stays base.
        local colored = {
            -- strings + numbers -> rosewater
            ["@string"] = str,
            ["@string.escape"] = str,
            ["@character"] = str,
            ["@number"] = str,
            ["@number.float"] = str,
            ["@boolean"] = str,
            ["@constant"] = str,
            ["@constant.builtin"] = str,

            -- dimmed punctuation / operators (lightness-only cue)
            ["@punctuation.delimiter"] = dim,
            ["@punctuation.bracket"] = dim,
            ["@punctuation.special"] = dim,
            ["@operator"] = dim,
            ["@tag.delimiter"] = dim, -- < > /> </ in templ/jsx/html

            -- function / "declarations" -> blue
            ["@function"] = def,
            ["@function.method"] = def,
            ["@module.declaration"] = def, -- go package name + js/ts imports
            ["@variable.declaration"] = vdef, -- from after/queries (let/const/var, params)
            ["@type.definition"] = tdef,

            -- comments -> shaded region
            ["@comment"] = com,
            ["@keyword.defer"] = com, -- go `defer` -> obvious shaded box
            ["Comment"] = com, -- non-treesitter comment fallback
        }

        -- Marker captures that aren't color-bearing; don't flatten these.
        local skip = { ["@none"] = true, ["@spell"] = true, ["@nospell"] = true, ["@conceal"] = true }

        -- Non-treesitter UI tweaks (Telescope, floats, diagnostics).
        local ui = {
            TelescopeMatching = { fg = C.flamingo },
            TelescopeSelection = { fg = C.text, bg = C.surface0, bold = true },
            TelescopeNormal = { bg = "NONE" },
            TelescopePromptPrefix = { bg = "NONE" },
            TelescopePromptBorder = { bg = "NONE", fg = C.surface0 },
            TelescopeResultsBorder = { bg = "NONE", fg = C.surface0 },
            TelescopePreviewBorder = { bg = "NONE", fg = C.surface0 },
            TelescopePromptTitle = { bg = C.pink, fg = C.mantle },
            TelescopeResultsTitle = { bg = C.flamingo, fg = C.mantle },
            TelescopePreviewTitle = { bg = C.green, fg = C.mantle },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE", fg = C.surface0 },
            DiagnosticUnnecessary = { bg = "#d3daf4" },
            DiagnosticLineError = { bg = "#f3dede" },
            DiagnosticLineWarn = { bg = "#f1ecda" },
            DiagnosticVirtualLinesError = { bg = "#efced3", fg = "#7e2533" },
            DiagnosticVirtualLinesWarn = { bg = "#ece0c0", fg = "#6e5621" },
            DiagnosticVirtualLinesInfo = { bg = "#b6d2fb", fg = "#0c2e70" },
            DiagnosticVirtualLinesHint = { bg = "#fcd2f7", fg = "#5e2156" },
        }

        -- Re-applied on every ColorScheme so it survives reloads.
        local function apply_theme()
            -- 1. base by default: flatten every @-capture group to neutral text
            for name in pairs(vim.api.nvim_get_hl(0, {})) do
                if name:sub(1, 1) == "@" and not skip[name] then
                    vim.api.nvim_set_hl(0, name, base)
                end
            end
            -- 2. opt specific groups back into color
            for name, col in pairs(colored) do
                vim.api.nvim_set_hl(0, name, col)
            end
            -- 3. UI tweaks
            for name, col in pairs(ui) do
                vim.api.nvim_set_hl(0, name, col)
            end
        end

        vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_theme })
        catpuccin.load()
        vim.cmd.colorscheme("catppuccin-nvim")
        apply_theme()
    end,
}
