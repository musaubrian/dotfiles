--[[
                                  __       _
        __ _  __ _____ ___ ___ __/ /  ____(_)__ ____
       /  ' \/ // (_-</ _ `/ // / _ \/ __/ / _ `/ _ \
      /_/_/_/\_,_/___/\_,_/\_,_/_.__/_/ /_/\_,_/_//_/

-- Config taken from kickstart.nvim
https://github.com/nvim-lua/kickstart.nvim
]]

require("custom.user")
require("custom.opts")
require("custom.keys")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

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

require("lazy").setup({ { import = "plugins" } }, {
	change_detection = {
		notify = false,
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
