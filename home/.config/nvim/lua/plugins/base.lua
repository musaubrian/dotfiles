return {
	"tpope/vim-fugitive",
	"tjdevries/colorbuddy.nvim",
	"wakatime/vim-wakatime",
	"junegunn/vim-easy-align",
	"norcalli/nvim-colorizer.lua",
	"tpope/vim-sleuth",
	"musaubrian/scratch.nvim",
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/neodev.nvim",
		},
	},
	{
		"mbbill/undotree",
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle),
	},
}
