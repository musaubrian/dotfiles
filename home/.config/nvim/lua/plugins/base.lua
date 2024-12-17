return {
  "tpope/vim-fugitive",
  "wakatime/vim-wakatime",
  "junegunn/vim-easy-align",
  "norcalli/nvim-colorizer.lua",
  "tpope/vim-sleuth",
  "mbbill/undotree",
  "musaubrian/scratch.nvim",
  -- {
  --   "musaubrian/jade.nvim",
  --   dependencies = "tjdevries/colorbuddy.nvim",
  --   lazy = false,
  --   opts = {},
  -- },
  {
    "musaubrian/pye.nvim",
    event = "BufEnter",
    opts = {
      base_venv = "~/personal/.base_venv",
    },
  },
  { "stevearc/dressing.nvim", event = "BufEnter", opts = {} },
  { "lewis6991/gitsigns.nvim", lazy = true, event = "BufEnter", opts = {} },
}
