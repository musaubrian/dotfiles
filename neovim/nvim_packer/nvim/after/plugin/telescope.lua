local builtin = require('telescope.builtin')
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
}
-- recently opened files
vim.keymap.set('n', '<leader><space>', builtin.oldfiles, {})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- searches for where the word under cursor has been *used
vim.keymap.set('n', '<leader>sw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sp', builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>d", builtin.diagnostics, {})
