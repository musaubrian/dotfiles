vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'wakatime/vim-wakatime'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'junegunn/vim-easy-align'
    -- use 'mattn/efm-langserver'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    use 'tpope/vim-fugitive'
    use 'tpope/vim-sleuth'
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end }
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'nvim-lualine/lualine.nvim'

    use "folke/trouble.nvim"
    use {
        'folke/neodev.nvim',
        config = function()
            require('neodev').setup()
        end
    }
    use {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            local opts = {
                panel = { enabled = false, },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 250,
                    keymap = {
                        accept = "<M-CR>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-n>",
                        prev = "<M-p>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 18.x
                server_opts_overrides = {},
            }
            require("copilot").setup(opts)
        end,
    }
    use {
        'musaubrian/scratch.nvim',
        requires = {
            { 'rcarriga/nvim-notify',
                -- If you already use nvim-notify You can remove this
                config = function()
                    require('notify').setup({
                        --You can remove this if you wish to use default icons
                        icons = {
                            DEBUG = 'DEBUG',
                            ERROR = 'ERROR',
                            INFO = 'INFO',
                            TRACE = 'TRACE',
                            WARN = 'WARN'
                        },
                        stages = 'static',
                        timeout = 2000,
                    })
                end
            }
        }
    }
    use "mbbill/undotree"
    use 'lukas-reineke/indent-blankline.nvim'
    use 'theprimeagen/harpoon'
end)
