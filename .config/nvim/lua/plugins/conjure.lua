-- NOTE: maybe consider adding this:
--    https://github.com/guns/vim-sexp
-- or this:
--    https://github.com/julienvincent/nvim-paredit
--
--    good paredit functionality to add:
--      forward/backwards slurp
--      forward/backwards barf
--
--      forward-down (navigation)
--      backward-up (navigation)
--
--      forwards/backwards splice-and-kill
--
--      split/join sexp
--
--      look here: https://github.com/guns/vim-sexp/issues/5


local clojure_filetype = "clojure"
return {
  {
    enabled = false, -- not liking these hotkeys
    "guns/vim-sexp",
    ft = clojure_filetype,
    init = function()
      -- Disable mapping hooks
      vim.g.sexp_filetypes = ''
      -- these are taken from the docs:
      --    https://github.com/guns/vim-sexp/blob/master/doc/vim-sexp.txt#L647
      --    *sexp-explicit-mappings*
      -- the % and $ match with kitty config
      vim.cmd([=[
        function! s:vim_sexp_mappings()
            nmap <silent><buffer> $               <Plug>(sexp_move_to_prev_bracket)
            xmap <silent><buffer> $               <Plug>(sexp_move_to_prev_bracket)
            omap <silent><buffer> $               <Plug>(sexp_move_to_prev_bracket)
            nmap <silent><buffer> %               <Plug>(sexp_move_to_next_bracket)
            xmap <silent><buffer> %               <Plug>(sexp_move_to_next_bracket)
            omap <silent><buffer> %               <Plug>(sexp_move_to_next_bracket)
            imap <silent><buffer> <BS>            <Plug>(sexp_insert_backspace)
            imap <silent><buffer> "               <Plug>(sexp_insert_double_quote)
            imap <silent><buffer> (               <Plug>(sexp_insert_opening_round)
            imap <silent><buffer> )               <Plug>(sexp_insert_closing_round)
            imap <silent><buffer> [               <Plug>(sexp_insert_opening_square)
            imap <silent><buffer> ]               <Plug>(sexp_insert_closing_square)
            imap <silent><buffer> {               <Plug>(sexp_insert_opening_curly)
            imap <silent><buffer> }               <Plug>(sexp_insert_closing_curly)
          endfunction
              augroup VIM_SEXP_MAPPING
              autocmd!
              autocmd FileType clojure,scheme,lisp,timl call s:vim_sexp_mappings()
          augroup END
      ]=])
    end,
    keys = {
      {
        "<F25>", -- <C-[> in kittyconf
        function()
          vim.cmd([[execute "normal \<Plug>(sexp_flow_to_prev_open)"]])
        end },
      {
        "<F26>", -- <C-]> in kittyconf
        function()
          vim.cmd([[execute "normal \<Plug>(sexp_flow_to_next_open)"]])
        end },
    }
  },
  {
    -- SUPER TRIPPY!!!
    -- https://github.com/gpanders/nvim-parinfer/blob/master/doc/parinfer.txt
    -- https://shaunlebron.github.io/parinfer/
    "gpanders/nvim-parinfer",
    ft = clojure_filetype,
    keys = {
      {
        "<leader>ci",
        "<cmd>if b:parinfer_enabled ==# 1 | echo 'Parinfer is enabled' | else | echo 'Parinfer is disabled' | endif<cr>",
        desc = "Parinfer Check",
        ft = clojure_filetype,
      },
      { "<leader>cI", "<cmd>ParinferToggle<cr>", desc = "Parinfer Toggle", ft = clojure_filetype, }
    }
  },
  {
    "julienvincent/nvim-paredit",
    ft = clojure_filetype,
    config = function()
      paredit = require("nvim-paredit")
      paredit.setup({
        use_default_keys = false,
        keys = {
          ["<M-x>"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },
          ["<M-t>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
          ["<M-e>"] = { paredit.api.barf_forwards, "Barf forwards" },

          -- [""] = { paredit.api.slurp_backwards, "Slurp backwards" },
          -- [""] = { paredit.api.barf_backwards, "Barf backwards" },

          ["<M-a>"] = { paredit.api.drag_element_forwards, "Drag element right" },
          ["<M-r>"] = { paredit.api.drag_element_backwards, "Drag element left" },

          -- [">p"] = { paredit.api.drag_pair_forwards, "Drag element pairs right" },
          -- ["<p"] = { paredit.api.drag_pair_backwards, "Drag element pairs left" },

          -- ["<M-B>"] = { paredit.api.drag_form_forwards, "Drag form right" },
          -- ["<f"] = { paredit.api.drag_form_backwards, "Drag form left" },

          ["<M-w>"] = { paredit.api.raise_element, "Raise element" },
          -- ["<localleader>o"] = { paredit.api.raise_form, "Raise form" },
          ["<M-i>"] = {
            paredit.api.move_to_parent_form_start,
            "Jump to parent form's head",
            repeatable = false,
            mode = { "n", "x", "v" },
          },
          ["<M-o>"] = {
            paredit.api.move_to_parent_form_end,
            "Jump to parent form's tail",
            repeatable = false,
            mode = { "n", "x", "v" },
          },
          ["<M-n>"] = {
            paredit.api.move_to_prev_element_head,
            "Jump to next element head",
            repeatable = false,
            mode = { "n", "x", "o", "v" },
          },
          ["<M-s>"] = {
            paredit.api.move_to_next_element_head,
            "Jump to next element head",
            repeatable = false,
            mode = { "n", "x", "o", "v" },
          },
          ["<M-d>"] = {
            paredit.api.select_element,
            "Around element",
            repeatable = false,
            -- mode = { "o", "v" },
          },
        },
      })
    end
  },
  {
    -- review conjure by using `:ConjureSchool`
    -- uses `.config/clojure/deps.edn` to set nrepl & cider dependencies for all projects
    -- per:
    --  - https://github.com/Olical/conjure/wiki/Quick-start:-Clojure#start-your-nrepl--cider-middleware
    --  some extra keybinds
    --  - https://github.com/Olical/conjure/blob/a8686aa6f8760bd3cd4f219a8a4101af037c9d9b/doc/conjure-client-clojure-nrepl.txt
    "Olical/conjure",
    ft = clojure_filetype,
    init = function()
      -- this gives weird error, even though this is in the docs:
      --      https://github.com/Olical/conjure#lazynvim
      --      vim.g["conjure#mapping#doc_word"] = false
      -- vim.cmd("let g:conjure#mapping#doc_word = v:false")
      vim.cmd("let g:conjure#mapping#doc_word = \"ed\"")
      -- we remove this conjure option because it overwrites the LSP `K` hover
      -- and replaces it with `(doc <name>)`, which is less than ideal
      vim.cmd("let g:conjure#mapping#eval_root_form = \"eo\"")
      -- vim.cmd("<cmd>ConjureEval (do (require \'[clojure.tools.namespace.repl :refer [refresh]]) (refresh))<cr>")
      -- vim.cmd("let g:conjure#on-load = \"lua print(5)\"")
    end,
    -- dependencies must be included in the repl profile (.config/clojure/deps.edn) to be able to
    -- run some of these commands:
    keys = {
      -- tried a variety of commands to run tests and stuff... turns out there are some already provided:
      -- https://github.com/Olical/conjure/blob/a8686aa6f8760bd3cd4f219a8a4101af037c9d9b/doc/conjure-client-clojure-nrepl.txt
      --
      -- {
      --   "<leader>er",
      --   "<cmd>ConjureEval (dev/reset)<cr>",
      --   desc = "(reset)"
      -- },
      -- info about this command, here:
      -- https://github.com/clojure/tools.namespace
      -- {
      --   "<leader>eR",
      --   "<cmd>ConjureEval (do (require '[clojure.tools.namespace.repl :refer [refresh]]) (refresh))<cr>",
      --   desc = "(tools.namespace refresh)"
      -- },
      -- {
      --   "<leader>et",
      --   -- test suite, per:
      --   -- - https://github.com/cognitect-labs/test-runner
      --   "<cmd>ConjureEval (cognitect.test-runner.api/test test)<cr>", -- searches "test" directory
      --   desc = "(cognitect.test-runner.api/test)"
      -- }
      -- other default hotkeys not shown here, include:
      -- <leader>l ... display the repl logs
      -- <leader>lg ... toggle logs buffer
      -- <leader>em<mark> ... evaluate code at mark
      -- <leader>ew ... display variable contents
      -- <leader>E ... evaluate visual selections
      -- <leader>E<motion> ... evaluate in motion, such as Eab (around block with mini.ai from mini.nvim)
    }
  },
  {
    "tpope/vim-dispatch",
    enabled = false, -- not sure why I would need this
    ft = clojure_filetype
  },
  {
    "radenling/vim-dispatch-neovim",
    enabled = false, -- not sure why I would need this
    ft = clojure_filetype
  },
  {
    "clojure-vim/vim-jack-in",
    enabled = false, -- not sure why I would need this
    ft = clojure_filetype,
    config = function()
      vim.g.default_lein_task = "with-profile dev repl"
    end
  }
}
