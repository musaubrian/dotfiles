vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

vim.smartindent = true
vim.opt.cursorline = true
vim.opt.wrap = false

--disable swapfiles
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

--remove highlight while searching
vim.opt.hlsearch = false

--incremental search
vim.opt.incsearch = true

vim.opt.termguicolors = true

--lines visible below cursor is never less than
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "79"

vim.opt.updatetime = 50
vim.o.clipboard = "unnamedplus"
vim.wo.signcolumn = "yes"
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

