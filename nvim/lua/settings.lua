HOME = os.getenv('HOME')

-- Enable mouse
vim.o.mouse = 'a'

-- Number line
vim.o.number = true
vim.o.relativenumber = true

-- White characters
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Colorscheme
vim.cmd('colorscheme nightfox')

-- Plugin settings below

require('feline').setup()

require('nvim-tree').setup()

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg', 
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    }
  }
}

-- Use surround.vim keybinding for sandwich
vim.cmd('runtime macros/sandwich/keymap/surround.vim')
