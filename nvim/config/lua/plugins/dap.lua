return {
	"mfussenegger/nvim-dap",
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"codelldb",
					"chrome-debug-adaptor",
					"node-debug2-adaptor",
				},
				automatic_setup = true,
				handlers = {},
			})

			local dap = require("dap")

			local jsts = {
				{
					type = "node2",
					name = "Launch (npm)",
					request = "launch",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "npm",
					runtimeArgs = { "run", "debug" },
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					port = 9229,
				},
				{
					type = "node2",
					name = "Attach",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					port = 9229,
				},
			}

			-- local chrome = {
			-- 	-- TBD
			-- }

			local rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = false,
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = function()
						return require("dap.utils").pick_process({
							filter = function(proc)
								local matches = vim.startswith(proc.name, "target/debug/")
								return matches
							end,
						})
					end,
					args = {},
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations = {
				javascript = jsts,
				typescript = jsts,
				-- javascriptreact = chrome,
				-- typescriptreact = chrome,
				rust = rust,
			}

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				expand_lines = vim.fn.has("nvim-0.7"),
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil,
				},
			})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>dn", dap.step_over)
			vim.keymap.set("n", "<leader>di", dap.step_into)
			vim.keymap.set("n", "<leader>do", dap.step_out)
		end,
		keys = {
			{
				"<leader>dd",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Start or continue debugging",
			},
		},
	},
}
