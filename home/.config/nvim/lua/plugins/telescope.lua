return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
  },

  config = function()
    require("telescope").setup {
      defaults = {
        scroll_strategy = "cycle",
        layout_config = {
          prompt_position = "top",
          height = 0.8,
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      extensions = {
        fzf = {},
      },
    }
    require("telescope").load_extension "fzf"
    require("plugins.telescope.fine_grep").setup()

    local builtin = require "telescope.builtin"
    local action = require "telescope.actions"

    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files {
        cwd = vim.fn.stdpath "config",
      }
    end, { desc = "[S]earch [N]eovim files" })

    vim.keymap.set("n", "<leader>ss", function()
      builtin.find_files {
        cwd = "~/scripts",
      }
    end, { desc = "[S]earch [S]cripts" })

    vim.keymap.set("n", "<leader><space>", builtin.oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })

    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })

    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>wk", builtin.keymaps, { desc = "List all available keybinds [W]hich [K]ey" })
    vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

    vim.keymap.set("n", "C-q", function()
      action.smart_send_to_qflist()
      vim.cmd "copen"
    end, { desc = "Send items to quick fix list" })
  end,
}
