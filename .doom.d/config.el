;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
; (setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; DOOM !!!

;; always emojify mode
(add-hook 'after-init-hook #'global-emojify-mode)

;; search for projects here
(setq projectile-project-search-path '("~/Code/" "~/Language/" "~/Code/Forks"))
;; open dired on root folder after opening project with projectile
(setq projectile-switch-project-action #'projectile-dired)


;; keybindings
(map! :leader "w a" #'ace-window)
(defun save-bury-buffer () (interactive) (save-buffer) (evil-switch-to-windows-last-buffer) (+workspace/display))
(map! :leader ; "b w"
      :desc "Save buffer and switch" "b w"
      #'save-bury-buffer)
(map! "M-]" #'+workspace/switch-right)
(map! "M-[" #'+workspace/switch-left)
(map! :leader
      :desc "Swap left" "TAB j"
      #'+workspace/swap-left)
(map! :leader
      :desc "Swap right" "TAB k"
      #'+workspace/swap-right)
(map! "M-p" #'+workspace/display)

;; layout config
(setq-default truncate-lines 'nil) ;; wrap lines by default

;; Web stuff!
; commented out because web-mode on js/jsx files does not support lsp/xref/flycheck ...etc
; (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable web mode for .js/.jsx files
; (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))) ;; associate jsx files with web-mode jsx

(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode)) ;; auto-enable web mode for css

(use-package! web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

;; these arent working
; (eval-after-load 'flycheck
;   '(flycheck-add-mode 'javascript-jshint 'web-mode))
