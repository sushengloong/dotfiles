-- ~/.config/nvim/init.lua
-- Managed by chezmoi.

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("plugins")
require("cpp")
require("local")

