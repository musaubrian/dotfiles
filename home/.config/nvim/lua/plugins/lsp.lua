return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "williamboman/mason.nvim", config = true },
    { "j-hui/fidget.nvim", event = "BufEnter", opts = {} },
    { "saghen/blink.cmp" },
  },
  opts = {
    servers = {
      lua_ls = {},
      gopls = {},
      pylsp = {},
      marksman = {},
      templ = {},
      phpactor = {},
      tailwindcss = {},
      rust_analyzer = {},
      nil_ls = {},
      ts_ls = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
      },
    },
  },

  config = function(_, opts)
    local lspconfig = require "lspconfig"
    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
--   volar = { init_options = { vue = { hybridMode = false, }, }, filetypes = { "typescript", "javascript", -- "javascriptreact", -- "typescriptreact", "vue", "json", }, },
