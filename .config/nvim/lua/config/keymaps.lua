-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- function taken from lazyvim's default keymaps
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<S-h>", "40zh", { desc = "Scroll left" })
map("n", "<S-l>", "40zl", { desc = "Scroll right" })
map("n", "<C-p>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<C-n>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- make it so that {} works as $% under normal mode and movements
-- note: this matches some karabiner config where $% are swaped in place for {}
map({ "n", "x", "o" }, "(", "{", { desc = "Normal mode movement in paragraph" })
map({ "n", "x", "o" }, ")", "}", { desc = "Normal mode movement in paragraph" })
map({ "n", "x", "o" }, "{", "$", { desc = "Normal mode movement" })
map({ "n", "x", "o" }, "}", "%", { desc = "Normal mode movement" })

local Util = require("lazyvim.util")
-- override default line number toggle because I want to
-- toggle between "no number" and "normal number"
map("n", "<leader>ul", function()
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })
