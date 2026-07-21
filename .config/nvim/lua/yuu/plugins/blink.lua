return {
	"Saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},

	-- use a release tag to download pre-built binaries
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<A-n>"] = { "snippet_forward", "fallback" },
			["<A-p>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		snippets = { preset = "luasnip" },

		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			ghost_text = { enabled = true },
			menu = {
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
				},
			},
		},
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		-- load vscode style snippets (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("blink.cmp").setup(opts)
	end,
}
