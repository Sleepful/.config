-- Add any additional keymaps here

-- function taken from lazyvim's default keymaps
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    opts.noremap = opts.noremap ~= true
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<S-h>", "40zh", { desc = "Scroll left" })
map("n", "<S-l>", "40zl", { desc = "Scroll right" })

-- <p> move with parens
map({ "n", "x", "o" }, "(", "{", { desc = "Prefer paragraph movement" })
map({ "n", "x", "o" }, ")", "}", { desc = "Prefer paragraph movement" })
-- these match with kitty config:
map({ "n", "x", "o" }, "{", "$", { desc = "Prefer end of line movement" })
map({ "n", "x", "o" }, "}", "%", { desc = "Prefer match symbols movement" })

map({ "n", "x", "o" }, "<C-x>i", "<C-a>", { desc = "Increment number" })
map({ "n", "x", "o" }, "g<C-x>i", "g<C-a>", { desc = "Increment number" })
map({ "n", "x", "o" }, "<C-x>d", "<C-a>", { desc = "Decrement number" })
map({ "n", "x", "o" }, "g<C-x>d", "g<C-a>", { desc = "Decrement number" })

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
map("i", "<C-x>", "<cmd>Telescope neoclip plus extra=0<cr>", { desc = "Neoclip" })

-- Use the 0 register by default when using Put,
-- 0 is the "yank" register, which will contain the last yank
-- unlike the default register ["], which contains cuts and overwritten text
map({ "n", "v" }, "p", [["0p]], { desc = "Paste yank" })
map({ "n", "v" }, "P", [["0P]], { desc = "Paste yank" })

-- Classic pasting
map("n", "[p", "O<esc>p", { desc = "Paste above", remap = true })
map("n", "]p", "o<esc>p", { desc = "Paste below", remap = true })

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

-- Bufferline oveerrides, again, cannot seem to override the "move window" keys from lazy vim for n mode
-- testing these changes:
-- C-n -> <M-l>
-- C-p -> <M-h>
map({ "n" }, "<M-l>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
map({ "n" }, "<M-h>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })

map({ "n" }, "<C-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Move buffer right" })
map({ "n" }, "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Move buffer left" })

-- `set jump` and `save jump` taken from:
-- https://vi.stackexchange.com/questions/31197/add-current-position-to-the-jump-list-the-first-time-c-u-or-c-d-is-pressed
local save_jump = [[function! SaveJump(motion)
  if exists('#SaveJump#CursorMoved')
    autocmd! SaveJump
  else
    normal! m'
  endif
  let m = a:motion
  if v:count
    let m = v:count.m
  endif
  execute 'normal!' m
endfunction]]
vim.cmd(save_jump)

local set_jump = [[function! SetJump()
  augroup SaveJump
    autocmd!
    autocmd CursorMoved * autocmd! SaveJump
  augroup END
endfunction]]
vim.cmd(set_jump)

map({ "n" }, "<C-u>", [[:<C-u>call SaveJump("\<lt>C-u>")<CR>:call SetJump()<CR>]], { desc = "C-u/C-d with jumplist" })
map({ "n" }, "<C-d>", [[:<C-u>call SaveJump("\<lt>C-d>")<CR>:call SetJump()<CR>]], { desc = "C-u/C-d with jumplist" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnext #<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- TODO: conflict with <C-I>
-- map("n", "<tab><tab>", "<cmd>tabnext #<cr>", { desc = "Last Tab" })
-- map("n", "<tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- map("n", "<tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- TODO:
-- map <M-C-Up> and <M-C-Down> to increase/decrease window height, like the way that <M-C-Left> curently works
