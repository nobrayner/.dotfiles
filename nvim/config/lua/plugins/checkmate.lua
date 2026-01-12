return {
	{
		"bngarren/checkmate.nvim",
		ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
		opts = {
			files = {
				"todo.md",
			},
			keys = {
				["<leader>tt"] = {
					rhs = "<cmd>Checkmate toggle<CR>",
					desc = "Toggle todo item",
					modes = { "n", "v" },
				},
				["<leader>tn"] = {
					rhs = "<cmd>Checkmate create<CR>",
					desc = "Create todo item",
					modes = { "n", "v" },
				},
				["<leader>tr"] = {
					rhs = "<cmd>Checkmate remove<CR>",
					desc = "Remove todo marker (convert to text)",
					modes = { "n", "v" },
				},
				["<leader>tR"] = {
					rhs = "<cmd>Checkmate remove_all_metadata<CR>",
					desc = "Remove all metadata from a todo item",
					modes = { "n", "v" },
				},
				["<leader>tv"] = {
					rhs = "<cmd>Checkmate metadata select_value<CR>",
					desc = "Update the value of a metadata tag under the cursor",
					modes = { "n" },
				},
			},
		},
		keys = {
			{
				"<leader>t.",
				function()
					-- Can implement your own logic for saving files by cwd, project, git branch, etc.
					local root = vim.fn.getcwd()
					local file = root .. "/todo.md"

					---@diagnostic disable-next-line: missing-fields
					Snacks.scratch.open({
						ft = "markdown",
						file = file,
					})
				end,
				desc = "Toggle Scratch Todo",
			},
		},
	},
}
