local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- nicer statusline + filebrowser + tab bar + icons
  use 'nvim-lualine/lualine.nvim'
  use 'preservim/nerdtree'
  -- use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- onedark colour scheme
  -- use 'joshdick/onedark.vim'
  use 'navarasu/onedark.nvim'

  -- HTML tag support
  use 'vim-scripts/HTML-AutoCloseTag'

  -- Bracket closer
  use 'windwp/nvim-autopairs'

  -- Toggle diagnostics
  use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

  -- Commenting
  use 'tpope/vim-commentary'

  -- Tmux navigation
  use 'christoomey/vim-tmux-navigator'

  -- Telescope (fuzzy finding)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  -- LSP shenanigans
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},                  -- Required
      {'hrsh7th/cmp-nvim-lsp'},              -- Required
      {'hrsh7th/cmp-path'},                  -- Optional
      {'hrsh7th/cmp-buffer'},                -- Optional
      {'L3MON4D3/LuaSnip'},                  -- Required
      {'rafamadriz/friendly-snippets'},      -- Optional
    }
  }

  -- Other usefull completion sources
  -- See hrsh7th's other plugins for more completion sources!
  -- To enable more of the features of rust-analyzer, such as inlay hints and more!
  use 'simrat39/rust-tools.nvim'

  -- C/C++ formatting
  use 'rhysd/vim-clang-format'

  if packer_bootstrap then
    require('packer').sync{}
  end
end)
