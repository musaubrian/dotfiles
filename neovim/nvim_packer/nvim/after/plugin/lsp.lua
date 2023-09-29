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
    local opts = { buffer = bufnr, remap = true }
    vim.keymap.set('n', '<leader>m', function() vim.lsp.buf.code_action() end, {})
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {})
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, {})
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {})
    vim.keymap.set("n", "<leader>af", function() vim.lsp.buf.format() end, {})

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
