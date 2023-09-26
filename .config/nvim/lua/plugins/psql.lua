return {
  {
    lazy = false,
    "harrisoncramer/psql.nvim",
    config = function()
      require("psql").setup({})
    end,
    keys = {
      {
        "<leader>pr",
        function()
          require("psql").query_paragraph()
        end,
        desc = "Query Paragraph",
      },
      {
        "<leader>pe",
        function()
          require("psql").query_current_line()
        end,
        desc = "Query Current Line",
      },
      {
        "<leader>pe",
        function()
          require("psql").query_selection()
        end,
        mode = { "v" },
        desc = "Query Selection",
      },
      {
        "<leader>py",
        function()
          require("psql").yank_cell()
        end,
        desc = "Yank Cell",
      },
    },
  },
}
