return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- import lspconfig/uitl
		local util = require("lspconfig/util")

		-- import on_attach function
		local on_attach = require("yuu.core.lsp-keymaps")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				configurationSection = {
					"html",
					"css",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
				},
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = true,
			},
		})

		-- configure typescript server with plugin
		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- for using this have to install @vue/typescript-plugin in npm global
			-- init_options = {
			-- 	plugins = {
			-- 		{
			-- 			name = "@vue/typescript-plugin",
			-- 			location = "/Users/yuu/.nvm/versions/node/v20.13.1/lib/node_modules/@vue/typescript-plugin",
			-- 			languages = { "vue" },
			-- 		},
			-- 	},
			-- },
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascriptreact",
				"javascript",
				"html",
				"vue",
			},
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "css", "scss", "less" },
		})

		-- configure tailwindcss server
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"css",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
			},
		})

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "python" },
		})

		-- configure clangd server
		-- lspconfig["clangd"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })
		-- lspconfig.clangd.setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		-- configure gopls server
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.mod", "go.work", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})

		-- configure docker server
		lspconfig["dockerls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "dockerfile" },
		})

		-- configure prisma server
		lspconfig["prismals"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "prisma" },
		})

		-- configure svelte server
		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})
			end,
			filetypes = { "svelte" },
		})

		-- configure astro language server
		-- lspconfig["astro"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		-- configure swift language server
		-- configure linting with some --no-cache argument
		lspconfig.sourcekit.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "swift" },
			cmd = { "sourcekit-lsp" },
			-- root_dir = util.root_pattern("Package.swift"),
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
				filetypes = { "lua" },
			},
		})

		local border = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		}

		-- LSP settings (for overriding per client)
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		}

		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or border
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end
	end,
}
