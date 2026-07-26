return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		-- use these for autocomplete in markdwon files
		-- completions = {
		-- 	lsp = {
		-- 		enabled = true,
		-- 	},
		-- },
		enabled = false,
	},
	keys = {
		{
			"<leader>vm",
			"<cmd>RenderMarkdown toggle<cr>",
			desc = "Toggle Markdown Rendering",
			ft = "markdown",
		},
	},
	-- enabled = false,
}
