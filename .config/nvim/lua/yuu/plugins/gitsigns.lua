return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local keymap = vim.keymap -- for custom keymaps
		local gitsigns = require("gitsigns") -- for gitsigns config
		gitsigns.setup()

		-- hunk navigation: jump between changed chunks (e.g. edits made by pi/sidekick)
		keymap.set("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Next Hunk" })
		keymap.set("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Prev Hunk" })

		-- view the exact change in a floating window
		keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })

		-- revert just this hunk (undo the AI's change to this chunk); press `u` to undo the revert
		keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
		keymap.set("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Reset Hunk (selection)" })

		-- revert the whole file back to git HEAD
		keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })

		-- side-by-side diff of the whole file against HEAD
		keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })

		-- telescope git commands (not on youtube nvim video)
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
		keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
	end,
}
