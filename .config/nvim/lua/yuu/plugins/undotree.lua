return {
	"mbbill/undotree", -- undo tree
	keys = { "<leader>ut", "<cmd>UndotreeToggle<CR>" },
	config = function()
		local keymap = vim.keymap -- for custom keymaps
		-- undotree visualize
		keymap.set("n", "<leader>ut", ":UndotreeToggle<CR>") -- toggle undotree
	end,
}
