return {
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- python = { "ruff" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				vue = { "prettierd" },
			},
		},
	},
	"neovim/nvim-lspconfig",
	config = function()
		local format_is_enabled = true
		vim.api.nvim_create_user_command("FormatToggle", function()
			format_is_enabled = not format_is_enabled
			print("Setting autoformatting to: " .. tostring(format_is_enabled))
		end, {})

		local _augroups = {}
		local get_augroup = function(client)
			if not _augroups[client.id] then
				local group_name = "lsp-format-" .. client.name
				local id = vim.api.nvim_create_augroup(group_name, { clear = true })
				_augroups[client.id] = id
			end

			return _augroups[client.id]
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
			callback = function(args)
				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local bufnr = args.buf

				if not client.server_capabilities.documentFormattingProvider then
					return
				end

				vim.api.nvim_create_autocmd("BufWritePre", {
					group = get_augroup(client),
					buffer = bufnr,
					callback = function()
						if not format_is_enabled then
							return
						end
						require("conform").format({ async = true, lsp_fallback = true })
					end,
				})
			end,
		})
	end,
}
