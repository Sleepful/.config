local K = require("keys")

-- function to have bookmarks per workdir per buffer
-- taken from official docs iirc
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
      "nvim-telescope/telescope.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    lazy = false,
    init = function()
      vim.g.bookmark_manage_per_buffer = 1
      vim.g.bookmark_auto_save = 1
      vim.cmd(vim_bookmarks_fun)
      require("telescope").load_extension("vim_bookmarks")
    end,
    keys = {
      require("plugins.telescope.C-g-keymaps").vim_bookmarks.all,
      require("plugins.telescope.C-g-keymaps").vim_bookmarks.page,
      { "<C-" .. K.right_helper_one.key .. ">", "<cmd>BookmarkNext<CR>", mode = "n" },
      { "<C-" .. K.left_helper_one.key .. ">",  "<cmd>BookmarkPrev<CR>", mode = "n" },
      -- { "<F29>",                               "<cmd>BookmarkNext<CR>", mode = "n" },
      -- { "<NL>",                                 "<cmd>BookmarkPrev<CR>", mode = "n" },
      -- create new bookmark with mi
    },
  },
}
