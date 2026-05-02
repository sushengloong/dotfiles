# Agent Instructions

This is a chezmoi source repository for personal dotfiles. These instructions apply to the whole repository.

## Repository Map

- `README.md` documents setup, daily workflow, and managed files.
- `.chezmoiignore` keeps repository-only docs out of the rendered home state.
- `dot_tmux.conf` is rendered to `~/.tmux.conf`.
- `dot_config/nvim/` is rendered to `~/.config/nvim/`.
- `dot_config/nvim/lua/local.lua.tmpl` is a chezmoi template for host-specific Neovim settings.

## Working Guidelines

- Edit the chezmoi source files in this repository, not the rendered files under `$HOME`.
- Keep changes small and aligned with the existing native Neovim and tmux configuration style.
- Do not introduce plugin-manager frameworks such as lazy.nvim or Mason; the Neovim config intentionally uses built-in APIs and `vim.pack`.
- Preserve the `Managed by chezmoi` comments in files that already have them.
- Avoid hardcoded machine-local paths, secrets, or credentials. Use chezmoi templates when a setting must vary by host.
- Update `README.md` when adding managed files, changing setup steps, or altering daily workflow commands.

## Validation

- Run `chezmoi diff` before applying changes.
- For template or rendered-output changes, run `chezmoi apply --dry-run --verbose` when available.
- If changing tmux config, reload with `tmux source-file ~/.tmux.conf` after applying.
- If changing Neovim Lua files, start Neovim after applying and check `:messages`, `:checkhealth`, and relevant keymaps.
