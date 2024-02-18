return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    vim.keymap.set('n', '<leader>mm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {})

    vim.keymap.set('n', '<leader>ma', function() harpoon:list():append() end, {})

    vim.keymap.set('n', '<leader>mn', function() harpoon:list():prev() end, {})
    vim.keymap.set('n', '<leader>mp', function() harpoon:list():next() end, {})

    vim.keymap.set('n', '<leader>m1', function() harpoon:list():select(1) end, {})
    vim.keymap.set('n', '<leader>m2', function() harpoon:list():select(2) end, {})
    vim.keymap.set('n', '<leader>m3', function() harpoon:list():select(3) end, {})
    vim.keymap.set('n', '<leader>m4', function() harpoon:list():select(4) end, {})
  end

}
