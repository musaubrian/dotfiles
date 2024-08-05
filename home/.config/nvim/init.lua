--[[
                                  __       _
        __ _  __ _____ ___ ___ __/ /  ____(_)__ ____
       /  ' \/ // (_-</ _ `/ // / _ \/ __/ / _ `/ _ \
      /_/_/_/\_,_/___/\_,_/\_,_/_.__/_/ /_/\_,_/_//_/

-- Config taken from kickstart.nvim
https://github.com/nvim-lua/kickstart.nvim
]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>Term<CR>", {})
vim.keymap.set("n", "<leader>st", "<cmd>vs | FTerm<CR>", {})
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Split size manipulation
vim.keymap.set("n", "<A-<>", "<Cmd>vertical resize +5<CR>", {})
vim.keymap.set("n", "<A->>", "<Cmd>vertical resize -5<CR>", {})
vim.keymap.set("n", "<A-l>", "<Cmd>resize +5<CR>", {})
vim.keymap.set("n", "<A-L>", "<Cmd>resize -5<CR>", {})
--move highlighted blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<right>", function()
	vim.notify("Use l to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<left>", function()
	vim.notify("Use h to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<up>", function()
	vim.notify("Use k to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<down>", function()
	vim.notify("Use j to move", vim.log.levels.WARN)
end)

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.opt.guicursor = ""
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.inccommand = "split"
vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.wo.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.smartindent = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.ignorecase = false --Messed with the visual block find and replace
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.o.updatetime = 50
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true

local me_group = vim.api.nvim_create_augroup("MeGroup", { clear = true })
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

-- [[ Highlight on yank ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--[[Remove whitespaces at line ends]]
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = me_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Make term more usable
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = me_group,
	pattern = "*",
	callback = function()
		vim.cmd.setlocal("norelativenumber")
		vim.cmd.setlocal("nonumber")
		vim.cmd.setlocal("norelativenumber")
		vim.cmd.setlocal("signcolumn=no")
		vim.cmd.setlocal("nocursorline")
		vim.cmd("startinsert")
		vim.cmd("nnoremap <buffer> <C-c> i<C-c>")
		vim.cmd("nnoremap <buffer> <C-d> iexit<CR>")
	end,
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
	group = me_group,
	pattern = "*",
	callback = function()
		-- reset splitbelow
		vim.opt.splitbelow = false
	end,
})

-- Open terminal in split view at the bottom
vim.api.nvim_create_user_command("Term", function()
	vim.cmd.setlocal("splitbelow")
	vim.cmd("split |term")
end, { desc = "Open terminal in split mode at the bottom" })

vim.api.nvim_create_user_command("FTerm", function()
	vim.cmd("term")
end, { desc = "Open terminal in full screen mode" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-fugitive",
	"tjdevries/colorbuddy.nvim",
	"wakatime/vim-wakatime",
	"junegunn/vim-easy-align",
	"norcalli/nvim-colorizer.lua",
	"tpope/vim-sleuth",
	"musaubrian/scratch.nvim",
	-- {
	-- 	"musaubrian/jade.nvim",
	-- 	lazy = false,
	-- 	dependencies = "tjdevries/colorbuddy.nvim",
	-- 	config = function()
	-- 		require("jade")
	-- 	end,
	-- },
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
		"folke/trouble.nvim",
		event = "VimEnter",
		opts = {
			icons = false,
			fold_open = "v",
			fold_closed = ">",
			indent_lines = false,
			signs = {
				error = "error",
				warning = "warn",
				hint = "hint",
				information = "info",
			},
			use_diagnostic_signs = false,
			auto_close = false,
		},
		config = function()
			vim.keymap.set("n", "<leader>t", require("trouble").toggle, {})
			-- Just use [d ]d
		end,
	},
	{
		"mbbill/undotree",
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle),
	},

	{
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
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	{ import = "custom" },
}, {
	change_detection = {
		notify = false,
	},
})

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

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.diagnostic.config({
	virtual_text = true,
})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
