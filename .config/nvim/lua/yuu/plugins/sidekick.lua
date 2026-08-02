return {
	"folke/sidekick.nvim",
	opts = {
		cli = {
			tools = {
				my_tool = {
					cmd = { "pi" },
					-- Optional: custom keymaps for this
					-- keys = {
					-- 	submit = {
					-- 		"<c-s>",
					-- 		function(t)
					-- 			t:send("\n")
					-- 		end,
					-- 	},
					-- },
				},
			},
			nes = {
				enabled = false,
			},
		},
	},
	keys = {
		{ "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
		{
			"<c-.>",
			function()
				require("sidekick.cli").focus()
			end,
			desc = "Sidekick Focus",
			mode = { "n", "t", "i", "x" },
		},
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle({ name = "pi", focus = true })
			end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").select({ name = "pi", focus = true })
			end,
			-- Or to select only installed tools:
			-- require("sidekick.cli").select({ filter = { installed = true } })
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}", name = "pi", focus = true })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}", name = "pi", focus = true })
			end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}", name = "pi", focus = true })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	},
}
