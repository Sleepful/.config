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


;####################################
;#                                  #
;#   Personal config starts here    #
;#                                  #
;####################################

;; ----------------
;; Layout
;; ----------------
(setq-default truncate-lines 'nil) ;; wrap lines by default
; emojify
(add-hook 'after-init-hook #'global-emojify-mode)
;(add-hook 'after-init-hook #'global-hl-line-mode)
; hl-line-mode
;(remove-hook! (prog-mode text-mode conf-mode special-mode) #'hl-line-mode) ;remove hook from hl-line-mode to use my own
;(set-face-attribute hl-line-face nil :underline t :foreground nil :background nil)
;(custom-set-faces! '(hl-line-face :background nil :underline t))
;(add-hook! 'doom-load-theme-hook
;  (set-face-attribute 'hl-line nil :background nil :underline t)
;  (set-face-attribute 'hl-line-face nil :underline t)
;  (set-face-attribute 'global-hl-line-sticky-flag t)
;   (setq hl-line-sticky-flag 't)
(custom-set-faces!
  '(hl-line :underline "#8470ff" :background nil)
  '(solaire-hl-line-face :background nil)
  )
(after! hl-line (progn
                  (setq hl-line-sticky-flag t)
                  (set-face-attribute 'hl-line nil :background nil)))
;(set-face-attribute 'hl-line nil :background nil)
;(set-face-attribute 'hl-line-sticky-flag t)
;(setq global-hl-line-sticky-flag t)
;(setq hl-line-sticky-flag 't)
;(defvar hl-line-sticky-flag 'f)
;   (setq hl-line-sticky-flag 't)
;(add-hook hl-line-mode-hook '(setq hl-line-sticky-flag 't))


;; ----------------
;; projectile
;; ----------------
;
;; search for projects here
(setq projectile-project-search-path '("~/Code/" "~/Language/" "~/Code/Forks"))
;; open dired on root folder after opening project with projectile (perhaps not working) https://docs.projectile.mx/projectile/configuration.html
(setq projectile-switch-project-action #'projectile-dired)


;; ----------------
;; keybindings
;; ----------------
;
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
(map! :leader
      :desc "Last workspace" "TAB e"
      #'+workspace/other)
(map! "M-p" #'+workspace/display)
(map! :leader
      :desc "Last window" "w e"
      #'evil-window-mru)
(map! :desc "Paste below"
      :n "] p"
      #'(lambda () (interactive)
          (evil-insert-newline-below)
          (insert (current-kill 0))))
(map! :desc "Paste above"
      :n "[ p"
      #'(lambda () (interactive)
          (evil-insert-newline-above)
          (insert (current-kill 0))))
(map! :leader
      :desc "Up"
      :m "k"
      #'(lambda () (interactive)
             (evil-previous-line 6)
             ;(evil-scroll-line-to-center (line-number-at-pos))
        ))
(map! :leader
      :desc "Down"
      :m "j"
      #'(lambda () (interactive)
             (evil-next-line 6)
             ;(evil-scroll-line-to-center (line-number-at-pos))
        ))

;; ----------------
;; Web stuff!
;; ----------------
;
; commented out because web-mode on js/jsx files does not support lsp/xref/flycheck ...etc
; (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable web mode for .js/.jsx files
; (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))) ;; associate jsx files with web-mode jsx

;; Auto-enable modes for files

; (setq modes '(
;               '("\\.css?\\'" . web-mode)
;               '("\\.jsx\\'" . js-jsx-mode)
;               '("\\.tsx\\'" . js-jsx-mode)
;               ))
; (dolist (elt modes)
;   (add-to-list 'auto-mode-alist elt))

;(let ((correlations '(
;                       '("\\.css?\\'" . web-mode)
;                       '("\\.jsx\\'" . js-jsx-mode)
;                       '("\\.tsx\\'" . js-jsx-mode)
;                       )
;                     ))
;  (dolist (elt correlations)
;    (add-to-list 'auto-mode-alist elt))
;  )


; Major modes to turn on
; ----------------------
;
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js-jsx-mode))
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" .  web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;(add-hook 'js-jsx-mode-hook 'lsp!)
;(add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "typescriptreact"))
;(add-hook 'js-jsx-mode-hook 'lsp-mode)
;(add-hook 'lsp-mode-hook 'lsp)

; Lsp mode configuration (if it is used)
; ----------------------
;
(defvar lsp-language-id-configuration '(( web-mode . "typescriptreact" )( js-jsx-mode . "typescriptreact" ))) ;configuration of the lsp-mode to identify language-id:
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; js-jsx-mode: the baked-in emacs mode, new to emacs 27
; ----------------------
;
(add-hook 'js-jsx-mode-hook 'js2-minor-mode) ; not using this but just in case

;; LSP or TIDE
; ----------------------
;
;(add-hook 'web-mode-hook 'lsp!)
(add-hook 'web-mode-hook 'setup-tide-mode)

;; web mode
; ----------------------
;
(use-package! web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(setq web-mode-content-types-alist
  '(("json" . "\\.api\\'")
    ("xml"  . "\\.api\\'")
    ("jsx"  . "\\.js[x]?\\'")))

(add-hook 'web-mode-hook 'js2-minor-mode)

;; Tide mode (from their README)
; ----------------------
;
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  )

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;(add-hook 'js-jsx-mode-hook #'setup-tide-mode)

;; end of Tide mode setup -------


;; tide and webmode stuff
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;(add-hook 'web-mode-hook
;          (lambda ()
;            (when (string-equal "jsx" (file-name-extension buffer-file-name))
;              (setup-tide-mode))))

;; configure jsx-tide checker to run after your default jsx checker
;(flycheck-add-mode 'javascript-eslint 'web-mode)
;(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

;; these arent working
; (eval-after-load 'flycheck
;   '(flycheck-add-mode 'javascript-jshint 'web-mode))

;; ----------------
;; Evil mode
;; ----------------
;
;; The following snippet will make Evil treat an Emacs symbol as a word, useful for 'w' movements
;; in words with special symbols like 'foo-bar'
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

; by default `evil-show-marks' (SPC-s-r) opens `counsel-mark-ring' (because of doom remapping)
; instead we want to open `counsel-evil-marks'
(use-package! counsel
  :init
  (define-key!
    [remap evil-show-marks]          #'counsel-evil-marks
  ))

; center cursor when searching with `evil-ex-search-next'
(advice-add 'evil-ex-search-next :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
(advice-add 'evil-ex-search-previous :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
(advice-add 'evil-ex-search-forward :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
; quicker line up/down, commented lines are the same thing but remap remaps everywhere
;(map! :m "C-y" (cmd!! #'evil-scroll-line-up 4)
;      :m "C-e" (cmd!! #'evil-scroll-line-down 4))
(map! [remap evil-scroll-line-up] (cmd!! #'evil-scroll-line-up 8)
      [remap evil-scroll-line-down] (cmd!! #'evil-scroll-line-down 8))

(after! evil-escape (progn
                      (setq-default evil-escape-key-sequence "jk")
                      (setq-default evil-escape-unordered-key-sequence t)))
