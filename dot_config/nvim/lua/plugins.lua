-- Tiny native plugin installation.
-- No lazy.nvim, no Mason, no framework.

local function plugin_path(name)
  for _, plugin in ipairs(vim.pack.get({ name }, { info = false })) do
    return plugin.path
  end

  return nil
end

local function build_fzf_native(path)
  if not path then
    return
  end

  if #vim.fn.glob(vim.fs.joinpath(path, "build", "libfzf.*"), false, true) > 0 then
    return
  end

  if vim.fn.executable("make") == 0 then
    vim.notify("Install make to build telescope-fzf-native.nvim", vim.log.levels.WARN)
    return
  end

  local result = vim.system({ "make" }, { cwd = path, text = true }):wait()
  if result.code ~= 0 then
    local message = result.stderr ~= "" and result.stderr or result.stdout
    vim.notify("telescope-fzf-native build failed: " .. message, vim.log.levels.WARN)
  end
end

if vim.pack then
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
      if event.data.spec.name == "telescope-fzf-native.nvim" then
        build_fzf_native(event.data.path)
      end
    end,
  })

  vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },
  }, {
    confirm = false,
  })

  build_fzf_native(plugin_path("telescope-fzf-native.nvim"))
end

pcall(function()
  require("tokyonight").setup({
    style = "night",
    terminal_colors = true,
    cache = true,
    styles = {
      comments = {},
      keywords = {},
      functions = {},
      variables = {},
    },
    on_colors = function(colors)
      colors.fg = "#d8e2ff"
      colors.fg_dark = "#c8d3f5"
      colors.comment = "#8a98bf"
    end,
    on_highlights = function(highlights, colors)
      highlights.Normal = { fg = colors.fg, bg = colors.bg }
      highlights.LineNr = { fg = "#6f7fa8" }
      highlights.CursorLineNr = { fg = "#ffcc66", bold = true }
      highlights.SignColumn = { fg = "#7f8db3", bg = colors.bg }
      highlights.FoldColumn = { fg = "#7f8db3", bg = colors.bg }
      highlights.Comment = { fg = colors.comment }
      highlights.NonText = { fg = "#5f6f99" }
      highlights.SpecialKey = { fg = "#6f7fa8" }
      highlights.DiagnosticVirtualTextError = { fg = "#ff8f8f" }
      highlights.DiagnosticVirtualTextWarn = { fg = "#ffd580" }
      highlights.DiagnosticVirtualTextInfo = { fg = "#9ad8ff" }
      highlights.DiagnosticVirtualTextHint = { fg = "#b8f0c2" }
    end,
    plugins = {
      all = true,
    },
  })

  vim.cmd.colorscheme("tokyonight")
end)

-- Treesitter is optional but useful for C++ highlighting.
pcall(function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "cmake" },
    highlight = { enable = true },
  })
end)

pcall(function()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")

  telescope.setup({
    defaults = {
      file_ignore_patterns = {
        "%.git/",
        "build/",
      },
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--glob",
          "!.git/*",
          "--glob",
          "!build/*",
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  pcall(telescope.load_extension, "fzf")

  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
  vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
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
