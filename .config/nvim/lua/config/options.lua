-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.scrolloff = 40 -- keep cursor in the middle
-- sidescrolloff cuts the first column too often, annoying!
-- vim.opt.sidescrolloff = 40 -- keep cursor away from side borders
vim.opt.number = false -- no line numbers
vim.opt.relativenumber = false -- no line numbers
vim.lsp.set_log_level("debug")
-- set cursor column highlighting
vim.opt.cuc = true
