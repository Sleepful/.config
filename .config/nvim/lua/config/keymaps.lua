local K = require("keys")

local function map(mode, lhs, rhs, opts)
  -- map mode:
  -- https://neovim.io/doc/user/map.html
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = false
  end
  if opts.silent == nil then
    opts.noremap = true
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Moving lines up and down smoothly
-- https://stackoverflow.com/a/28186505/2446144
map({ "o", "n" }, "<S-Right>", "<Cmd>:m +1<CR>", { desc = "" })
map({ "o", "n" }, "<S-Left>", "<Cmd>:m -2<CR>", { desc = "" })
map({ "x" }, "<S-Right>", ":m '>+1<CR>gv=gv", { desc = "" })
map({ "x" }, "<S-Left>", ":m '<-2<CR>gv=gv", { desc = "" })

-- adjust indentation while in visual mode without losing the selection
map({ "x" }, ">", ">gv", { desc = "" })
map({ "x" }, "<", "<gv", { desc = "" })
map({ "x" }, "<Tab>", ">gv", { desc = "" })
map({ "x" }, "<S-Tab>", "<gv", { desc = "" })

map({ "n" }, "<Tab>", ">>", { desc = "" })
map({ "n" }, "<S-Tab>", "<<", { desc = "" })
-- C-i is mapped to F3 in kitty conf, to differentiate it from tab, as C-i and Tab are the same keycode in nvim
-- so here we map F3 to C-i (tab) for jump position navigation, and map tab to an indentation command
map({ "n" }, "<F3>", "<C-i>", { desc = "" })

-- Undo
map("i", "<C-u>", "<C-o>u", { desc = "Undo from insert mode" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Navigate between quickfix items
vim.keymap.set("n", "<S-PageDown>", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
vim.keymap.set("n", "<S-PageUp>", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

-- Quickfix ops
map({ "n" }, "<leader>lo", "<Cmd>copen<CR>", { desc = "Open quickfix list" })

-- Write file
map({ "n" }, "<leader>w", "<Cmd>w<CR>", { desc = "Write file" })
-- Quit
map({ "n" }, "<leader>q", "<Cmd>q<CR>", { desc = "Quit" })
map({ "n" }, "<leader>Q", "<Cmd>q!<CR>", { desc = "Quit!" })

-- Navigate between bookmarks
vim.keymap.set("n", "<Home>", "<cmd>BookmarkNext<CR>", { desc = "Next Bookmark" })
vim.keymap.set("n", "<End>", "<cmd>BookmarkPrev<CR>", { desc = "Previous Bookmark" })

-- CMP uses Tab and S-Tab to select next and prev

require("which-key").add({ "<leader>u", group = '[U]ser Interface' })
-- Wrap lines
map("n", "<leader>uw", "<Cmd>set wrap!<CR>", { desc = "Toggle word wrap" })
map("n", "<S-h>", "40zh", { desc = "Scroll left" })
map("n", "<S-l>", "40zl", { desc = "Scroll right" })

-- <p> move in paragraphs with arrows
map({ "i" }, "<S-Up>", "<C-o>{", { desc = "Move to start of paragraph" })
map({ "i" }, "<S-Down>", "<C-o>}", { desc = "Move to start of paragraph" })
map({ "n", "x", "o" }, "<S-Up>", "{", { desc = "Move to start of paragraph" })
map({ "n", "x", "o" }, "<S-Down>", "}", { desc = "Move to start of paragraph" })

-- <p> move with parens
map({ "n", "x", "o" }, "(", "{", { desc = "Prefer paragraph movement" })
map({ "n", "x", "o" }, ")", "}", { desc = "Prefer paragraph movement" })

map({ "n", "x", "o" }, "<C-x>i", "<C-a>", { desc = "Increment number" })
map({ "n", "x", "o" }, "g<C-x>i", "g<C-a>", { desc = "Increment number" })
map({ "n", "x", "o" }, "<C-x>d", "<C-a>", { desc = "Decrement number" })
map({ "n", "x", "o" }, "g<C-x>d", "g<C-a>", { desc = "Decrement number" })

-- Yank filename of current buffer and display as message
require("which-key").add({ "<leader>y", group = '[Y]ank' })
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
-- map("i", "<C-x>", "<cmd>Telescope neoclip plus extra=0<cr>", { desc = "Neoclip" })

-- Use the 0 register by default when using Put,
-- 0 is the "yank" register, which will contain the last yank
-- unlike the default register ["], which contains cuts and overwritten text
-- map({ "n", "v" }, "p", [["0p]], { desc = "Paste yank" })
-- map({ "n", "v" }, "P", [["0P]], { desc = "Paste yank" })

-- Classic pasting
map("n", "[p", "O<esc>p", { desc = "Paste above", remap = true })
map("n", "]p", "o<esc>p", { desc = "Paste below", remap = true })

-- Paste without losing yank in visual mode
map("v", "p", "pgvy", { desc = "Paste in visual and yank back the original yank", remap = true })
map("v", "P", "p", { desc = "Paste normally with P in visual, which loses original yank", remap = true })
-- https://stackoverflow.com/a/25282274/2446144
-- xnoremap p pgvy
-- --

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
  -- "<C-g><C-q>",
  require("plugins.telescope.C-g-keymaps").cgLeader .. "<C-q>",
  ":call QuickFixOpenAll()<CR>",
  { noremap = true, silent = false, desc = "🧙 open Quickfix files" }
)

-- vim-quickscope
-- map("n", "<leader>uq", "<cmd>QuickScopeToggle<cr>", {
--   desc = "Toggle QuickScope",
-- })

-- UI modes
-- TODO:
-- Stream mode: line numbers, line highlight
-- map({ "n" }, "<leader>uus", "", { desc = "Stream mode" })
-- Laser mode: line highlight, column highlight
-- map({ "n" }, "<leader>uul", "", { desc = "Laser mode" })
-- Minimal mode: line highlight,
-- map({ "n" }, "<leader>uum", "", { desc = "Minimal mode" })

-- <F29> is mapped to cmd+
-- <F30> is mapped to cmd"
map("i", "<F30>", '""<Left>', { desc = "Insert double quotes twice" })

-- special mapping of C-j to F29, because C-j is actually translated to RETURN in nvim
map({ "n" }, "<M-Down>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Move buffer right" })
map({ "n" }, "<C-k>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Move buffer right" })
map({ "n" }, "<M-k>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Swap buffer right" })
map({ "n" }, "<M-S-Down>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Swap buffer right" })
map({ "n" }, "<M-Up>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Move buffer left" })
map({ "n" }, "<F29>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Move buffer left" })
map({ "n" }, "<M-j>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Swap buffer left" })
map({ "n" }, "<M-S-Up>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Swap buffer left" })

map("i", "<F21>", "()<Left>", { desc = "Insert closed parens ()" })
map("i", "<F22>", ")<Left>", { desc = "Insert closing parens ) to the right" })

map("i", "<F16>", "{}<Left>", { desc = "Insert closed parens {}" })
map("i", "<F17>", "}<Left>", { desc = "Insert closing parens } to the right" })

-- test if this one is a good idea:
map("i", "<F25>", "${}<Left>", { desc = "Specific JavaScript interpolation inside string" })
map("i", "", "=> ", { desc = "Specific JavaScript arrow =>" })

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

map({ "n" },
  "<PageUp>",
  [[:<C-u>call SaveJump("\<lt>C-u>")<CR>:call SetJump()<CR>]], { desc = "C-u/C-d with jumplist" })
map({ "n" },
  "<PageDown>",
  [[:<C-u>call SaveJump("\<lt>C-d>")<CR>:call SetJump()<CR>]], { desc = "C-u/C-d with jumplist" })

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnext #<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- TODO: conflict with <C-I>
-- map("n", "<tab><tab>", "<cmd>tabnext #<cr>", { desc = "Last Tab" })
-- map("n", "<tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- map("n", "<tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- TODO:
-- map <M-C-Up> and <M-C-Down> to increase/decrease window height, like the way that <M-C-Left> curently works

map("t", "<C-N><C-N>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("i", "<M-BS>", "<Del>", { desc = "Delete forward" })
