return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier", "rustywind" },
				typescript = { "prettier", "rustywind" },
				javascriptreact = { "prettier", "rustywind" },
				typescriptreact = { "prettier", "rustywind" },
				svelte = { "prettier", "rustywind" },
				vue = { "prettier", "rustywind" },
				css = { "prettier", "rustywind" },
				html = { "prettier", "rustywind" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "ruff", "black" },
				go = { "gofumpt" },
				cpp = { "clangd-format" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return nil
				end
				return {
					lsp_fallback = true, -- change this to true if want to fail to formatting if no LSP formatter is available
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- <leader>tf: toggle format-on-save for just the CURRENT buffer (resets when you close it).
		vim.keymap.set("n", "<leader>tf", function()
			vim.b.disable_autoformat = not vim.b.disable_autoformat
			vim.notify("Format on save (buffer): " .. (vim.b.disable_autoformat and "OFF" or "ON"))
		end, { desc = "Toggle format-on-save for current buffer" })

		-- <leader>tF: toggle format-on-save globally, across every project.
		vim.keymap.set("n", "<leader>tF", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			vim.notify("Format on save (global): " .. (vim.g.disable_autoformat and "OFF" or "ON"))
		end, { desc = "Toggle format-on-save globally" })
	end,
}
