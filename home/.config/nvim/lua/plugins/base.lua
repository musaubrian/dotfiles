return {
	"tpope/vim-fugitive",
	"tjdevries/colorbuddy.nvim",
	"wakatime/vim-wakatime",
	"junegunn/vim-easy-align",
	"norcalli/nvim-colorizer.lua",
	"tpope/vim-sleuth",
	"musaubrian/scratch.nvim",
	{
		"musaubrian/jade.nvim",
		config = function()
			require("jade")
		end,
	},
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

-- local client = vim.lsp.start_client({
-- 	name = "envlsp",
-- 	cmd = { "/home/musaubrian/personal/lsp/env_lsp" },
-- 	-- cmd = { "/home/musaubrian/go/bin/env_lsp" },
-- })
--
-- if not client then
-- 	vim.notify("env_lsp not found")
-- 	return
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "go", "javascript" },
-- 	callback = function()
-- 		vim.lsp.buf_attach_client(0, client)
-- 	end,
-- })
