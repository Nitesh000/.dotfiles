return {
	"CRAG666/code_runner.nvim",
	lazy = true,
	keys = { "<leader>rr", "<cmd>RunCode<CR>" },
	config = function()
		local keymap = vim.keymap -- for custom mappings
		require("code_runner").setup({
			filetype = {
				java = {
					"cd '$dir' && javac $fileName && java $fileNameWithoutExt",
				},
				python = "python3 -u $fileName",
				typescript = "ts-node $fileName",
				javascript = "node $fileName",
				rust = {
					"cd '$dir' && rustc $fileName && '$dir/$fileNameWithoutExt'",
				},
				cpp = {
					"cd '$dir' && g++ $fileName && '$dir/a.out'",
				},
				c = {
					"cd '$dir' && gcc $fileName && '$dir/a.out'",
				},
			},
		})

		-- code_runner keymaps
		keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false }) -- run code
		keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false }) -- run code
	end,
}
