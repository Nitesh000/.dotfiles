return {
	"tpope/vim-fugitive", -- for handling git commands
	keys = { "<leader>G", "<cmd>Git<CR>" },
	config = function()
		local keymap = vim.keymap -- for custom keymaps

		-- fugitive custom keymaps
		keymap.set("n", "<leader>G", ":Git<CR>") -- git status
		keymap.set("n", "<leader>gw", ":Gwrite<CR>") -- git add current file
		keymap.set("n", "<leader>gC", ":Git commit<CR>") -- git commit
		keymap.set("n", "<leader>gds", ":Gvdiffsplit!<CR>") -- git merge conflict resolution
		keymap.set("n", "<leader>gdp", ":diffput<CR>") -- diffput
		keymap.set("n", "<leader>gdg", ":diffget<CR>") -- diffget
	end,
}
