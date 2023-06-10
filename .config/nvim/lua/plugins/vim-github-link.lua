return {
  {
    "knsh14/vim-github-link",
    keys = {
      {
        "<leader>yG",
        function()
          vim.cmd("GetCurrentBranchLink")
        end,
        desc = "Github link - branch",
      },
      {
        "<leader>yg",
        function()
          vim.cmd("GetCurrentCommitLink")
        end,
        desc = "Github link - commit",
      },
    },
  },
}
