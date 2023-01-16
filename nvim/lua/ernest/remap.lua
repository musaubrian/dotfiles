vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})
-- formats the current buffer
vim.keymap.set("n", "K", vim.lsp.buf.format)
-- get info on item on cursor
vim.keymap.set('n', "<leader>K", vim.lsp.buf.hover)
-- find where the item on cursor is referenced
vim.keymap.set('n', "<leader>r", vim.lsp.buf.references)

--move highlighted blocks
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
