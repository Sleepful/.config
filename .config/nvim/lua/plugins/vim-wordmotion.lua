return {
  {
    "chaoren/vim-wordmotion",
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
      -- `g:wordmotion_mappings` shows up in the docs but does not work
    end,
    keys = {
      -- {
      --   "b",
      --   "<plug>WordMotion_w"
      -- },
      {
        "B",
        "<plug>WordMotion_gE"
      },
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
