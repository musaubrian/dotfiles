return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {}

    vim.keymap.set("n", "<leader>mm", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {})

    vim.keymap.set("n", "<leader>ma", function()
      harpoon:list():add()
    end, {})

    vim.keymap.set("n", "<leader>mn", function()
      harpoon:list():prev()
    end, {})
    vim.keymap.set("n", "<leader>mp", function()
      harpoon:list():next()
    end, {})

    for i = 1, 4 do
      vim.keymap.set("n", string.format("<leader>m%s", i), function()
        harpoon:list():select(i)
      end, {})
    end
  end,
}
