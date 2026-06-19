-- Native Neovim LSP config for TypeScript and JavaScript.

local node_root_markers = {
  "tsconfig.json",
  "jsconfig.json",
  "package.json",
  ".git",
}

local deno_root_markers = {
  "deno.json",
  "deno.jsonc",
}

local filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}

local function root_dir(markers)
  return vim.fs.root(0, markers) or vim.fn.getcwd()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    local deno_root = vim.fs.root(0, deno_root_markers)

    if deno_root and vim.fn.executable("deno") == 1 then
      vim.lsp.start({
        name = "denols",
        cmd = { "deno", "lsp" },
        root_dir = deno_root,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        settings = {
          deno = {
            enable = true,
            lint = true,
          },
        },
      })
      return
    end

    if vim.fn.executable("typescript-language-server") == 0 then
      return
    end

    vim.lsp.start({
      name = "typescript-language-server",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = root_dir(node_root_markers),
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      init_options = {
        hostInfo = "neovim",
      },
    })
  end,
})
