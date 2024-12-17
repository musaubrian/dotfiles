-- Yoinked from teej's advent of neovim
--
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local config = require("telescope.config").values
local M = {}

local function fine_grep(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local parts = vim.split(prompt, "@@")
      local args = { "rg" }
      if parts[1] then
        table.insert(args, "-e")
        table.insert(args, parts[1])
      end
      if parts[2] then
        print(parts[2])
        table.insert(args, "-g")
        table.insert(args, "*" .. parts[2] .. "*")
      end

      return vim
        .iter({
          args,
          {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--ignore-file-case-insensitive",
          },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Fine grep",
      finder = finder,
      previewer = config.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end
M.setup = function(opts)
  vim.keymap.set("n", "<leader>fg", function()
    fine_grep { file_ignore_patterns = { "node_modules/*", "public/*", "vendor/*", "storage/*", "*-lock*", "*.lock" } }
  end, { desc = "[F]ine [G]rep" })
end
return M
