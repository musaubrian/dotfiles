local mark_file = require("harpoon.mark").add_file
local view_marks = require("harpoon.ui").toggle_quick_menu
local nav_next = require("harpoon.ui").nav_next
local nav_prev = require("harpoon.ui").nav_prev
local clear_marks = require("harpoon.mark").clear_all

vim.keymap.set('n', '<leader>ma', mark_file, {})
vim.keymap.set('n', '<leader>mn', nav_next, {})
vim.keymap.set('n', '<leader>mp', nav_prev, {})
vim.keymap.set('n', '<leader>mm', view_marks, {})
vim.keymap.set('n', '<leader>cm', clear_marks, {})
