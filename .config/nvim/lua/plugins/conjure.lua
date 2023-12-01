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
    "Olical/conjure",
    ft = clojure_filetype,
    init = function()
      -- this gives weird error, even though this is in the docs:
      --      https://github.com/Olical/conjure#lazynvim
      --      vim.g["conjure#mapping#doc_word"] = false
      vim.cmd("let g:conjure#mapping#doc_word = v:false")
      -- we remove this conjure option because it overwrites the LSP `K` hover
      -- and replaces it with `(doc <name>)`, which is less than ideal
      vim.cmd("let g:conjure#mapping#eval_root_form = \"eo\"")
    end,
    keys = {
      {
        "<leader>er",
        "<cmd>ConjureEval (dev/reset)<cr>",
        desc = "(reset)"
      },
      {
        "<leader>eR",
        "<cmd>ConjureEval (clojure.tools.namespace.repl/refresh)<cr>",
        desc = "(tools.namespace refresh)"
      }
    }
  },
  { "tpope/vim-dispatch",            ft = clojure_filetype },
  { "radenling/vim-dispatch-neovim", ft = clojure_filetype },
  {
    "clojure-vim/vim-jack-in",
    ft = clojure_filetype,
    config = function()
      vim.g.default_lein_task = "with-profile dev repl"
    end
  }
}
