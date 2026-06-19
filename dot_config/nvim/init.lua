-- ~/.config/nvim/init.lua
-- Managed by chezmoi.

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Wrap at word boundaries and indent wrapped portions to match the source line.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Neovim creates stdpath("state")/undo automatically.
vim.opt.undofile = true

vim.opt.inccommand = "split"

-- Smart-case search: case-insensitive when the pattern is all lowercase,
-- case-sensitive as soon as it contains any uppercase character.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Use treesitter expressions for folding. Start with all folds open so files
-- don't open collapsed; close folds manually with zc/zM.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

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

local function display_line_motion(real_line, display_line)
  return function()
    return vim.v.count == 0 and display_line or real_line
  end
end

vim.keymap.set({ "n", "x" }, "j", display_line_motion("j", "gj"), {
  expr = true,
  desc = "Move down by display line unless a count is given",
})
vim.keymap.set({ "n", "x" }, "k", display_line_motion("k", "gk"), {
  expr = true,
  desc = "Move up by display line unless a count is given",
})
vim.keymap.set({ "n", "x" }, "<Down>", display_line_motion("<Down>", "gj"), {
  expr = true,
  desc = "Move down by display line unless a count is given",
})
vim.keymap.set({ "n", "x" }, "<Up>", display_line_motion("<Up>", "gk"), {
  expr = true,
  desc = "Move up by display line unless a count is given",
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

local function yank_path(modifier)
  return function()
    local path = vim.fn.expand("%:" .. modifier)
    if path == "" then
      vim.notify("Current buffer has no file path", vim.log.levels.WARN)
      return
    end

    vim.fn.setreg("+", path)
    vim.notify("Copied path: " .. path)
  end
end

vim.keymap.set("n", "<leader>yp", yank_path("p"), { desc = "Copy absolute file path" })
vim.keymap.set("n", "<leader>yr", yank_path("."), { desc = "Copy cwd-relative file path" })
vim.keymap.set("n", "<leader>yn", yank_path("t"), { desc = "Copy filename" })

require("plugins")
require("lsp")
require("cpp")
require("terraform")
require("python")
require("csharp")
require("typescript")
require("local")
