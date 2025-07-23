vim.opt.scrolloff = 40 -- keep cursor in the middle
-- sidescrolloff cuts the first column too often, annoying!
-- vim.opt.sidescrolloff = 40 -- keep cursor away from side borders
vim.opt.number = false         -- no line numbers
vim.opt.relativenumber = false -- no line numbers
vim.lsp.set_log_level("debug")
-- set cursor column highlighting
vim.opt.cuc = true
vim.opt.hlsearch = true -- highlight all matches when searching with: / ? # *
-- overwrite jumps when moving after jumping back
vim.opt.jumpoptions = "stack"

-- should reload files as they change by other programs
vim.o.autoread = true

-- unmap the <C-j> as linefeed, this way it can be mapped as a keybind elsewhere
-- https://unix.stackexchange.com/a/329645/235506
-- vim.opt.BASH_Ctrl_j = "stack"

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

-- :set indentkeys-=o
-- run this command to disable indentation based on open parentheses and similar,
-- gets buggy when open parens are left unclosed in comments or strings, so on and so forth...
