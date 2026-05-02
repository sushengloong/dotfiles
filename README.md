# Dotfiles

This is a [chezmoi](https://www.chezmoi.io/) source repository for personal dotfiles.

At the moment it manages a focused Neovim configuration:

- `dot_config/nvim/init.lua` -> `~/.config/nvim/init.lua`
- `dot_config/nvim/lua/plugins.lua` -> `~/.config/nvim/lua/plugins.lua`
- `dot_config/nvim/lua/cpp.lua` -> `~/.config/nvim/lua/cpp.lua`
- `dot_config/nvim/lua/local.lua.tmpl` -> `~/.config/nvim/lua/local.lua`

The `local.lua.tmpl` file is rendered by chezmoi and sets a platform-specific C++ compiler value.

## Prerequisites

Install the core tools before applying the dotfiles:

```sh
brew install chezmoi neovim git
```

For the C++ Neovim setup, install `clangd` and `clang-format` so LSP and formatting work:

```sh
brew install llvm clang-format
```

On non-macOS systems, use the equivalent package manager packages for `chezmoi`, `neovim`, `git`, `clangd`, and `clang-format`.

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

If Neovim opens but C++ LSP does not attach, confirm `clangd` is available:

```sh
which clangd
clangd --version
```
