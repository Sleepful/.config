local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("sync_last_yank_with_registers"),
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

-- use tabs inside a makefile
-- vim.api.nvim_create_autocmd('FileType', {
--   desc = 'Ensures tabs are used on Makefiles instead of spaces',
--   callback = function(event)
--     if event.match == 'make' or event.match == 'makefile' then
--       vim.o.expandtab = false -- also tried with vim.opt
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function(ev)
    -- might not be working as expected:
    vim.cmd("setlocal noexpandtab softtabstop=0")
    -- cannot manage to disable editorconfig settings, but that is the intention here:
    vim.cmd("let b:editorconfig = v:false")
  end
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
    -- map("i", "[[", function()
    --   require("telekasten").insert_link()
    -- end)
    map("i", "#?", function()
      require("telekasten").show_tags()
    end)
    -- vim.cmd("set formatoptions+=a")
  end,
  pattern = "markdown",
})

-- this return value is only used by vim_quickscope
-- unused until I add vim_quickscope plugin
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
          "highlight QuickScopePrimary" ..
          fg_primary .. "gui=underdouble ctermfg=155 cterm=underline"
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
