-- Native Neovim LSP config for C++ using clangd.

local function root_dir()
  return vim.fs.root(0, {
    "compile_commands.json",
    ".clangd",
    ".git",
    "CMakeLists.txt",
  }) or vim.fn.getcwd()
end

local function shell_quote(value)
  return vim.fn.shellescape(value)
end

local function system_ok(args)
  local output = vim.fn.systemlist(args)
  if vim.v.shell_error ~= 0 then
    return nil, table.concat(output, "\n")
  end
  return output, nil
end

local function compiler_for_buffer()
  if vim.bo.filetype == "c" then
    return vim.g.c_compiler or "cc"
  end

  return vim.g.cpp_compiler or "c++"
end

local function build_flags_for_buffer()
  if vim.bo.filetype == "c" then
    return vim.b.c_build_flags or vim.g.c_build_flags or "-std=c17 -Wall -Wextra -g"
  end

  return vim.b.cpp_build_flags or vim.g.cpp_build_flags or "-std=c++20 -Wall -Wextra -g"
end

local compiler_include_cache = {}

local function include_language_for_buffer()
  if vim.bo.filetype == "c" then
    return "c"
  end

  return "c++"
end

local function compiler_include_dirs()
  local compiler = compiler_for_buffer()
  local language = include_language_for_buffer()
  local cache_key = compiler .. "\n" .. language

  if compiler_include_cache[cache_key] then
    return compiler_include_cache[cache_key]
  end

  if vim.fn.executable(compiler) == 0 then
    compiler_include_cache[cache_key] = {}
    return compiler_include_cache[cache_key]
  end

  local result = vim.system({
    compiler,
    "-E",
    "-x",
    language,
    "-",
    "-v",
  }, {
    stdin = "",
    text = true,
  }):wait()

  local output = table.concat({ result.stderr or "", result.stdout or "" }, "\n")
  local dirs = {}
  local in_search_list = false

  for line in output:gmatch("[^\r\n]+") do
    if line:find("#include <...> search starts here:", 1, true) then
      in_search_list = true
    elseif line:find("End of search list.", 1, true) then
      in_search_list = false
    elseif in_search_list then
      local dir = line:gsub("%s*%(framework directory%)%s*$", ""):match("^%s*(.-)%s*$")
      if dir and dir ~= "" and vim.fn.isdirectory(dir) == 1 then
        table.insert(dirs, dir)
      end
    end
  end

  compiler_include_cache[cache_key] = dirs
  return dirs
end

local function configure_include_path()
  vim.opt_local.path:append({ "." })

  for _, dir in ipairs(compiler_include_dirs()) do
    vim.opt_local.path:append({ dir })
  end
end

local function current_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Save the buffer before building", vim.log.levels.WARN)
    return nil
  end

  return file
end

local function tmux_pane_alive(pane)
  if not pane or pane == "" then
    return false
  end

  local output = vim.fn.systemlist({ "tmux", "display-message", "-p", "-t", pane, "#{pane_id}" })
  return vim.v.shell_error == 0 and output[1] == pane
end

local function tmux_runner_pane()
  if not vim.env.TMUX or vim.env.TMUX == "" then
    vim.notify("CppRun needs to be started from inside tmux", vim.log.levels.WARN)
    return nil
  end

  if tmux_pane_alive(vim.g.cpp_runner_tmux_pane) then
    return vim.g.cpp_runner_tmux_pane
  end

  local output, err = system_ok({
    "tmux",
    "split-window",
    "-d",
    "-v",
    "-l",
    "35%",
    "-c",
    "#{pane_current_path}",
    "-P",
    "-F",
    "#{pane_id}",
  })

  if not output then
    vim.notify("Could not create tmux runner pane: " .. err, vim.log.levels.ERROR)
    return nil
  end

  vim.g.cpp_runner_tmux_pane = output[1]
  return vim.g.cpp_runner_tmux_pane
end

local function build_run_command(file)
  local override = vim.b.cpp_run_command or vim.g.cpp_run_command
  if override and override ~= "" then
    return "clear; " .. override
  end

  local build_dir = vim.fs.joinpath(root_dir(), "build", "nvim-run")
  local executable = vim.fs.joinpath(build_dir, vim.fn.fnamemodify(file, ":t:r"))
  local run_args = vim.b.cpp_run_args or vim.g.cpp_run_args or ""

  if run_args ~= "" then
    run_args = " " .. run_args
  end

  return string.format(
    "clear; mkdir -p %s && %s %s %s -o %s && %s%s",
    shell_quote(build_dir),
    shell_quote(compiler_for_buffer()),
    build_flags_for_buffer(),
    shell_quote(file),
    shell_quote(executable),
    shell_quote(executable),
    run_args
  )
end

local function run_in_tmux_pane()
  local file = current_file()
  if not file then
    return
  end

  vim.cmd("write")

  local pane = tmux_runner_pane()
  if not pane then
    return
  end

  local command = build_run_command(file)
  system_ok({ "tmux", "send-keys", "-t", pane, "C-c" })
  system_ok({ "tmux", "send-keys", "-t", pane, command, "C-m" })
  vim.notify("Build and run sent to tmux pane " .. pane)
end

local function lsp_hover()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    vim.notify("No LSP client attached yet. Run :LspStatus or wait for clangd.", vim.log.levels.WARN)
    return
  end

  vim.lsp.buf.hover()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function()
    configure_include_path()

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

    vim.keymap.set("n", "K", lsp_hover, {
      buffer = true,
      desc = "Show LSP hover when clangd is attached",
    })

    vim.keymap.set("n", "<leader>cr", run_in_tmux_pane, {
      buffer = true,
      desc = "Build and run current C/C++ file in a tmux pane",
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
    vim.keymap.set("n", "K", lsp_hover, opts)
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

vim.api.nvim_create_user_command("CppRun", run_in_tmux_pane, {})

vim.api.nvim_create_user_command("CppIncludePath", function()
  print(table.concat(compiler_include_dirs(), "\n"))
end, {})
