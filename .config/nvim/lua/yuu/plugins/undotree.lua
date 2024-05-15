return {
	"mbbill/undotree", -- undo tree
	keys = { "<leader>u", "<cmd>UndotreeToggle<CR>" },
	config = function()
		local keymap = vim.keymap -- for custom keymaps
		-- undotree visualize
		keymap.set("n", "<leader>u", ":UndotreeToggle<CR>") -- toggle undotree
	end,
}
