return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },

		---@module "conform"
		---@type conform.setupOpts
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				vue = { "prettierd" },
				html = { "prettierd" },
				python = { "black" },
			},
		},
	},
}
