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
vim.opt.scrolloff = 7

vim.opt.colorcolumn = "80"

vim.opt.updatetime = 50
