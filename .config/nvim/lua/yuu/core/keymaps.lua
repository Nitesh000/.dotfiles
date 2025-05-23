-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- move command in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move line down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move line up

-- search term to stay at the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- put the cursor in the middle when half page up/down
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set({ "n", "v" }, "<C-m>", "<C-d>zz")

-- don't copy to clipboard when cut-pasting
keymap.set("x", "<leader>p", '"_dP')

-- only copy to system clipboard with <leader>y
keymap.set({ "n", "v" }, "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

-- only copy on delete when do <leader>d
keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- change the "J" command to a little stable
keymap.set("n", "J", "mzJ`z")

-- change the a file to executable
keymap.set("n", "<leader>x", "<cmd>!chmod 700 %<CR>", { silent = true })

----------------------
-- Plugin Keybinds
----------------------

-- Lazy package manager
keymap.set("n", "<leader>ll", ":Lazy<CR>") -- this will open the package manager

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- show the register fuzzy findings
keymap.set("n", "<leader>fr", ":Telescope registers<CR>")
