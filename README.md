# Dotfiles

This is a [chezmoi](https://www.chezmoi.io/) source repository for personal dotfiles.

At the moment it manages:

- `dot_config/nvim/init.lua` -> `~/.config/nvim/init.lua`
- `dot_config/nvim/lua/plugins.lua` -> `~/.config/nvim/lua/plugins.lua`
- `dot_config/nvim/lua/lsp.lua` -> `~/.config/nvim/lua/lsp.lua`
- `dot_config/nvim/lua/cpp.lua` -> `~/.config/nvim/lua/cpp.lua`
- `dot_config/nvim/lua/terraform.lua` -> `~/.config/nvim/lua/terraform.lua`
- `dot_config/nvim/lua/python.lua` -> `~/.config/nvim/lua/python.lua`
- `dot_config/nvim/lua/csharp.lua` -> `~/.config/nvim/lua/csharp.lua`
- `dot_config/nvim/lua/typescript.lua` -> `~/.config/nvim/lua/typescript.lua`
- `dot_config/nvim/lua/local.lua.tmpl` -> `~/.config/nvim/lua/local.lua`
- `dot_config/nvim/nvim-pack-lock.json` -> `~/.config/nvim/nvim-pack-lock.json`
- `dot_tmux.conf` -> `~/.tmux.conf`

The `local.lua.tmpl` file is rendered by chezmoi and sets a platform-specific
C++ compiler value. It is also the place for host-local database connection
settings through `vim.g.dbs`.

## Prerequisites

Install the core tools before applying the dotfiles:

```sh
brew install chezmoi neovim tmux git
```

For the C++ Neovim setup, install `clangd` and `clang-format` so LSP and formatting work:

```sh
brew install llvm clang-format
```

For Telescope search performance, install `ripgrep`. It is used for live grep and fast file discovery:

```sh
brew install ripgrep
```

For Terraform and HCL LSP support, install `terraform-ls`:

```sh
brew install terraform-ls
```

For Python go-to-definition, diagnostics, and completion, install the `basedpyright` language server (plain `pyright` also works):

```sh
brew install basedpyright
```

For TypeScript and JavaScript go-to-definition, diagnostics, and completion, install Node.js plus the TypeScript language server:

```sh
brew install node
npm install -g typescript typescript-language-server
```

Deno projects with a `deno.json` or `deno.jsonc` use `deno lsp` when `deno` is installed.

For C# go-to-definition, diagnostics, and completion, install the Roslyn language server via Mason inside Neovim:

```vim
:MasonInstall roslyn
```

The Roslyn server requires the .NET 10 runtime to run regardless of what your project targets. Install it via Homebrew:

```sh
brew install --cask dotnet
```

The cask installs to `/usr/local/share/dotnet`, but if your existing .NET SDK lives in `~/.dotnet`, copy the .NET 10 runtime into that directory so both versions coexist under the same `DOTNET_ROOT`:

```sh
cp -r /usr/local/share/dotnet/shared/Microsoft.NETCore.App/10.0.9 ~/.dotnet/shared/Microsoft.NETCore.App/
cp -r /usr/local/share/dotnet/host/fxr/10.0.9 ~/.dotnet/host/fxr/
```

Verify both runtimes are visible:

```sh
dotnet --list-runtimes
```

JSON formatting uses `jq`, and XML formatting uses `xmllint`:

```sh
brew install jq libxml2
```

### Nerd Font

Install and select a Nerd Font in your terminal if you want file icons in nvim-tree and the statusline:

```sh
brew install --cask font-meslo-lg-nerd-font
```

The native Telescope sorter also needs `make` and a C compiler. On macOS, install the Xcode Command Line Tools if those are missing:

```sh
xcode-select --install
```

nvim-treesitter uses the `tree-sitter` CLI to build language parsers:

```sh
brew install tree-sitter-cli
```

blink.cmp can build its native fuzzy matcher when `cargo` and `rustup` are
available. Without Rust it falls back to the Lua matcher and warns once:

```sh
brew install rustup
rustup-init
```

On non-macOS systems, use the equivalent package manager packages for
`chezmoi`, `neovim`, `tmux`, `git`, `clangd`, `clang-format`, `terraform-ls`,
`tree-sitter-cli`, `ripgrep`, `node`, `npm`, `typescript`, `typescript-language-server`,
`dotnet`, `jq`, `xmllint`, `make`, and a C compiler.

## First-Time Setup

Initialize chezmoi from this repository:

```sh
chezmoi init git@github.com:sushengloong/dotfiles.git
```

Review the changes before writing anything into `$HOME`:

```sh
chezmoi diff
```

Apply the dotfiles:

```sh
chezmoi apply
```

Or initialize and apply in one command:

```sh
chezmoi init --apply git@github.com:sushengloong/dotfiles.git
```

## Daily Workflow

Check what chezmoi would change:

```sh
chezmoi status
chezmoi diff
```

Apply pending changes:

```sh
chezmoi apply
```

Edit a managed file through chezmoi:

```sh
chezmoi edit ~/.config/nvim/init.lua
chezmoi diff
chezmoi apply
```

Add or refresh a file from `$HOME` into the source repository:

```sh
chezmoi add ~/.config/nvim/init.lua
chezmoi add ~/.config/nvim/lua/cpp.lua
```

Update from the remote repository and apply changes:

```sh
chezmoi update
```

Open the chezmoi source repository:

```sh
cd "$(chezmoi source-path)"
git status
```

## Neovim Notes

This configuration uses Neovim's native Lua config, avoids plugin manager frameworks such as lazy.nvim, and installs plugins through `vim.pack`.

Optional plugins are installed with `vim.pack` when that API is available:

- `nvim-treesitter/nvim-treesitter`
- `stevearc/conform.nvim`
- `saghen/blink.lib`
- `saghen/blink.cmp`
- `nvim-lua/plenary.nvim`
- `nvim-telescope/telescope.nvim`
- `nvim-telescope/telescope-fzf-native.nvim`
- `nickkadutskyi/jb.nvim`
- `nvim-tree/nvim-web-devicons`
- `nvim-tree/nvim-tree.lua`
- `tpope/vim-fugitive`
- `tpope/vim-rhubarb`
- `tpope/vim-dadbod`
- `kristijanhusak/vim-dadbod-ui`
- `kristijanhusak/vim-dadbod-completion`
- `lewis6991/gitsigns.nvim`
- `nvim-lualine/lualine.nvim`
- `williamboman/mason.nvim`
- `seblyng/roslyn.nvim`

Telescope uses `telescope-fzf-native.nvim` as its sorter because it is implemented in C and is materially faster than the default Lua sorter on larger lists. The config builds it with `make` after install or update when the compiled library is missing.

Telescope file search and live grep include hidden files while excluding
`.git/` and `build/`. Its prompt appears above the results, with the best match
first and the preview on the right. Fuzzy-match highlighting is limited to the
selected result row.

blink.cmp provides completion with Super-Tab navigation, a rounded menu,
automatically displayed documentation, LSP signatures, and LSP, path, snippet,
and buffer sources. SQL-family buffers also receive vim-dadbod completion. Its
optional Rust fuzzy matcher is built after plugin installation or update.

The active colorscheme is `jb`.

Editor defaults include soft wrapping at word boundaries, persistent undo
history, split live-substitute previews, visible-line movement with `j`/`k`,
search-highlight clearing with `<Esc>`, and brief highlighting after a yank.
Buffers with an installed Tree-sitter parser use native expression folding and
open fully expanded. Use `za` to toggle the fold under the cursor, `zc`/`zo` to
close/open it, `zM`/`zR` to close/open all folds, and `zT` to toggle all folds.

The C++ configuration starts `clangd` for C, C++, Objective-C, Objective-C++, and CUDA buffers. Project roots are detected from:

- `compile_commands.json`
- `.clangd`
- `.git`
- `CMakeLists.txt`

The Terraform configuration starts `terraform-ls serve` for Terraform,
Terraform variables, and HCL buffers when the executable is installed.
Project roots are detected from `.terraform`, `.terraform.lock.hcl`, or `.git`.

For Python buffers, `basedpyright` (or `pyright` if that is what is installed) attaches automatically and provides hover, go-to-definition, references, and completion. Project roots are detected from `pyproject.toml`, `setup.py`, `setup.cfg`, `requirements.txt`, or `.git`.

For TypeScript, TSX, JavaScript, and JSX buffers, `typescript-language-server` attaches automatically and provides hover, go-to-definition, references, diagnostics, and completion. Project roots are detected from `tsconfig.json`, `jsconfig.json`, `package.json`, or `.git`. Deno projects use `deno lsp` instead when `deno.json` or `deno.jsonc` is present.

For C# buffers, `roslyn.nvim` attaches to the Mason-installed Roslyn language server when it is available.

Useful Neovim commands and keymaps:

```text
:LspStatus     Show attached LSP clients for the current buffer
<Esc>          Clear search highlighting
j / k          Move by visible line, or real line when given a count
gd             Go to definition
gD             Go to declaration
gr             List references
gi             Go to implementation
K              Show hover documentation
<leader>rn     Rename symbol
<leader>ca     Code action
<leader>e      Show diagnostics
[d / ]d        Previous / next diagnostic
<leader>cf     Format buffer with conform or LSP fallback
<leader>ff     Find files
<leader>fg     Live grep
<leader>fw     Live grep for word under cursor or visual selection
<leader>fb     Find buffers
<leader>fh     Find help
<leader>fr     Find recent files
<leader>fd     Find diagnostics
<leader>fk     Find keymaps
<leader>n      Toggle nvim-tree
<leader>fn     Reveal current file in nvim-tree
]c / [c        Next / previous git hunk
<leader>gb     Toggle git blame for the current file
<leader>go     Open current line or visual selection on the git remote
<leader>yp     Copy the current file's absolute path
<leader>yr     Copy the current file's cwd-relative path
<leader>yn     Copy the current filename
<leader>db     Toggle the database UI
<leader>df     Find the current database buffer in the database UI
<leader>cr     Build and run the current C/C++ file in a tmux pane
:CppRun        Build and run the current C/C++ file in a tmux pane
:CppIncludePath Show compiler include directories used for gf
```

`<leader>cr` and `:CppRun` create or reuse a tmux pane below Neovim, compile the current file, and run the binary without moving focus out of Neovim. By default, the binary is written under `build/nvim-run/` in the detected project root.

For C/C++ buffers, `gf` uses include directories discovered from the active compiler, so standard headers like `vector` and `iostream` can be opened without hardcoded system paths.

The default C++ build command is equivalent to:

```sh
clang++ -std=c++20 -Wall -Wextra -g current_file.cpp -o build/nvim-run/current_file
```

Override the command in `dot_config/nvim/lua/local.lua.tmpl` if a project should use CMake or a custom binary name:

```lua
vim.g.cpp_run_command = "cmake --build build && ./build/my_program"
```

### Database (vim-dadbod)

The database UI is installed without repository credentials. Define named
connections in the rendered `local.lua` through `vim.g.dbs`, for example:

```lua
vim.g.dbs = {
  local_postgres = os.getenv("DATABASE_URL"),
}
```

`<leader>db` toggles the database UI and `<leader>df` reveals the database
buffer associated with the current query.

## Tmux Notes

The tmux config is tuned for Neovim sessions:

- prefix remapped from `Ctrl-b` to `Ctrl-a`
- `tmux-256color` with true color enabled for common terminal types
- extended key handling for terminal Neovim
- focus events for Neovim autocmds
- low escape timeout for modal editing
- mouse support and vi copy mode
- large scrollback for build and test output
- new panes and windows inherit the current project directory
- automatic window names show the foreground command or current directory
- pane movement with `Ctrl-a h`, `Ctrl-a j`, `Ctrl-a k`, and `Ctrl-a l`
- optional prefix-free pane movement with `Alt-h`, `Alt-j`, `Alt-k`, and `Alt-l`
- repeatable `Ctrl-a <` / `Ctrl-a >` bindings move the current window in the window list
- repeatable `Ctrl-a H/J/K/L` bindings resize panes in five-cell steps

Start a C++ project session:

```sh
tmux new-session -s cpp -c ~/src/project
```

Inside the session, open Neovim in one pane:

```sh
nvim .
```

Create a build pane in the same project directory:

```sh
tmux split-window -h -c "#{pane_current_path}"
cmake --build build
```

Detach and reattach:

```sh
tmux detach-client
tmux attach-session -t cpp
```

Move between panes:

```text
Ctrl-a j    Move to pane below
Ctrl-a k    Move to pane above
Ctrl-a h    Move to pane on the left
Ctrl-a l    Move to pane on the right
Ctrl-a ↓    Move to pane below
Ctrl-a ↑    Move to pane above
Ctrl-a o    Cycle panes
Ctrl-a H    Resize pane left by 5 cells
Ctrl-a J    Resize pane down by 5 cells
Ctrl-a K    Resize pane up by 5 cells
Ctrl-a L    Resize pane right by 5 cells
```

Reload tmux config after changes:

```sh
tmux source-file ~/.tmux.conf
```

## Template Check

Render the platform-specific local Neovim template without applying it:

```sh
chezmoi execute-template < dot_config/nvim/lua/local.lua.tmpl
```

On macOS, this should render:

```lua
vim.g.cpp_compiler = "clang++"
```

On Linux, this should render:

```lua
vim.g.cpp_compiler = "g++"
```

## Troubleshooting

List managed files:

```sh
chezmoi managed
```

Show the target path for a source file:

```sh
chezmoi target-path dot_config/nvim/init.lua
```

Re-apply only the Neovim config:

```sh
chezmoi apply ~/.config/nvim
```

Re-apply only the tmux config:

```sh
chezmoi apply ~/.tmux.conf
```

If Neovim opens but C++ LSP does not attach, confirm `clangd` is available:

```sh
which clangd
clangd --version
```

Inside tmux, confirm the terminal type is the tmux terminfo entry:

```sh
echo "$TERM"
```

It should print:

```text
tmux-256color
```
