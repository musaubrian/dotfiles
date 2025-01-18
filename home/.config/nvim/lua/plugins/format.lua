return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },

    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        vue = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        python = { "ruff" },
        go = { "goimports-reviser" },
        nix = {"alejandra"},
        -- blade = { "blade-formatter" },
        -- php = { "pint" },
      },
    },
  },
}
