return {
	"mfussenegger/nvim-dap", -- debug adapter protocol
	keys = {
		{ "<leader>db" },
	},
	dependencies = {
		"williamboman/mason.nvim",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local keymap = vim.keymap
		local dap = require("dap")
		local dapui = require("dapui")
		local dapIcons = {
			Stopped = "󰁕 ",
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = " ",
			LogPoint = ".>",
		}

		dapui.setup({})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close({})
		end

		---- Define colors for DAP icons
		vim.cmd([[
  highlight Breakpoint guifg=#e06c75 gui=bold
  highlight BreakpointCondition guifg=#e5c07b gui=bold
  highlight Stopped guifg=#98c379 gui=bold
  highlight StoppedLine guibg=#31353f
  highlight LogPoint guifg=#61afef
]])

		-- custom dap signs
		-- vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })

		-- function to sign define of all dapIcons
		for icon, color in pairs(dapIcons) do
			vim.fn.sign_define(
				"Dap" .. icon,
				{ text = color, texthl = icon or "DiagnosticInfo", linehl = "", numhl = "" }
			)
		end

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = 8123,
			executable = {
				command = "js-debug-adapter",
			},
		}

		for _, lang in pairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
				},
			}
		end

		-- keymaps
		keymap.set(
			"n",
			"<leader>db",
			"<cmd> DapToggleBreakpoint <CR>",
			{ desc = "Add/Remove breakpoint at current line" }
		)
		keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run/Continue debugger" })
	end,
}
