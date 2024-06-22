-- Enable filetype detection
vim.cmd('filetype on')

-- Enable filetype-specific plugins
vim.cmd('filetype plugin on')

-- Enable filetype-specific indentation
vim.cmd('filetype indent on')

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Show line numbers
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Set netrw list style to 3
vim.g.netrw_liststyle = 3

-- Enable search highlighting
vim.opt.hlsearch = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = "'"

-- Set up Telescope file browser
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })

require("config.lazy")
