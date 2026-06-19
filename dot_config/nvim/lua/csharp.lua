-- Native Neovim LSP config for C# using roslyn.nvim.
-- Requires the Roslyn language server installed via Mason:
--   :MasonInstall roslyn

pcall(function()
  require("roslyn").setup()
end)
