return {
  "tjdevries/express_line.nvim",

  config = function()
    require("el").reset_windows()

    vim.opt.laststatus = 3

    local builtin = require "el.builtin"
    local extensions = require "el.extensions"
    local sections = require "el.sections"
    local subscribe = require "el.subscribe"




    local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
      local branch = extensions.git_branch(window, buffer)
      if branch then
        return " " .. branch
      end
    end)

    local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
      return extensions.git_changes(window, buffer)
    end)

    require("el").setup {
      generator = function(window, buffer)
        local mode = extensions.gen_mode { format_string = " %s " }

        local items = {
          { mode,                                                            required = true },
          { " " },
          { git_branch },
          { sections.split,                                                  required = true },
          { sections.maximum_width(builtin.file_relative, 0.60),             required = true },
          { sections.collapse_builtin { { " " }, { builtin.modified_flag } } },
          { sections.split,                                                  required = true },
          { git_changes },
          { " " },
          { "[" },
          { builtin.line_with_width(2) },
          { ":" },
          { builtin.column_with_width(2) },
          { "]" },
          { " " },
          {
            sections.collapse_builtin {
              "[",
              builtin.help_list,
              builtin.readonly_list,
              "]",
            },
          },
        }

        local add_item = function(result, item)
          table.insert(result, item)
        end

        local result = {}
        for _, item in ipairs(items) do
          add_item(result, item)
        end

        return result
      end,
    }
  end
}
