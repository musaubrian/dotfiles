vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>tt", "<cmd>:terminal<CR>")

--make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- get info on item on cursor
vim.keymap.set('n', "K", vim.lsp.buf.hover)
-- find where the item on cursor is referenced
vim.keymap.set('n', "<leader>r", vim.lsp.buf.references)
-- format python files
vim.keymap.set('n', "<leader>fp", "<cmd>!black -v %<CR>", {})
-- format c files
vim.keymap.set('n', "<leader>fc", "<cmd>!clang-format -i %<CR>", {})
-- format go files
vim.keymap.set('n', "<leader>fg", "<cmd>!gofumpt -w ./.. <CR>", { silent = true })
-- format js files
vim.keymap.set('n', "<leader>fj", "<cmd>!semistandard --fix<CR>", { silent = true })
-- Prettier mostly for TS files
vim.keymap.set('n', "<leader>pt", "<cmd>!prettier -w %<CR>", {})

--move highlighted blocks
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', "<leader>sc", "<cmd>e ~/personal/scratches/ <CR>", { silent = true })

-- For some reason they weren't loading in lsp.lua
--[[ vim.keymap.set('n', '<leader>m', function() vim.lsp.buf.code_action() end, {})
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {})
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, {})
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {})
vim.keymap.set("n", "<leader>af", function() vim.lsp.buf.format() end, {}) ]]

vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {})
