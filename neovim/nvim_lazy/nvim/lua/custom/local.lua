return {
  { "scratch", dir = "~/personal/scratch.nvim" },

  {
    'jade',
    dir = "~/personal/jade.nvim",
    priority = 1000,
    lazy = false,
    dependencies = "tjdevries/colorbuddy.nvim",
    config = function()
      require("jade")
    end
  },
}
