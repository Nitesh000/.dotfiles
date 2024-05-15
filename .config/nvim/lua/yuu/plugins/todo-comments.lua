return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup()

		-- custom keymaps for jumping between todo items
		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "find todo comments" })
	end,
}
