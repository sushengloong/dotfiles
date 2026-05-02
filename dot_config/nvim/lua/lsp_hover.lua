local M = {}

function M.hover()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    vim.notify("No LSP client attached to current buffer", vim.log.levels.WARN)
    return
  end

  vim.lsp.buf.hover()
end

return M
