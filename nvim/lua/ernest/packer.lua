vim.cmd [[packadd packer.nvim]]
	
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'rose-pine/neovim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'saadparwaiz1/cmp_luasnip'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'petertriho/nvim-scrollbar'
    use {
        'declancm/cinnamon.nvim',
        config = function() require('cinnamon').setup()
        end}
        use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
        use {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        }
        --	use 'nvim-tree/nvim-web-devicons'
        use 'wakatime/vim-wakatime'
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            -- or                            , branch = '0.1.x',
            requires = { {'nvim-lua/plenary.nvim'} }
        }
        use "mbbill/undotree"
        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            }
        }
    end)
