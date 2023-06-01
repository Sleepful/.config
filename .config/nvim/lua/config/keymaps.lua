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
    opts.remap = opts.remap or false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<S-h>", "40zh", { desc = "Scroll left" })
map("n", "<S-l>", "40zl", { desc = "Scroll right" })
map("n", "<C-p>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<C-n>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- make it so that {} works as $% under normal mode and movements
-- note: this matches some karabiner config where $% are swaped in place for {}
-- map({ "n", "x", "o" }, "(", "{", { desc = "Normal mode movement in paragraph" })
-- map({ "n", "x", "o" }, ")", "}", { desc = "Normal mode movement in paragraph" })
-- map({ "n", "x", "o" }, "{", "$", { desc = "Normal mode movement" })
-- map({ "n", "x", "o" }, "}", "%", { desc = "Normal mode movement" })

-- numbers to ops
-- map({ "t" }, "1", "!", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "2", "@", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "3", "#", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "4", "{", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "5", "}", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "6", "^", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "7", "&", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "8", "*", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "9", "(", { desc = "numbers As symbols" })
-- map({ "n", "x", "o", "c" }, "0", ")", { desc = "numbers As symbols" })
--
-- map({ "n", "x", "o", "c" }, "!", "1", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "@", "2", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "#", "3", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "{", "4", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "}", "5", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "^", "6", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "&", "7", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "%", "8", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, "(", "9", { desc = "symbols As numbers" })
-- map({ "n", "x", "o", "c" }, ")", "0", { desc = "symbols As numbers" })

map({ "n", "x", "o" }, "<C-b>", "<C-a>", { desc = "Increment number, avoid clash with tmux prefix" })
map({ "n", "x", "o" }, "g<C-b>", "g<C-a>", { desc = "Increment number, avoid clash with tmux prefix" })

local Util = require("lazyvim.util")
-- override default line number toggle because I want to
-- toggle between "no number" and "normal number"
map("n", "<leader>ul", function()
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })

-- enter Normal mode in Term mode with <C-n>
map({ "t" }, "<C-n>", "<C-\\><C-n>", { desc = "Enter Normal mode in Term mode with <C-n>" })
