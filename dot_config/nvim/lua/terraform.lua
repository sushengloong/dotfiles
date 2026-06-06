-- Native Neovim LSP config for Terraform and HCL using terraform-ls.

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "terraform", "terraform-vars", "hcl" },
  callback = function()
    if vim.fn.executable("terraform-ls") == 0 then
      return
    end

    vim.lsp.start({
      name = "terraform-ls",
      cmd = { "terraform-ls", "serve" },
      root_dir = vim.fs.root(0, {
        ".terraform",
        ".terraform.lock.hcl",
        ".git",
      }) or vim.fn.getcwd(),
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})
