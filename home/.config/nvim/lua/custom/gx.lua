return {
	"chrishrb/gx.nvim",
	keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
	cmd = { "Browse" },
	init = function()
		vim.g.netrw_nogx = 1 -- disable netrw gx
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
	submodules = false,

	-- you can specify also another config if you want
	config = function()
		require("gx").setup {
			open_browser_app = "xdg-open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
			-- open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
			handlers = {
				plugin = true,
				github = true,
				brewfile = true,
				package_json = true,
				search = true,
				go = true,
				rust = {
					name = "rust", -- set name of handler
					filetype = { "toml" }, -- you can also set the required filetype for this handler
					filename = "Cargo.toml", -- or the necessary filename
					handle = function(mode, line, _)
						local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

						if crate then
							return "https://crates.io/crates/" .. crate
						end
					end,
				},
			},
			handler_options = {
				search_engine = "https://duckduckgo.com/?q=", -- or you can pass in a custom search engine
				select_for_search = false,
				-- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match.
				-- This disables this behaviour for default so that the link is opened without the select option for the word AND link

				git_remotes = { "upstream", "origin" }, -- list of git remotes to search for git issue linking, in priority
				-- git_remotes = function(fname)              -- you can also pass in a function
				-- 	if fname:match("myproject") then
				-- 		return { "mygit" }
				-- 	end
				-- 	return { "upstream", "origin" }
				-- end,

			},
		}
	end,
}
