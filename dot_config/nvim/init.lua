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

vim.keymap.set("n", "K", require("lsp_hover").hover, { desc = "Show LSP hover" })

local function require_config(module)
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Could not load " .. module .. ": " .. err, vim.log.levels.ERROR)
  end
end

require_config("local")
require_config("cpp")
require_config("plugins")
