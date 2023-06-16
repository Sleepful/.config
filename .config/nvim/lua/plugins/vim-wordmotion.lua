return {
  {
    "chaoren/vim-wordmotion",
    init = function()
      vim.g.wordmotion_spaces = { ".", "_", "-" }
      vim.g.wordmotion_uppercase_spaces = {
        "(",
        ")",
        "\\[",
        "\\]",
        "{",
        "}",
        [["]],
        [[']],
      }
    end,
  },
}
-- test string:
-- ooooo(o)ooooooooo[o]ooooooooooooo{o}ooo?ooo@oo%ooo|oo*ooo&ooo\ooo/ooo"o"ooo'o'oo:oo;ooo=o_oo-oo.ooo,ooo!ooo<o>ooo
