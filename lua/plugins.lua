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
  
  -- Collection of common configurations for the Nvim LSP client
  use 'neovim/nvim-lspconfig'
  -- Completion framework
  use 'hrsh7th/nvim-cmp'
  -- LSP completion source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'
  -- Snippet completion source for nvim-cmp
  use 'hrsh7th/cmp-vsnip'
  -- Other usefull completion sources
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  -- See hrsh7th's other plugins for more completion sources!
  -- To enable more of the features of rust-analyzer, such as inlay hints and more!
  use 'simrat39/rust-tools.nvim'
  -- Snippet engine
  use 'hrsh7th/vim-vsnip'
  
  -- C/C++ formatting
  use 'rhysd/vim-clang-format'

  if packer_bootstrap then
    require('packer').sync{}
  end
end)
