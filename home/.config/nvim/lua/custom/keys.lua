vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>Term<CR>", { desc = "Open term split bottom" })
vim.keymap.set("n", "<leader>st", "<cmd>vs | FTerm<CR>", { desc = "Open term split to right" })
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Split size manipulation
vim.keymap.set("n", "<A-<>", "<Cmd>vertical resize +5<CR>", { desc = "resize split towards left" })
vim.keymap.set("n", "<A->>", "<Cmd>vertical resize -5<CR>", { desc = "resize split towards right" })
vim.keymap.set("n", "<A-l>", "<Cmd>resize +5<CR>", { desc = "resize split downwards" })
vim.keymap.set("n", "<A-L>", "<Cmd>resize -5<CR>", { desc = "resize split upwards" })
--move highlighted blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<right>", function()
	vim.notify("Use l to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<left>", function()
	vim.notify("Use h to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<up>", function()
	vim.notify("Use k to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<down>", function()
	vim.notify("Use j to move", vim.log.levels.WARN)
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.diagnostic.config({
	virtual_text = true,
})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
