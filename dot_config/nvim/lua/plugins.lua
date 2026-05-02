-- Tiny native plugin installation.
-- No lazy.nvim, no Mason, no framework.

if vim.pack then
  vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/stevearc/conform.nvim" },
  })
end

-- Treesitter is optional but useful for C++ highlighting.
pcall(function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "cmake" },
    highlight = { enable = true },
  })
end)

-- conform.nvim is optional; clangd can format too.
pcall(function()
  require("conform").setup({
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
  })
end)

