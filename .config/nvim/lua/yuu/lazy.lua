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

-- local opts = {
-- 	install = {
-- 		colorscheme = { "nightfly" },
-- 	},
-- 	checker = {
-- 		enabled = true,
-- 		notify = false,
-- 	},
-- 	change_detection = {
-- 		notify = false,
-- 	},
-- }
local opts = {}

-- Configuring Lazy Plugins and options.
require("lazy").setup({ { import = "yuu.plugins" }, { import = "yuu.plugins.lsp" } }, opts)
