-- Tiny native plugin installation.
-- No lazy.nvim or plugin-manager framework; vim.pack handles plugins.

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

local function build_blink_cmp()
  local ok, blink = pcall(require, "blink.cmp")
  if not ok or type(blink.build) ~= "function" then
    return
  end

  local build_ok, task = pcall(blink.build)
  if not build_ok then
    vim.notify("blink.cmp build failed: " .. task, vim.log.levels.WARN)
    return
  end

  if type(task) ~= "table" or type(task.wait) ~= "function" then
    return
  end

  local wait_ok, err = pcall(task.wait, task, 60000)
  if not wait_ok then
    vim.notify("blink.cmp build failed: " .. err, vim.log.levels.WARN)
  end
end

if vim.pack then
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
      if event.data.spec.name == "telescope-fzf-native.nvim" then
        build_fzf_native(event.data.path)
      elseif event.data.spec.name == "blink.cmp" then
        build_blink_cmp()
      end
    end,
  })

  vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    {
      src = "https://github.com/kylechui/nvim-surround",
      version = vim.version.range("4.x"),
    },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/nickkadutskyi/jb.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/tpope/vim-fugitive" },
    -- GitHub handler for fugitive's :GBrowse command.
    { src = "https://github.com/tpope/vim-rhubarb" },
    { src = "https://github.com/tpope/vim-dadbod" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/seblyng/roslyn.nvim" },
  }, {
    confirm = false,
  })

  build_fzf_native(plugin_path("telescope-fzf-native.nvim"))
  build_blink_cmp()
end

pcall(function()
  require("jb").setup()
  vim.cmd.colorscheme("jb")
end)

-- nvim-treesitter's main branch installs parsers; Neovim core provides
-- highlighting and folding. install() is a no-op when a parser is current.
pcall(function()
  local ts = require("nvim-treesitter")
  ts.setup()

  local parsers = {
    "c",
    "cpp",
    "lua",
    "cmake",
    "terraform",
    "hcl",
    "json",
    "javascript",
    "markdown",
    "markdown_inline",
    "xml",
    "yaml",
    "python",
    "typescript",
    "tsx",
    "c_sharp",
    "sql",
  }
  ts.install(parsers)

  vim.treesitter.language.register("sql", { "mysql", "plsql" })

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(event)
      pcall(vim.treesitter.start, event.buf)
    end,
  })
end)

pcall(function()
  local render_markdown = require("render-markdown")
  render_markdown.setup({})

  vim.keymap.set("n", "<leader>mr", render_markdown.buf_toggle, {
    desc = "Toggle Markdown rendering for buffer",
  })
end)

pcall(function()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")

  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!.git/*",
        "--glob",
        "!build/*",
      },
      file_ignore_patterns = {
        "^%.git/",
        "^build/",
      },
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close,
        },
      },
      -- Put the selected result directly below the prompt.
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.5,
          height = 0.45,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--no-ignore-vcs",
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

-- Telescope normally highlights fuzzy matches on every result row. Keep those
-- marks only on the active row and raise them above the selection highlight.
pcall(function()
  local Picker = require("telescope.pickers")._Picker
  if Picker._dotfiles_scoped_matching then
    return
  end

  local ns_matching = vim.api.nvim_create_namespace("telescope_matching")
  local original_set_selection = Picker.set_selection

  function Picker:set_selection(row)
    local bufnr = self.results_bufnr
    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_clear_namespace(bufnr, ns_matching, 0, -1)
    end

    local result = original_set_selection(self, row)

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
      local selected_row = self:get_selection_row()
      local marks = vim.api.nvim_buf_get_extmarks(
        bufnr,
        ns_matching,
        { selected_row, 0 },
        { selected_row, -1 },
        { details = true }
      )

      if #marks > 0 then
        vim.api.nvim_buf_clear_namespace(bufnr, ns_matching, selected_row, selected_row + 1)
        for _, mark in ipairs(marks) do
          vim.api.nvim_buf_set_extmark(bufnr, ns_matching, mark[2], mark[3], {
            end_col = mark[4].end_col,
            hl_group = mark[4].hl_group,
            priority = 5000,
          })
        end
      end
    end

    return result
  end

  Picker._dotfiles_scoped_matching = true
end)

-- conform.nvim is optional; clangd can format too.
pcall(function()
  require("conform").setup({
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      json = { "jq" },
      xml = { "xmllint" },
    },
  })
end)

pcall(function()
  require("blink.cmp").setup({
    keymap = {
      preset = "super-tab",
    },
    completion = {
      menu = {
        border = "rounded",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "dadbod", "buffer" },
        mysql = { "dadbod", "buffer" },
        plsql = { "dadbod", "buffer" },
      },
      providers = {
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
      },
    },
    -- The built-in matcher only requested completion on server trigger
    -- characters, which made completion feel late and inconsistent.
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    signature = {
      enabled = true,
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

-- Statusline.
pcall(function()
  require("lualine").setup({
    options = {
      theme = "auto",
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

-- Database connection strings belong in local.lua via vim.g.dbs so credentials
-- never enter the repository.
vim.g.db_ui_use_nerd_fonts = 1
vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle database UI" })
vim.keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", { desc = "Find database buffer" })

-- Mason package manager. Used to install the Roslyn language server for C#.
-- After setup, run :MasonInstall roslyn to install it.
pcall(function()
  require("mason").setup({
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
  })
end)

-- vim-fugitive shortcuts. <leader>g* is reserved for git operations.
vim.keymap.set("n", "<leader>gb", function()
  for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(window)].filetype == "fugitiveblame" then
      vim.api.nvim_win_close(window, false)
      return
    end
  end

  vim.cmd("Git blame")
end, { desc = "Toggle git blame for current file" })
vim.keymap.set("n", "<leader>go", "<cmd>GBrowse<CR>", { desc = "Open current line on git remote" })
vim.keymap.set("x", "<leader>go", ":GBrowse<CR>", { desc = "Open selection on git remote" })
