return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			sync_install = false,
			ignore_install = {},
			modules = {},
			ensure_installed = {
				"go",
				"lua",
				"python",
				"vimdoc",
				"luadoc",
				"javascript",
				"typescript",
				"bash",
				"templ",
			},
			auto_install = false,
			highlight = { enable = true },
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
		})
	end,
}
