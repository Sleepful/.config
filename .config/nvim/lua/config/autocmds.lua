-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("sync_last_yank_with_l_register"),
  callback = function()
    local last_yank = vim.fn.getreg("0")
    vim.fn.setreg("p", last_yank)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("mbyte_keymaps"),
  callback = function()
    vim.bo.keymap = "keymaps"
  end,
})
