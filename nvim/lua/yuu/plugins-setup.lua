-- auto install lazy if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- add list of plugins to install
local plugins = {

	"nvim-lua/plenary.nvim", -- lua functions that many plugins use

	"github/copilot.vim", -- github copilot for smart code completions

	{ "bluz71/vim-nightfly-guicolors", name = "nightfly", lazy = false, priority = 1000 }, -- preferred colorscheme

	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	"szw/vim-maximizer", -- maximizes and restores current window

	-- essential plugins
	"tpope/vim-surround", -- add, delete, change surroundings (it's awesome,
	"vim-scripts/ReplaceWithRegister", -- replace with register contents using motion (gr + motion,

	-- commenting with gc
	"numToStr/Comment.nvim",

	-- better color comments (e.g. TODO, FIXME, etc...)
	{ "folke/todo-comments.nvim", dependencies = {
		{ "nvim-lua/plenary.nvim" },
	} },

	-- file explorer
	"nvim-tree/nvim-tree.lua",

	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",

	-- statusline
	"nvim-lualine/lualine.nvim",

	-- fuzzy finding w/ telescope
	{ "nvim-telescope/telescope-fzf-native.nvim", build = {
		cmd = "make",
	} }, -- dependency for better sorting performance
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder

	-- autocompletion
	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file system paths

	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	"neovim/nvim-lspconfig", -- easily configure language servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}, -- enhanced lsp uis
	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports,
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion
	"simrat39/rust-tools.nvim", -- rust tools for rust-analyzer

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = {
			run = "TSUpdate",
		},
	},

	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
	{ "windwp/nvim-ts-autotag" }, -- autoclose tags

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- toggle-terminal for neovim
	{ "akinsho/toggleterm.nvim", version = "*" },

	-- harpoon for quick navigation
	{ "ThePrimeagen/harpoon" }, -- quick navigation
}

local opts = {}

-- Configuring Lazy Plugins and options.
require("lazy").setup(plugins, opts)
