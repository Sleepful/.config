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
map("n", "<leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
  vim.cmd("echo getreg('+')")
end, { desc = "Filename" })

map("n", "<leader>yr", function()
  vim.fn.setreg("+", vim.fn.fnamemodify(vim.fn.expand("%"), ":."))
  vim.cmd("echo getreg('+')")
end, { desc = "Relative path" })

map("n", "<leader>ya", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  vim.cmd("echo getreg('+')")
end, { desc = "Absolute path" })

-- Yank git branch
map("n", "<leader>yb", function()
  local branch = require("util").cmd("git branch --show-current")
  vim.fn.setreg("+", branch)
  print(branch)
end, { desc = "Git branch name" })

-- Neoclip
-- TODO: make it so that it inserts the selected yank into the current insert thing
map("i", "<C-n>", "<cmd>Telescope neoclip plus<cr>", { desc = "Neoclip" })

-- Classic pasting
map("n", "[p", "O<esc>p", { desc = "Paste above" })
map("n", "]p", "o<esc>p", { desc = "Paste below" })

-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.cmd("xmap ga <Plug>(EasyAlign)")

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.cmd("xmap ga <Plug>(EasyAlign)")
vim.cmd("nmap ga <Plug>(EasyAlign)")

-- Open files from a quickfix list into buffers
vim.cmd([[
function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction
]])

map(
  "n",
  "<C-g><C-q>",
  ":call QuickFixOpenAll()<CR>",
  { noremap = true, silent = false, desc = "🧙 open Quickfix files" }
)

-- Classic moves in insert mode
map("i", "<C-h>", "<Left>", { desc = "Insert mode move left" })
map("i", "<C-l>", "<Right>", { desc = "Insert mode move right" })

-- vim-quickscope
map("n", "<leader>uq", "<cmd>QuickScopeToggle<cr>", {
  desc = "Toggle QuickScope",
})

-- UI modes
-- TODO:
-- Stream mode: line numbers, line highlight
map({ "n" }, "<leader>uus", "", { desc = "Stream mode" })
-- Laser mode: line highlight, column highlight
map({ "n" }, "<leader>uul", "", { desc = "Laser mode" })
-- Minimal mode: line highlight,
map({ "n" }, "<leader>uum", "", { desc = "Minimal mode" })

-- WordWise leap movements, can not seem to override the "move window" keys from lazy vim for all modes

map({ "n", "x", "o" }, "<C-k>", function()
  require("plugins.leap.word")("upwards")
end, { desc = "Leap by word upwards" })
map({ "n", "x", "o" }, "<C-j>", function()
  require("plugins.leap.word")("downwards")
end, { desc = "Leap by word downwards" })
