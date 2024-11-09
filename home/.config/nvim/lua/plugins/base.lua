return {
  "tpope/vim-fugitive",
  "tjdevries/colorbuddy.nvim",
  "wakatime/vim-wakatime",
  "junegunn/vim-easy-align",
  "norcalli/nvim-colorizer.lua",
  "tpope/vim-sleuth",
  "mbbill/undotree",
  "musaubrian/scratch.nvim",
  { "echasnovski/mini.surround", version = "*", event = "VimEnter" },
  { "stevearc/dressing.nvim", opts = {} },
  {
    "musaubrian/jade.nvim",
    config = function()
      require "jade"
    end,
  },
  { "lewis6991/gitsigns.nvim", lazy = true, event = "VimEnter", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "folke/neodev.nvim",
    },
  },
}
