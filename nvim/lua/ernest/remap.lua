vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})
-- formats the current buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- get info on item on cursor
vim.keymap.set('n', "K", vim.lsp.buf.hover, bufopts)
