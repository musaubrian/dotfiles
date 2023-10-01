vim.opt.list = true

require("ibl").setup {
      space_char_blankline = " ",
      show_trailing_blankline_indent = false,
     --indent = { char = "┊" },
     indent = {char = "▏"},
     whitespace = { highlight = { "Whitespace", "NonText" } },
}
