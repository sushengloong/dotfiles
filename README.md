# Dotfiles

This is a [chezmoi](https://www.chezmoi.io/) source repository for personal dotfiles.

At the moment it manages:

- `dot_config/nvim/init.lua` -> `~/.config/nvim/init.lua`
- `dot_config/nvim/lua/plugins.lua` -> `~/.config/nvim/lua/plugins.lua`
- `dot_config/nvim/lua/cpp.lua` -> `~/.config/nvim/lua/cpp.lua`
- `dot_config/nvim/lua/local.lua.tmpl` -> `~/.config/nvim/lua/local.lua`
- `dot_config/nvim/nvim-pack-lock.json` -> `~/.config/nvim/nvim-pack-lock.json`
- `dot_tmux.conf` -> `~/.tmux.conf`

The `local.lua.tmpl` file is rendered by chezmoi and sets a platform-specific C++ compiler value.

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

The native Telescope sorter also needs `make` and a C compiler. On macOS, install the Xcode Command Line Tools if those are missing:

```sh
xcode-select --install
```

On non-macOS systems, use the equivalent package manager packages for `chezmoi`, `neovim`, `tmux`, `git`, `clangd`, `clang-format`, `ripgrep`, `make`, and a C compiler.

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

This configuration uses Neovim's native Lua config and avoids plugin manager frameworks such as lazy.nvim or Mason.

Optional plugins are installed with `vim.pack` when that API is available:

- `nvim-treesitter/nvim-treesitter`
- `stevearc/conform.nvim`
- `nvim-lua/plenary.nvim`
- `nvim-telescope/telescope.nvim`
- `nvim-telescope/telescope-fzf-native.nvim`
- `folke/tokyonight.nvim`

Telescope uses `telescope-fzf-native.nvim` as its sorter because it is implemented in C and is materially faster than the default Lua sorter on larger lists. The config builds it with `make` after install or update when the compiled library is missing.

The active colorscheme is `tokyonight-night`. It was chosen for C++ because it has mature Tree-sitter, LSP, diagnostics, Telescope, and terminal color support. The config increases foreground, diagnostic, and line-number contrast, and disables italics for steadier terminal rendering inside tmux.

The C++ configuration starts `clangd` for C, C++, Objective-C, Objective-C++, and CUDA buffers. Project roots are detected from:

- `compile_commands.json`
- `.clangd`
- `.git`
- `CMakeLists.txt`

Useful Neovim commands and keymaps:

```text
:LspStatus     Show attached LSP clients for the current buffer
gd             Go to definition
gD             Go to declaration
gr             List references
gi             Go to implementation
K              Show hover documentation
<leader>rn     Rename symbol
<leader>ca     Code action
<leader>e      Show diagnostics
[d / ]d        Previous / next diagnostic
<leader>f      Format buffer
<leader>ff     Find files
<leader>fg     Live grep
<leader>fb     Find buffers
<leader>fh     Find help
<leader>fr     Find recent files
<leader>fd     Find diagnostics
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

## Tmux Notes

The tmux config is tuned for Neovim sessions:

- `tmux-256color` with true color enabled for common terminal types
- extended key handling for terminal Neovim
- focus events for Neovim autocmds
- low escape timeout for modal editing
- mouse support and vi copy mode
- large scrollback for build and test output
- new panes and windows inherit the current project directory

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
