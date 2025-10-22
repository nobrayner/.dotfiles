return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local ls = require("luasnip")

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			snippet = {
				expand = function(args)
					ls.lsp_expand(args.body)
				end,
			},
			window = {
                completion = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
                }),
            },
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-n>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					select = false,
				}),
			}),
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer", keyword_length = 5 },
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					menu = {
						copilot = "[COPILOT]",
						buffer = "[BUF]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[VIM]",
						path = "[PATH]",
						luasnip = "[SNIP]",
					},
				}),
			},
		})

		-- cmp.setup.cmdline(":", {
		--   mapping = cmp.mapping.preset.cmdline(),
		--   sources = cmp.config.sources({
		--     { name = "path" },
		--   }, {
		--     { name = "cmdline" },
		--   }),
		-- })
	end,
}
