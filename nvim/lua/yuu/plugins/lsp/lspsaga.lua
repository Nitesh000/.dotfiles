-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_up = "<C-k>", scroll_down = "<C-j>" },
	-- use enter to open file with finder
	finder = {
		edit = "<CR>",
	},
	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
	},
})
