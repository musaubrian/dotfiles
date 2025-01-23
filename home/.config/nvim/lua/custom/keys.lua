vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", "<cmd>e .<CR>")
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

vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

--Markdown
vim.keymap.set("n", "<localleader>b", 'viwc**<c-r>"**<esc>', { desc = "Bold text at cursor" })
vim.keymap.set("n", "<localleader>i", 'viwc_<c-r>"_<esc>', { desc = "Italicize text at cursor" })
vim.keymap.set("n", "<localleader>l", 'viwc[<c-r>"]()<left>', { desc = "Convert text on cursor to md link" })
vim.keymap.set("n", "<localleader>`", 'viwc`<c-r>"`<esc>', { desc = "Wrap with backticks" })

vim.keymap.set("n", "<space>rl", "<cmd>luafile %<CR>", {})
vim.keymap.set("v", "<space>rl", ":lua<CR>", {})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {})

vim.keymap.set("n", "<leader>tp", "<cmd>tabnext<CR>", {})
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", {})
