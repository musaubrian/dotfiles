return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {

    signs = false,
    sign_priority = 8,
    keywords = {
      FIX = {
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "IMPORTANT" },
      },
      TODO = { color = "warning" },
      HACK = { color = "warning", alt = { "RE" } },
      WARN = { color = "warning", alt = { "WARNING", "XXX" } },
      NOTE = { color = "hint", alt = { "INFO" } },
    },
    gui_style = {
      fg = "NONE",
      bg = "NONE",
    },
    merge_keywords = true,

    highlight = {
      multiline = true,
      multiline_pattern = "^.",
      multiline_context = 10,
      before = "",
      keyword = "fg",
      after = "",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#CC6666" },
      warning = { "DiagnosticWarn", "WarningMsg", "#D7875F" },
      info = { "DiagnosticInfo", "#7BDAF7" },
      hint = { "DiagnosticHint", "#99CC99" },
      default = { "Identifier", "#8ABEC7" },
      test = { "Identifier", "#875F5F" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },

      pattern = [[\b(KEYWORDS):]],
    },
  },
}
