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
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
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
  vim.keymap.set("n", "<leader>fw", function()
    builtin.live_grep({ default_text = vim.fn.expand("<cword>") })
  end, { desc = "Live grep prefilled with word under cursor" })
  vim.keymap.set("x", "<leader>fw", function()
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
    builtin.live_grep({ default_text = table.concat(lines, " ") })
  end, { desc = "Live grep prefilled with visual selection" })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
  vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
  vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
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

-- Filetype icons for nvim-tree, statuslines, etc. Requires a Nerd Font
-- in the terminal to render correctly (see README "Nerd Font" section).
pcall(function()
  require("nvim-web-devicons").setup({
    default = true,
  })
end)

-- File explorer sidebar via nvim-tree.
pcall(function()
  require("nvim-tree").setup({
    view = {
      width = 32,
      side = "left",
      preserve_window_proportions = true,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      indent_markers = {
        enable = true,
      },
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
      custom = { "^.git$" },
    },
    git = {
      enable = true,
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
  })

  vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer sidebar" })
  vim.keymap.set("n", "<leader>fn", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal current file in explorer" })
end)

-- Statusline. The "tokyonight" lualine theme is maintained by the
-- tokyonight.nvim author and tracks whichever tokyonight style is active.
pcall(function()
  require("lualine").setup({
    options = {
      theme = "tokyonight",
      icons_enabled = true,
      globalstatus = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "|" },
      disabled_filetypes = {
        winbar = { "NvimTree", "help", "qf" },
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    winbar = {
      lualine_c = {
        { "filename", path = 1, file_status = true, newfile_status = true },
      },
    },
    inactive_winbar = {
      lualine_c = {
        { "filename", path = 1, file_status = true, newfile_status = true },
      },
    },
  })
end)

-- Mark added / changed / removed lines in the signcolumn, plus inline hunk
-- navigation with ]c / [c.
pcall(function()
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "|" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")

      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(gs.next_hunk)
        return "<Ignore>"
      end, { buffer = bufnr, expr = true, desc = "Next git hunk" })

      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(gs.prev_hunk)
        return "<Ignore>"
      end, { buffer = bufnr, expr = true, desc = "Previous git hunk" })
    end,
  })
end)

-- vim-fugitive shortcuts. <leader>g* is reserved for git operations.
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame current file" })
