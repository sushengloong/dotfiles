-- Native Neovim LSP config for C++ using clangd.

local function root_dir()
  return vim.fs.root(0, {
    "compile_commands.json",
    ".clangd",
    ".git",
    "CMakeLists.txt",
  }) or vim.fn.getcwd()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
      },
      root_dir = root_dir(),
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.keymap.set("n", "<leader>f", function()
      local ok = pcall(require, "conform")
      if ok then
        require("conform").format({ async = true })
      else
        vim.lsp.buf.format({ async = true })
      end
    end, opts)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  end,
})

vim.api.nvim_create_user_command("LspStatus", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if vim.tbl_isempty(clients) then
    print("No LSP clients attached to current buffer")
    return
  end

  for _, client in ipairs(clients) do
    print("LSP attached: " .. client.name)
  end
end, {})

