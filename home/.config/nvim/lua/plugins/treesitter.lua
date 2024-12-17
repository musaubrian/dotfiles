return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",

  config = function()
    require("nvim-treesitter.configs").setup {
      sync_install = false,
      ignore_install = {},
      modules = {},
      ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "query" },
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
    }

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    ---@diagnostic disable-next-line: inject-field
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
        revision = "4ad4d56aca189bf4fa18b8896f9ed4a5e5ddf618",
      },
      filetype = "blade",
    }

    vim.filetype.add {
      pattern = {
        [".*%.blade%.php"] = "blade",
      },
    }
  end,
}
