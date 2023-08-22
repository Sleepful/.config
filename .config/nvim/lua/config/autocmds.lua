-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

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

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("sync_last_yank_with_l_register"),
  callback = function()
    local last_yank = vim.fn.getreg("0")
    vim.fn.setreg("p", last_yank)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("buffer_metadata"),
  callback = function()
    local value = vim.fn.localtime()
    local buffer = vim.api.nvim_get_current_buf()
    local var_name = "last_visited"
    vim.api.nvim_buf_set_var(buffer, var_name, value)
  end,
})

-- keybinds local to a filetype
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("file_type_bindings"),
  callback = function()
    map("n", "<leader>cp", function()
      require("peek").open()
    end, { desc = "Peek open" })
    map("n", "<leader>cc", function()
      require("peek").close()
    end, { desc = "Peek close" })
    map("i", "[[", function()
      require("telekasten").insert_link()
    end)
    map("i", "#?", function()
      require("telekasten").show_tags()
    end)
    -- vim.cmd("set formatoptions+=a")
  end,
  pattern = "markdown",
})

return {
  quick_scope = {
    auto = "ColorScheme",
    opts = {
      group = augroup("qs_colors"),
      callback = function()
        local flavour = "flavour-" .. require("util").cmd("flavours current")
        local colors = require("base16-colorscheme").colorschemes[flavour]
        local primary_color = colors.base06
        local secondary_color = colors.base0A
        local primary_bg = colors.base06
        local secondary_bg = colors.base07
        local param = function(name, value)
          return " " .. name .. "='" .. value .. "' "
        end
        local fg_primary = param("guifg", primary_color)
        local fg_scondary = param("guifg", secondary_color)
        local bg_primary = param("guibg", primary_bg)
        local bg_scondary = param("guibg", primary_bg)
        vim.cmd(
          "highlight QuickScopePrimary" .. fg_primary .. "gui=underdouble ctermfg=155 cterm=underline"
        -- "highlight QuickScopePrimary" .. fg_primary .. bg_primary .. "gui=underdouble ctermfg=155 cterm=underline"
        )
        vim.cmd(
        -- "highlight QuickScopeSecondary" .. fg_scondary .. bg_scondary .. "gui=underline ctermfg=81 cterm=underline"
          "highlight QuickScopeSecondary"
          .. fg_scondary
          .. "gui=underline ctermfg=81 cterm=underline"
        )
      end,
    },
  },
}
