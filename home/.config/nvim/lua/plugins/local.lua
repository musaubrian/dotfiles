return {
  {
    "minline.nvim",
    dir = "~/personal/minline.nvim/",
    opts = {},
    -- config = function()
    --   require("minline").setup()
    -- end,
  },
  -- {
  --   dir = "~/personal/pye.nvim",
  --   opts = {
  --     base_venv = "~/personal/.base_venv",
  --   },
  -- },
  {
    dir = "~/personal/jade.nvim",
    lazy = false,
    dependencies = "tjdevries/colorbuddy.nvim",
    opts = {},
  },
}
