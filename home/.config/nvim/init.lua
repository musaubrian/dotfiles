--[[
                                  __       _
        __ _  __ _____ ___ ___ __/ /  ____(_)__ ____
       /  ' \/ // (_-</ _ `/ // / _ \/ __/ / _ `/ _ \
      /_/_/_/\_,_/___/\_,_/\_,_/_.__/_/ /_/\_,_/_//_/

Config taken from kickstart.nvim
https://github.com/nvim-lua/kickstart.nvim
]]


-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>Term<CR>", {})
vim.keymap.set("n", "<leader>ft", "<cmd>FTerm<CR>", {})
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", {})

-- Force me-self to use home row
vim.keymap.set('n', '<right>', function() vim.notify("Use l to move", vim.log.levels.WARN) end)
vim.keymap.set('n', '<left>', function() vim.notify("Use h to move", vim.log.levels.WARN) end)
vim.keymap.set('n', '<up>', function() vim.notify("Use k to move", vim.log.levels.WARN) end)
vim.keymap.set('n', '<down>', function() vim.notify("Use j to move", vim.log.levels.WARN) end)

-- No bg
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- [[ Setting options ]]
-- See `:help vim.o`
--
-- make cursor a block at all times
vim.opt.guicursor = ""
--move highlighted blocks
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.cmd.set("splitright") --splits always goto the right
vim.opt.inccommand = 'split'
-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
--disable swapfiles
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.incsearch = true
--lines visible below cursor is never less than 8
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
-- Make line numbers default
vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

vim.smartindent = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'
-- Enable break indent
-- vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
vim.o.ignorecase = false --Messed with the visual block find and replace
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 50
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

local me_group = vim.api.nvim_create_augroup('MeGroup', { clear = true })
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--[[Remove whitespaces at line ends]]
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
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
    vim.cmd("nnoremap <buffer> <C-c> i<C-c>")    -- Use Ctrl-c
    vim.cmd("nnoremap <buffer> <C-d> iexit<CR>") -- Use Ctrl-d to exit term
  end
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
  group = me_group,
  pattern = "*",
  callback = function()
    vim.cmd("leftabove")
  end
})




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
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = "*",
  group = me_group,
  callback = function()
    local snip_files = scandir(base_path)
    for _, file in pairs(snip_files) do
      local c = "so " .. base_path .. file
      vim.cmd(c)
    end
  end
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


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tjdevries/colorbuddy.nvim',
  -- wakatime
  'wakatime/vim-wakatime',
  'junegunn/vim-easy-align',
  'norcalli/nvim-colorizer.lua',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    'j-hui/fidget.nvim',
    event = "VeryLazy",
    opts = {}
  },

  { 'musaubrian/scratch.nvim', event = "VeryLazy" },

  {
    "musaubrian/jade.nvim",
    lazy = false,
    dependencies = "tjdevries/colorbuddy.nvim",
    config = function()
      require("jade")
    end
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "VeryLazy",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets" } })
        end
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  { -- trouble
    'folke/trouble.nvim',
    event = "VeryLazy",
    opts = {
      icons = false,
      fold_open = "v",      -- icon used for open folds
      fold_closed = ">",    -- icon used for closed folds
      indent_lines = false, -- add an indent guide below the fold icons
      signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client

      vim.keymap.set('n', '<leader>t', require('trouble').toggle, {}),
      vim.keymap.set('n', '<leader>tn', function()
        require('trouble').next({ jump = true, skip_groups = true })
      end, {}),
      vim.keymap.set('n', '<leader>tp', function()
          require('trouble').previous({ jump = true, skip_groups = true })
        end,
        {})
    }
  },
  {

    'mbbill/undotree',
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  },

  --[[ {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
      whitespace = { highlight = { "Whitespace", "NonText" } },
    }
  }, ]]

  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    opts = {}
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    }
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = "custom" },
})


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")

local base_opts = {
  scroll_strategy = "cycle",
}

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files {
    cwd = vim.fn.stdpath 'config',
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  }
end, { desc = '[S]earch [N]eovim files' })


vim.keymap.set('n', '<leader>ss', function()
  builtin.find_files {
    cwd = "~/scripts",
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  }
end, { desc = '[S]earch [S]cripts' })


vim.keymap.set('n', '<leader><space>',
  function()
    builtin.oldfiles {
      base_opts,
      layout_config = {
        prompt_position = "top",
      },
    }
  end
  , { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>gf',
  function()
    builtin.git_files {
      base_opts,
      layout_config = {
        prompt_position = "top",
      },
    }
  end
  , { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files {
      base_opts,
      layout_config = {
        prompt_position = "top",
      },
    }
  end,
  { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sh', function()
  builtin.help_tags {
    base_opts,
    layout_config = {
      prompt_position = "top",
    },
  }
end, { desc = '[S]earch [H]elp' })

vim.keymap.set('n', '<leader>sw', function()
    builtin.grep_string {
      base_opts,
      layout_config = {
        prompt_position = "top",
        height = 0.5,
      },
    }
  end,
  { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>lg',
  function()
    builtin.live_grep {
      base_opts,
      layout_config = {
        prompt_position = "top",
        height = 0.5,
      },
    }
  end
  , { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>wk', function()
  builtin.keymaps {
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  }
end, { desc = 'List all available keybinds [W]hich [K]ey' })
vim.keymap.set('n', '<leader>d', function()
  builtin.diagnostics {
    base_opts,
    layout_config = {
      prompt_position = "top",
      height = 0.5,
    },
  }
end
, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  sync_install = false,
  ignore_install = {},
  modules = {},
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'go', 'lua', 'python', 'vimdoc', 'javascript', 'typescript', 'bash', 'templ',
  },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

vim.diagnostic.config({
  virtual_text = true
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  --

  nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
  nmap('gr', function()
    require('telescope.builtin').lsp_references {
      base_opts,
      layout_config = {
        prompt_position = "top",
      },
    }
  end, '[G]o to [R]eference')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>rn', vim.lsp.buf.rename)
  nmap('<leader>ca', vim.lsp.buf.code_action)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  gopls = {},
  tsserver = {},
  templ = {},
  pylsp = {},
  marksman = {},
  -- html = { filetypes = { "html", }, },
  -- clangd = {},
  -- pyright = {},
  -- rust_analyzer = {},

  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          '$srd}/luv/library',
          unpack(vim.api.nvim_get_runtime_file('', true)),
        },
      },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup({})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

require("lspconfig").tailwindcss.setup({
  filetypes = {
    'templ'
    -- include any other filetypes where you need tailwindcss
  },
  init_options = {
    userLanguages = {
      templ = "html"
    }
  }
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-3),
    ['<C-f>'] = cmp.mapping.scroll_docs(3),
    ['<C-space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})


local client = vim.lsp.start_client {
  name = "envlsp",
  -- cmd = { "/home/musaubrian/personal/lsp/env_lsp" },
  cmd = { "/home/musaubrian/go/bin/env_lsp" },
}

if not client then
  vim.notify "LSP not found"
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "python" },
  callback = function()
    vim.lsp.buf_attach_client(0, client)
    print("LSP LOADED")
  end
})


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
