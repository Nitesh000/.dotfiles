return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>hh", "<cmd>require('harpoon.ui').toggle_quick_menu()<CR>" },
		{ "<leader>ha", "<cmd>require('harpoon.mark').add_file()<CR>" },
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ha", mark.add_file)
		keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

		keymap.set("n", "<C-n>", ui.nav_next)
		keymap.set("n", "<C-p>", ui.nav_prev)
	end,
}
