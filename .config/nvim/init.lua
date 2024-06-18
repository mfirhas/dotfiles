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

require("config.lazy")
