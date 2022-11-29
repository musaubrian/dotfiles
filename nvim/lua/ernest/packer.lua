vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'lewis6991/gitsigns.nvim'
  use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- use 'ms-jpq/coq_nvim'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use { 'echasnovski/mini.nvim', branch = 'stable' }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'petertriho/nvim-scrollbar'
  use {
	  'declancm/cinnamon.nvim',
	  config = function() require('cinnamon').setup()
	  end}
      use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use {'neoclide/coc.nvim', branch ='release'}
	-- use 'LoricAndre/OneTerm.nvim'
	use 'nvim-tree/nvim-web-devicons'
	use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
	use "numToStr/FTerm.nvim"
	use 'wakatime/vim-wakatime'
	use 'prichrd/netrw.nvim'
	  
  end)
