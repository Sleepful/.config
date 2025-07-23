;; extends
; https://github.com/julienvincent/nvim-paredit/blob/master/docs/language-queries.md
; https://github.com/6cdh/tree-sitter-racket/blob/main/nodes.md
( comment )  @comment
( block_comment ) @comment
( sexp_comment ) @comment

( graph ) @form
( structure ) @form
( hash )  @form
; ( quote ) @form
; ( quasiquote ) @form
; ( syntax ) @form
; ( quasisyntax ) @form
; ( unquote ) @form
; ( unquote_splicing ) @form
; ( unsyntax ) @form
; ( unsyntax_splicing ) @form

( list ) @form
( vector ) @form
