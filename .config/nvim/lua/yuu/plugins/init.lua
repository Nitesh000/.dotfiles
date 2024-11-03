return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"vim-scripts/ReplaceWithRegister", -- replace with register contents using motion (gr + motion,
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	-- rust lsp
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		event = { "VeryLazy" },
		ft = { "rust", "rs" },
		config = function()
			local on_attach = require("yuu.core.lsp-keymaps")

			vim.g.rustaceanvim = {
				server = {
					on_attach = on_attach,
				},
			}
		end,
	},

	-- nvim-dap-go
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		ft = { "go" },
		config = function()
			require("dap-go").setup()
		end,
	},
}
