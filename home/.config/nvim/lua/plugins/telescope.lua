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
				return vim.fn.executable("make") == 1
			end,
		},
	},

	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")

		local builtin = require("telescope.builtin")
		Base_opts = {
			scroll_strategy = "cycle",
		}

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
				Base_opts,
				layout_config = {
					prompt_position = "top",
					height = 0.5,
				},
			})
		end, { desc = "[S]earch [N]eovim files" })

		vim.keymap.set("n", "<leader>ss", function()
			builtin.find_files({
				cwd = "~/scripts",
				Base_opts,
				layout_config = {
					prompt_position = "top",
					height = 0.5,
				},
			})
		end, { desc = "[S]earch [S]cripts" })

		vim.keymap.set("n", "<leader><space>", function()
			builtin.oldfiles({
				Base_opts,
				layout_config = {
					prompt_position = "top",
				},
			})
		end, { desc = "[?] Find recently opened files" })
		vim.keymap.set("n", "<leader>gf", function()
			builtin.git_files({
				Base_opts,
				layout_config = {
					prompt_position = "top",
				},
			})
		end, { desc = "Search [G]it [F]iles" })
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				Base_opts,
				layout_config = {
					prompt_position = "top",
				},
			})
		end, { desc = "[S]earch [F]iles" })

		vim.keymap.set("n", "<leader>sh", function()
			builtin.help_tags({
				Base_opts,
				layout_config = {
					prompt_position = "top",
				},
			})
		end, { desc = "[S]earch [H]elp" })

		vim.keymap.set("n", "<leader>sw", function()
			builtin.grep_string({
				Base_opts,
				layout_config = {
					prompt_position = "top",
					height = 0.5,
				},
			})
		end, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>lg", function()
			builtin.live_grep({
				Base_opts,
				layout_config = {
					prompt_position = "top",
					height = 0.5,
				},
			})
		end, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>wk", function()
			builtin.keymaps({
				Base_opts,
				layout_config = {
					prompt_position = "top",
					height = 0.5,
				},
			})
		end, { desc = "List all available keybinds [W]hich [K]ey" })
		vim.keymap.set("n", "<leader>d", function()
			builtin.diagnostics({
				Base_opts,
				layout_config = {
					prompt_position = "top",
					height = 0.5,
				},
			})
		end, { desc = "[S]earch [D]iagnostics" })
	end,
}
