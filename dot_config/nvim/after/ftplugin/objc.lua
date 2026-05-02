vim.keymap.set("n", "K", require("lsp_hover").hover, {
  buffer = true,
  desc = "Show LSP hover",
})
