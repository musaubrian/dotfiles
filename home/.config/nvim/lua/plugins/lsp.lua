return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "williamboman/mason.nvim", config = true },
    { "j-hui/fidget.nvim", event = "BufEnter", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end

        nmap("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]o to [R]eference")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>gD", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        nmap("<leader>rn", vim.lsp.buf.rename)
        nmap("<leader>ca", vim.lsp.buf.code_action)
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      end,
    })

    require("lspconfig").lua_ls.setup {}
    require("lspconfig").gopls.setup {}
    require("lspconfig").pylsp.setup {}
    require("lspconfig").marksman.setup {}
    require("lspconfig").templ.setup {}
    require("lspconfig").phpactor.setup {}
    require("lspconfig").tailwindcss.setup {}
    require("lspconfig").rust_analyzer.setup {}
    require("lspconfig").ts_ls.setup {
      server_capabilities = {
        documentFormattingProvider = false,
      },
    }
  end,
}
--   volar = { init_options = { vue = { hybridMode = false, }, }, filetypes = { "typescript", "javascript", -- "javascriptreact", -- "typescriptreact", "vue", "json", }, },
