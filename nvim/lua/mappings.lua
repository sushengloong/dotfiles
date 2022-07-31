function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- more natural movement with wrap on
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Easy buffer navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Nvim-tree file explorer
nmap("<F2>", "<cmd> :NvimTreeToggle<cr>")
nmap("<F3>", "<cmd> :NvimTreeFindFile<cr>")

-- Telescope file search
nmap("<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<leader>f", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")

