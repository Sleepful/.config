;; per https://github.com/supercollider/scel/issues/30#issuecomment-648689971
;;
;; First:
;;
;; $ cd ~/.emacs.d/.local/straight/repos/scel/sc
;; $ cmake .. -DSC_EL=ON
;; $ make
;; $ sudo make install
;;
;; Then this will work:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/SuperCollider")
(require 'sclang)
;(custom-set-variables
;'(sclang-auto-scroll-post-buffer t)
;'(sclang-eval-line-forward nil)
;;'(sclang-help-path (quote ("/Applications/SuperCollider/Help")))
;;'(sclang-runtime-directory "~/.sclang/"))
;'(sclang-runtime-directory "/Applications/SuperCollider.app/Contents/MacOS"))
