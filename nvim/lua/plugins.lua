-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'EdenEast/nightfox.nvim'

  use 'feline-nvim/feline.nvim'

  use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = {'nvim-lua/plenary.nvim'}}

  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}

end)
