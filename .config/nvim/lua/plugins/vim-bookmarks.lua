-- function to have bookmarks per workdir per buffer
local vim_bookmarks_fun = [[
" Finds the Git super-project directory based on the file passed as an argument.
function! g:BMBufferFileLocation(file)
    let filename = 'vim-bookmarks'
    let location = ''
    if isdirectory(fnamemodify(a:file, ":p:h").'/.git')
        " Current work dir is git's work tree
        let location = fnamemodify(a:file, ":p:h").'/.git'
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', fnamemodify(a:file, ":p:h").'/.;')
    endif
    if len(location) > 0
        return simplify(location.'/.'.filename)
    else
        return simplify(fnamemodify(a:file, ":p:h").'/.'.filename)
    endif
endfunction
]]

return {
  {
    "MattesGroeger/vim-bookmarks",
    dependencies = {
      "MattesGroeger/vim-bookmarks",
      "nvim-telescope/telescope.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    lazy = false,
    config = function()
      -- Commented out, bookmarks per working dir:
      -- vim.g.bookmark_save_per_working_dir = 1
      -- vim.cmd(vim_bookmarks_fun)
      vim.g.bookmark_manage_per_buffer = 1
      vim.g.bookmark_auto_save = 1
      require("telescope").load_extension("vim_bookmarks")
    end,
    keys = { {
      "ml",
      "<cmd>Telescope vim_bookmarks all<cr>",
      desc = "Telescope bookmarks",
    } },
  },
}
