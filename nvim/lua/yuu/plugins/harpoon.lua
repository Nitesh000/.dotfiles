-- setting up harpoon
local markSetup, mark = pcall(require, "harpoon.mark")
if not markSetup then
	return
end

local uiSetup, ui = pcall(require, "harpoon.ui")
if not uiSetup then
	return
end

local keymap = vim.keymap

keymap.set("n", "<leader>ha", mark.add_file)
keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

keymap.set("n", "<C-n>", ui.nav_next)
keymap.set("n", "<C-p>", ui.nav_prev)
