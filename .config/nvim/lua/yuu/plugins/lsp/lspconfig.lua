return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- local lspconfig = require("lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- import lspconfig/uitl
		local util = require("lspconfig/util")

		-- import on_attach function
		local on_attach = require("yuu.core.lsp-keymaps")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		local custom_signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(custom_signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = custom_signs.Error,
					[vim.diagnostic.severity.WARN] = custom_signs.Warn,
					[vim.diagnostic.severity.HINT] = custom_signs.Hint,
					[vim.diagnostic.severity.INFO] = custom_signs.Info,
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- configure html server
		vim.lsp.config("html", {
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
		vim.lsp.config("ts_ls", {
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
		vim.lsp.config("cssls", {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "css", "scss", "less" },
		})

		-- configure tailwindcss server
		vim.lsp.config("tailwindcss", {
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
		vim.lsp.config("pyright", {
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
		vim.lsp.config("gopls", {
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
		vim.lsp.config("dockerls", {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "dockerfile" },
		})

		-- configure prisma server
		vim.lsp.config("prismals", {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "prisma" },
		})

		-- configure svelte server
		vim.lsp.config("svelte", {
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

		-- NOTE: my sourcekit configure swift language server
		-- configure linting with some --no-cache argument
		-- lspconfig.sourcekit.setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	filetypes = { "swift" },
		-- 	cmd = { "sourcekit-lsp" },
		-- 	-- root_dir = util.root_pattern("Package.swift"),
		-- })

		-- NOTE: sourcekit setup from web
		vim.lsp.config("sourcekit", {
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
			filetypes = { "swift" },
			on_attach = on_attach,
			root_dir = function(fname)
				return util.root_pattern("Package.swift")(fname) or util.path.dirname(fname)
			end,
		})

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
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
