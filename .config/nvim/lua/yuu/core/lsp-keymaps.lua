local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	-- keymap.set("n", "gf", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
	keymap.set("n", "gf", "<cmd>Trouble lsp toggle<cr>", opts) -- trouble show definitions, references
	keymap.set("n", "<leader>gt", "<cmd>Trouble diagnostics toggle<cr>", opts) -- trouble diagnostics (Trouble)
	keymap.set("n", "<leader>gb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts) -- trouble diagnostics of current buffer
	keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show definition
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show implementation
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
	keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file
	keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>fo", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find outline symbols" }) -- to find the outline symbols in the current file (functions, classes)
end

return on_attach
