vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- format python files
vim.keymap.set('n', "<leader>fp", "<cmd>!black -v %<CR>", {})
-- Prettier mostly for TS files
vim.keymap.set('n', "<leader>pt", "<cmd>!prettier -w %<CR>", {})

--move highlighted blocks
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn ")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
