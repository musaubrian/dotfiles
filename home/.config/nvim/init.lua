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
vim.keymap.set("n", "<leader>ft", "<cmd>FTerm<CR>", {})
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Split size manipulation
vim.keymap.set('n', '<A-<>', '<Cmd>vertical resize +5<CR>', {})
vim.keymap.set('n', '<A->>', '<Cmd>vertical resize -5<CR>', {})
vim.keymap.set('n', '<A-l>', '<Cmd>resize +5<CR>', {})
vim.keymap.set('n', '<A-L>', '<Cmd>resize -5<CR>', {})
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
---
---@param directory string
local function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  if pfile == nil then
    return {}
  end
  for filename in pfile:lines() do
    if filename:match("%.lua$") then -- Check if filename ends with .lua
      i = i + 1
      t[i] = filename
    end
  end
  pfile:close()
  return t
end

local base_path = os.getenv("HOME") .. "/.config/nvim/snippets/"

-- -- There's probably an easier way to do this.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = me_group,
  callback = function()
    local snip_files = scandir(base_path)
    for _, file in pairs(snip_files) do
      local c = "so " .. base_path .. file
      vim.cmd(c)
    end
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
-------------------------------------------

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
  {
    "musaubrian/jade.nvim",
    lazy = false,
    dependencies = "tjdevries/colorbuddy.nvim",
    config = function()
      require("jade")
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets" } })
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
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

      vim.keymap.set("n", "<leader>t", require("trouble").toggle, {}),
      vim.keymap.set("n", "<leader>tn", function()
        require("trouble").next({ jump = true, skip_groups = true })
      end, {}),
      vim.keymap.set("n", "<leader>tp", function()
        require("trouble").previous({ jump = true, skip_groups = true })
      end, {}),
    },
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
    notify = false }
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
local base_opts = {
  scroll_strategy = "cycle",
}

vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  })
end, { desc = "[S]earch [N]eovim files" })

vim.keymap.set("n", "<leader>ss", function()
  builtin.find_files({
    cwd = "~/scripts",
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  })
end, { desc = "[S]earch [S]cripts" })

vim.keymap.set("n", "<leader><space>", function()
  builtin.oldfiles({
    base_opts,
    layout_config = {
      prompt_position = "top",
    },
  })
end, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>gf", function()
  builtin.git_files({
    base_opts,
    layout_config = {
      prompt_position = "top",
    },
  })
end, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    base_opts,
    layout_config = {
      prompt_position = "top",
    },
  })
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>sh", function()
  builtin.help_tags({
    base_opts,
    layout_config = {
      prompt_position = "top",
    },
  })
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>sw", function()
  builtin.grep_string({
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  })
end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>lg", function()
  builtin.live_grep({
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  })
end, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>wk", function()
  builtin.keymaps({
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  })
end, { desc = "List all available keybinds [W]hich [K]ey" })
vim.keymap.set("n", "<leader>d", function()
  builtin.diagnostics({
    base_opts,
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

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
  nmap("gr", function()
    require("telescope.builtin").lsp_references({
      base_opts,
      layout_config = {
        prompt_position = "top",
      },
    })
  end, "[G]o to [R]eference")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  nmap("<leader>rn", vim.lsp.buf.rename)
  nmap("<leader>ca", vim.lsp.buf.code_action)
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")

  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })
end


local servers = {
  gopls = {},
  tsserver = {},
  templ = {},
  pylsp = {},
  marksman = {},
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          "$srd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      telemetry = { enable = false },
    },
  },
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("neodev").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})
local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

lspconfig.volar.setup({
  init_options = {
    vue = {
      hybridMode = false
    },
  },
})

lspconfig.tailwindcss.setup({
  filetypes = {
    "templ",
  },
  init_options = {
    userLanguages = {
      templ = "html",
    },
  },
})



local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = "menu,menuone,noinsert" },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-3),
    ["<C-f>"] = cmp.mapping.scroll_docs(3),
    ["<C-space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "vim-dadbod-completion" },
  },

})

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

local client = vim.lsp.start_client({
  name = "envlsp",
  cmd = { "/home/musaubrian/personal/lsp/env_lsp" },
  -- cmd = { "/home/musaubrian/go/bin/env_lsp" },
})

if not client then
  vim.notify("env_lsp not found")
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "javascript" },
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
