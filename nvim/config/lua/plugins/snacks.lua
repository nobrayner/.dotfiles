return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			lazygit = { enabled = true },
			scratch = { enabled = true },
			notifier = { enabled = true },
		},
		keys = {
			-- Lazygit
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Open lazy git",
			},
			-- Scratch
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			-- Notifications
			{
				"<leader>n",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Show notifications",
			},
		},
	},
}
