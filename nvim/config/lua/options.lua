local o = vim.opt
local wo = vim.wo
-- local fn = vim.fn

o.hlsearch = false
o.showmode = false
o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.smartindent = true
o.scrolloff = 8
o.number = true
o.relativenumber = true
o.termguicolors = true
wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"
wo.foldcolumn = "1"
o.foldlevelstart = 99
o.shortmess = o.shortmess + "c"
o.splitbelow = true
o.splitright = true
o.ignorecase = true
o.smartcase = true
o.laststatus = 3

vim.cmd("set mouse=a")

--Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Should probably be in an autocommands file? But it is kinda an option...
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
