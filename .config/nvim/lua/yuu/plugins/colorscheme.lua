return {
	{
		"bluz71/vim-nightfly-guicolors",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme nightfly]])

			local highlights = {
				Normal = { bg = "none" },
				NormalNC = { bg = "none" },
				SignColumn = { bg = "none" },
				LineNr = { bg = "none", fg = "#4B6479" },
				CursorLineNr = { bg = "none", fg = "#82AAFF" },
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
				EndOfBuffer = { bg = "none" },
				VertSplit = { bg = "none" },
				CursorLine = { bg = "#45222F" },
				WinSeparator = { fg = "#019F9E", bg = "none" }, -- added line
				NvimTreeCursorLine = { bg = "#45222F" },
				MatchParen = { bg = "#023135" },
				FloatBorder = { fg = "#019F9E", bg = "none" },
				NormalFloat = { bg = "none" },
			}

			for group, opts in pairs(highlights) do
				vim.api.nvim_set_hl(0, group, opts)
			end

			local telescope_custom_highlights = {
				TelescopeBorder = { fg = "#019F9E", bg = "none" },
				TelescopePromptBorder = { fg = "#019F9E", bg = "none" },
				TelescopeResultsBorder = { fg = "#019F9E", bg = "none" },
				TelescopePreviewBorder = { fg = "#019F9E", bg = "none" },

				TelescopeSelection = { bg = "#45222F" },
			}

			for group, opts in pairs(telescope_custom_highlights) do
				vim.api.nvim_set_hl(0, group, opts)
			end
		end,
	},
}
