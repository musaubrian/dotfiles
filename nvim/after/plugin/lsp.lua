require("mason.settings").set({
    ui = {
        border = "rounded"
    }
})

local lsp = require('lsp-zero')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'gopls',
    'pyright'
})

lsp.on_attach(function(bufnr)
    local opts = {buffer = bufnr, remap = true}
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
