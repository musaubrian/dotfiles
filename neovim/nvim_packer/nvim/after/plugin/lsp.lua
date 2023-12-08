require("mason.settings").set({})

local lsp_zero = require('lsp-zero')
local capapilities = vim.lsp.protocol.make_client_capabilities()
capapilities = require("cmp_nvim_lsp").default_capabilities(capapilities)
local format_is_enabled = true

--- Check if a loaded lsp client matches a specific client
--- @param tab table
--- @param val string
--- @return boolean
local function is_lspclient(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end


lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>gl", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  local clients = {}
  for i = 1, 10 do --assumes there won't be more than 10 clients loaded
    clients[i] = client.name
  end
  -- tsserver freaks out when formatting
  local is_tsserver = is_lspclient(clients, "tsserver")
  if is_tsserver then
    format_is_enabled = false
  end

  if format_is_enabled and not is_tsserver then
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
  else
    return
  end
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'gopls', 'pyright' },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

vim.diagnostic.config({
  virtual_text = true
})
