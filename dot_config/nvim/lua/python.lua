-- Native Neovim LSP config for Python via basedpyright (falls back to pyright).

local function root_dir()
  return vim.fs.root(0, { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" })
    or vim.fn.getcwd()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    local cmd
    if vim.fn.executable("basedpyright-langserver") == 1 then
      cmd = { "basedpyright-langserver", "--stdio" }
    elseif vim.fn.executable("pyright-langserver") == 1 then
      cmd = { "pyright-langserver", "--stdio" }
    else
      return
    end

    vim.lsp.start({
      name = cmd[1],
      cmd = cmd,
      root_dir = root_dir(),
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})
