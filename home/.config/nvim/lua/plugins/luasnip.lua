return {
  "L3MON4D3/LuaSnip",
  dependencies = "rafamadriz/friendly-snippets",

  version = "v2.*",
  build = "make install_jsregexp",

  config = function()
    local luasnip = require "luasnip"
    luasnip.config.setup {}

    require("luasnip.loaders.from_vscode").lazy_load()
    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
      loadfile(ft_path)()
    end
  end,
}
