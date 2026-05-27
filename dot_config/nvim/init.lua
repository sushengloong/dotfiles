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
vim.opt.cursorline = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Smart-case search: case-insensitive when the pattern is all lowercase,
-- case-sensitive as soon as it contains any uppercase character.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable netrw so nvim-tree can take over file exploration cleanly.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- We don't use any RPC-based remote plugins, so silence the per-language
-- provider checks rather than installing the bindings we'd never call.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Move between split panes without the <C-w> prefix.
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus split to the left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus split above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus split to the right" })

require("plugins")
require("cpp")
require("local")
