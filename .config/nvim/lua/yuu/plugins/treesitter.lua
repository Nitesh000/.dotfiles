return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = function()
			vim.cmd("TSUpdate")

			-- Installing all parsers at once
			vim.cmd(
				"TSInstall! json javascript typescript tsx yaml html css markdown markdown_inline svelte graphql bash lua vim dockerfile gitignore rust python scss sql go toml"
			)
		end,
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- Enable treesitter highlighting and indentation for every file type
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- Setup autotag
			require("nvim-ts-autotag").setup({})
		end,
	},
}

-- NOTE: older treesitter config still works with
-- return {
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		build = ":TSUpdate",
-- 		dependencies = {
-- 			"windwp/nvim-ts-autotag",
-- 			-- "nvim-treesitter/nvim-treesitter-context", -- context aware commentstring
-- 		},
-- 		config = function()
-- 			-- import nvim-treesitter plugin
-- 			local treesitter = require("nvim-treesitter.config")
--
-- 			-- configure treesitter
-- 			treesitter.setup({ -- enable syntax highlighting
-- 				highlight = {
-- 					enable = true,
-- 				},
-- 				-- enable indentation
-- 				indent = { enable = true },
-- 				-- enable autotagging (w/ nvim-ts-autotag plugin)
-- 				-- autotag = { enable = true },
-- 				-- ensure these language parsers are installed
-- 				ensure_installed = {
-- 					"json",
-- 					"javascript",
-- 					"typescript",
-- 					"tsx",
-- 					"yaml",
-- 					"html",
-- 					"css",
-- 					"markdown",
-- 					"markdown_inline",
-- 					"svelte",
-- 					"graphql",
-- 					"bash",
-- 					"lua",
-- 					"vim",
-- 					"dockerfile",
-- 					"gitignore",
-- 					"rust",
-- 					"python",
-- 					"scss",
-- 					"sql",
-- 					"go",
-- 					"toml",
-- 				},
-- 				-- auto install above language parsers
-- 				auto_install = true,
-- 			})
--
-- 			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
-- 			require("ts_context_commentstring").setup({})
--
-- 			-- setup autotag
-- 			require("nvim-ts-autotag").setup({})
-- 		end,
-- 	},
-- }
