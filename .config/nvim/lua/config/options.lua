vim.opt.scrolloff = 40 -- keep cursor in the middle
-- sidescrolloff cuts the first column too often, annoying!
-- vim.opt.sidescrolloff = 40 -- keep cursor away from side borders
vim.opt.number = false         -- no line numbers
vim.opt.relativenumber = false -- no line numbers
vim.lsp.set_log_level("debug")
-- set cursor column highlighting
vim.opt.cuc = true
-- overwrite jumps when moving after jumping back
vim.opt.jumpoptions = "stack"

-- per deno lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#denols
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

local o = vim.o
o.expandtab = true   -- expand tab input with spaces characters
o.smartindent = true -- syntax aware indentations for newline inserts
o.tabstop = 2        -- num of space characters per tab
o.shiftwidth = 2     -- spaces per indentation level
