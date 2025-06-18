return {
  {
    "chaoren/vim-wordmotion",
    lazy = false,
    init = function()
      vim.g.wordmotion_spaces = { ".", "_", "-", "," }
      vim.g.wordmotion_uppercase_spaces = {
        "(",
        ")",
        "\\[",
        "\\]",
        "{",
        "}",
        [["]],
        [[']],
        "=",
        ":",
        ">",
        "<",
      }
      -- key = behavior
      -- value = keybind
      vim.g.wordmotion_mappings = { gE = 'B' }
    end,
    keys = {
      -- {
      --   "b",
      --   "<plug>WordMotion_w"
      -- },
      -- { -- not working?
      --   "B",
      --   "<plug>WordMotion_gE"
      -- },
      -- {
      --   "b",
      --   "<plug>WordMotion_ge"
      -- },
      {
        "t",
        "<plug>WordMotion_w"
      },
      {
        "T",
        "<plug>WordMotion_W"
      }
    }
  },
}
-- test string:
-- ooooo(o)ooooooooo[o]ooooooooooooo{o}ooo?ooo@oo%ooo|oo*ooo&ooo\ooo/ooo"o"ooo'o'oo:oo;ooo=o_oo-oo.ooo,ooo!ooo<o>ooo
