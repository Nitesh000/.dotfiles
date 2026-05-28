return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	event = { "BufReadPre" },
	opts = {
		modes = {
			lsp = {
				win = { position = "right" },
			},
		},
	},
	keys = {
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
}
