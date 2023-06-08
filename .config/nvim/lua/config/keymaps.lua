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
    opts.noremap = true
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<S-h>", "40zh", { desc = "Scroll left" })
map("n", "<S-l>", "40zl", { desc = "Scroll right" })
map("n", "<C-p>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<C-n>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- <p> move with parens
map({ "n", "x", "o" }, "(", "{", { desc = "Prefer paragraph movement" })
map({ "n", "x", "o" }, ")", "}", { desc = "Prefer paragraph movement" })
-- these match with kitty config:
map({ "n", "x", "o" }, "{", "$", { desc = "Prefer end of line movement" })
map({ "n", "x", "o" }, "}", "%", { desc = "Prefer match symbols movement" })

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

-- Yank filename of current buffer and display as message
map("n", "<leader>fy", function()
  vim.cmd("let @+=@%")
  vim.cmd("echo getreg('+')")
end, { desc = "Yank filename" })

-- Yank git branch
map("n", "<leader>gY", function()
  local branch = require("util").cmd("git branch --show-current")
  vim.fn.setreg("+", branch)
  print(branch)
end, { desc = "Yank git branch" })

-- Neoclip
map("i", "<C-p>", "<cmd>Telescope neoclip plus<cr>", { desc = "Neoclip" })

-- Classic pasting
map("n", "[p", "O<esc>p", { desc = "Paste above" })
map("n", "]p", "o<esc>p", { desc = "Paste below" })
