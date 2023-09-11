-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })

vim.opt.swapfile = false

-- Transparency for normal windows
vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])

-- Transparency for popup windows (e.g., floating windows)
vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])

-- Exclude transparency for LuaLine
vim.cmd([[highlight! LuaLine guibg=NONE ctermbg=NONE]])

vim.cmd([[set mouse=a]])
vim.cmd([[Copilot enable]])
