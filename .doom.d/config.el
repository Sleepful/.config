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
(setq doom-unicode-font (font-spec :family "DejaVu Sans Mono"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-challenger-deep)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/organization/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
; (setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
(load! "bribri-mode")
(load! "supercollider")
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
;; Dotfiles
;; ----------------
; These ones match my bash aliases :)

(defun krc ()(interactive)(find-file "~/.config/kitty/kitty.conf"))
(defun prc ()(interactive)(find-file "~/.profile"))
(defun vrc ()(interactive)(find-file "~/.vimrc"))
(defun zrc ()(interactive)(find-file "~/.zshrc"))
;(setq-default transparent 'nil)
(defun transparent-emacs ()
  (interactive)
  (unless (display-graphic-p (selected-frame))
;    (cond (= transparent 'nil))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
; (add-hook 'window-setup-hook 'transparent-emacs)


;; ----------------
;; Shell
;; ----------------
(add-to-list 'term-file-aliases '("alacritty" . "xterm"))

;; ----------------
;; Layout
;; ----------------

(toggle-uniquify-buffer-names)
(setq-default frame-title-format '("%b ___> %f"))
(use-package doom-modeline
  :config
  (setq doom-modeline-buffer-file-name-style 'truncate-with-project))
(setq-default truncate-lines 'nil) ;; wrap lines by default
; emojify
;(add-hook 'after-init-hook #'global-emojify-mode)
; centered cursor
(add-hook 'after-init-hook #'global-centered-cursor-mode)
(use-package! centered-cursor-mode
  ;:init (setq mwheel-scroll-up-function 1 mwheel-scroll-down-function 1 mouse-wheel-mode 1) ; fix for terminal on `dev' branch, otherwise black-screen
  ;:config (setq ccm-recenter-at-end-of-file t)) ; this is useful for `master' branch of package, not `dev' branch
  )


; face
;; (font-lock-add-keywords nil '(("\\(\n\\)" 1 font-lock-warning-face t)))
;(custom-set-faces!
  ;'(hl-line :underline "light slate blue"
            ;;:background nil
            ;:distant-foreground "medium purple" )
  ;;'(solaire-hl-line-face :background nil)
  ;'(region :background "VioletRed4" :distant-foreground "green")
  ;'(line-number-current-line :foreground "cyan")
  ;'(solaire-mode-line-face :underline nil)
  ;'(solaire-mode-line-inactive-face :background "#190e22" :foreground "medium aquamarine")
  ;'(web-mode-interpolate-color1-face :foreground "peach puff")
  ;'(web-mode-javascript-string-face :foreground "medium aquamarine")
  ;)
;(after! hl-line (progn
                  ;(setq hl-line-sticky-flag t)
                  ;))
;(setq evil-normal-state-cursor '(box    "turquoise")
      ;evil-insert-state-cursor '(bar    "turquoise")
      ;evil-visual-state-cursor '(hollow "turquoise"))

;(setq evil-insert-state-cursor '(bar))

;; ----------------
;; Layout
;; ----------------
;

(use-package! uniquify
  :config (setq uniquify-buffer-name-style 'forward))

(use-package! whitespace
  :config (setq whitespace-style '(newline-mark newline)) (global-whitespace-mode))
;; (use-package! highlight-indent-guides
;;     :config (setq highlight-indent-guides-method 'column)
;;     (load-theme 'doom-one t)
;;     )
(defun set-indent-method () (setq highlight-indent-guides-method 'column))
(add-hook 'doom-load-theme-hook 'set-indent-method 10)
;; highlight-indent-guides only for yaml
;;(remove-hook! '(prog-mode-hook text-mode-hook conf-mode-hook) #'highlight-indent-guides-mode)
;;(add-hook 'yaml-mode-hook #'highlight-indent-guides-mode)

;; source: https://github.com/doomemacs/doomemacs/issues/4206#issuecomment-734414502
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

;; ----------------
;; projectile
;; ----------------
;
;; search for projects here
(setq projectile-project-search-path '("~/Code/" "~/Language/" "~/Code/Forks" "~/Notes"))
;; open dired on root folder after opening project with projectile (perhaps not working) https://docs.projectile.mx/projectile/configuration.html
;(setq projectile-switch-project-action #'projectile-dired)
; the following is a work-around per
; https://github.com/bbatsov/projectile/issues/1302#issuecomment-433894379
(setq projectile-git-submodule-command nil)

;; ----------------
;; Persp-mode
;; ----------------
;

;; create the "shell" perspective automatically for eshell buffers
(persp-def-auto-persp "shell" :buffer-name "doom:eshell")
(persp-def-auto-persp "new" :buffer-name "new")
;; balance windows automatically, becuz treemacs unbalances them
;; @Henrik: "Treemacs can't be persisted across workspaces, so it has to be closed. Which means you have a hole to fill."
;; it always balances windows tho, might be good to modify it to work only if treemacs is open or something
;(add-hook! 'persp-activated-functions
;  (defun rebalance-windows-after-switch (&rest _)
;    (balance-windows)
;    )
;  ) ; out of commission, add it only for treemacs buffers

;(remove-hook! 'persp-activated-functions rebalance-windows-after-switch)

;; ----------------
;; Eshell-mode
;; ----------------
;

;; this one renames your eshell buffers to the last command you typed in:
(defun rename-eshell-buffer ()
  (rename-buffer (buffer-substring-no-properties
            eshell-last-input-start
            (1- eshell-last-input-end))) )
(setq eshell-input-filter-functions 'rename-eshell-buffer)

;; ----------------
;; Forge : Magit Integration with Ghub
;; ----------------
;
;(use-package! forge :after magit)
(setq auth-sources '("~/.authinfo.gpg"))

;; ----------------
;; Magit config
;; ----------------
;

(add-hook! 'magit-mode-hook
  (transient-append-suffix 'magit-rebase "-d"
    '("-D" "Lie about author date" "--ignore-date")))

;;                                    ╳
;; ────────────────────────────────╮ ╱ ╲
;; Keybindings                     │╳ ! ╳
;; ────────────────────────────────╯ ╲ ╱
;;                                    ╳

;; ----------------
;; General
;; ----------------
;

; this one kinda is kinda lame
(map! :leader :desc "Search home directory" "s h"
      #'(lambda ()
          (interactive)
            (call-interactively
             (cond ((featurep! :completion ivy)
                    (+ivy-file-search
                      :in "~/"))
                   (#'rgrep)))))

; lame too
(map! :leader :desc "Search home directory" "f h"
     #'(lambda ()
         (interactive)
         (call-interactively
          (let ((default-directory "~/"))
            (counsel-find-file)))))

(map! :leader :desc "Search .bin directory" "f b"
     #'(lambda ()
         (interactive)
         (call-interactively
          (let ((default-directory "~/.bin/"))
            (counsel-find-file)))))

;; same as SPC p . though
(map! :leader :desc "Search projectile directory" "f w"
     #'(lambda ()
         (interactive)
         (call-interactively
          (let ((default-directory (or (projectile-project-root) default-directory)))
            (counsel-find-file)))))

; outline gets activated in elisp files
(map! :after outline
      :map outline-mode-map
      :n "M-j" nil ;
      :n "C-j" nil ; outline-forward-same-level
      :n "C-k" nil ; outline-backward-same-level
      )

;(map! :leader :desc "Search home directory" "f g"
     ;#'(lambda ()
         ;(interactive)
         ;(call-interactively
            ;(fd-dired "~/" ""))))
; doesn't work because macOS `ls' is from BSD, not coreutils, idk how to fix
; update: i think it's fixed, by itself, idk, so tired

;; ----------------
;; Org-mode keybindings & Config
;; ----------------
;

; add more convenient org-ctrl-c-minus to SPC-m--
(map! (:when (featurep! :lang org)
        (:map org-mode-map
          :localleader
          :desc "org-ctrl-c-minus" "-" #'org-ctrl-c-minus)))
; show empty lines at the end of a subtree when the trees are folded
(setq org-cycle-separator-lines 1)
(setq org-src-fontify-natively t)
;(use-package! org-mode :config
              ;(org-babel-do-load-languages 'org-babel-load-languages '((sh . t))))

;; ----------------
;; Elixir keybindings
;; ----------------
;
(map! :after alchemist
      :map alchemist-mode-map
      :n "C-j" nil ; alchemist-goto-jump-to-next-def-symbol
      :n "C-k" nil ; alchemist-goto-jump-to-previous-def-symbol
      )

;; ----------------
;; Magit keybindings
;; ----------------
;

(defun commit-pull-push ()
  (interactive)
  (magit-call-git "add" ".")
  (magit-call-git "commit" "-m" "automatic commit")
  (magit-call-git "pull")
  (magit-call-git "push")
  (magit-refresh))

(map! :leader "g p" 'commit-pull-push)

;; ----------------
;; Navigation keybindings
;; ----------------
;

; Terminal
;----------
(map! :when (eq (display-graphic-p) nil) :n "C-i" #'better-jumper-jump-forward)
(map! :when (eq (display-graphic-p) nil) :leader "<escape>" #'evil-switch-to-windows-last-buffer)

; GUI
;-----
(map! :leader "w a" #'ace-window)
(map! :leader "ESC" #'evil-switch-to-windows-last-buffer) ; to use with my cute keyboard
(defun save-bury-buffer () (interactive) (save-buffer) (evil-switch-to-windows-last-buffer) (+workspace/display))
;; file path
(map! "M-}" '+default/yank-buffer-path)
(map! "M-]" '+default/yank-buffer-path-relative-to-project)
;; workspace
(map! :leader ; "b w"
      :desc "Save buffer and switch" "b w"
      #'save-bury-buffer)
(map! ; "M-/" #'+workspace/switch-right   ; rm dabbrev-expand
      "M-'" #'+workspace/switch-right   ; rm abbrev-prefix-mark
      )
(map! "M-;" #'+workspace/switch-left    ; rm comment-dwim
      )
(map! :leader
      "]" #'+workspace/switch-right
      "[" #'+workspace/switch-left)
(map! :n
      "}" #'+workspace/switch-right
      :n
      "{" #'+workspace/switch-left)
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
(map! :m "C-h" ; rm help (spc h k)
      #'(lambda (number) (interactive "P")
             (evil-backward-char (* 16 (or number 1)))
        ))
(map! :m "C-l" ; rm recenter-top-bottom
      #'(lambda (number) (interactive "P")
             (evil-forward-char (* 16 (or number 1)))
        ))
(map! :m "C-k" ; rm kill line
      #'(lambda (number) (interactive "P")
             (evil-previous-line (* 4 (or number 1)))
        ))
(map! :m "C-j" ; rm +default/newline
      #'(lambda (number) (interactive "P")
             (evil-next-line (* 4 (or number 1)))
        ))
(map! :m "C-e"
      #'(lambda (number) (interactive "P")
             (evil-next-line (* 8 (or number 1)))
        ))
(map! :m "C-y"
      #'(lambda (number) (interactive "P")
             (evil-previous-line (* 8 (or number 1)))
        ))
(map! :leader
      :desc "Up"
      :m "k"
      #'(lambda (number) (interactive "P")
             (evil-previous-line (* 16 (or number 1)))
        ))
(map! :leader
      :m "j"
      #'(lambda (number) (interactive "P")
             (evil-next-line (* 16 (or number 1)))
        ))
(map! :leader
      :desc "Up"
      :m "K"
      #'(lambda (number) (interactive "P")
             (evil-previous-line (* 18 (or number 1)))
        ))
(map! :leader
      :desc "Down"
      :m "J"
      #'(lambda (number) (interactive "P")
             (evil-next-line (* 18 (or number 1)))
        ))
(map!
 :i "C-k" #'evil-previous-line
 :i "C-j" #'evil-next-line
 :i "C-h" #'left-char
 :i "C-l" #'right-char
      )

;; keybindings lost:
; C-j +default/newline
; C-K evil-insert-digraph
; C-h describe-key-briefly
; C-l recenter-top-bottom

(map! ;switch mark set and mark travel
 :n "m" #'evil-goto-mark
 :n "M" #'evil-set-marker
 :n "C-m" #'evil-set-marker
 :n "`" #'evil-set-marker)

;; ----------------
;; Code edit
;; ----------------
;
(after! web-mode
  :config
  ;; Rewriting the default +web/indent-or-yas-or-emmet-expand function:
  (defun +web/indent-or-yas-or-emmet-expand ()
    "Do-what-I-mean on TAB.
Invokes `indent-for-tab-command' if at or before text bol, `yas-expand' if on a
snippet, or `emmet-expand-yas'/`emmet-expand-line', depending on whether
`yas-minor-mode' is enabled or not."
    (interactive)
    (call-interactively
     (if (yas--templates-for-key-at-point)
         #'yas-expand
       (cond ((or (<= (current-column) (current-indentation))
                  (not (eolp))
                  (not (or (memq (char-after) (list ?\n ?\s ?\t))
                           (eobp))))
              #'indent-for-tab-command)
             ((featurep! :editor snippets)
              (require 'yasnippet)
              (if (yas--templates-for-key-at-point)
                  #'yas-expand
                #'emmet-expand-yas))
             (#'emmet-expand-line))))))


(map! :map emmet-mode-keymap :i "TAB" #'+web/indent-or-yas-or-emmet-expand)
; for above to work nicely, below does stuff:
; https://github.com/smihica/emmet-mode/issues/64
(use-package! yasnippet
  :config
  (setq yas-snippet-revival nil))

(use-package! evil-snipe
  :config
  (setq evil-snipe-spillover-scope 'whole-buffer))

; helpful macros for map-keybindings and keybindings:
(defmacro insertchar (char)
  `(lambda ()
          (interactive)
          (self-insert-command 1 ',char))
  )

(defmacro keybindings ()
  `(map! (:prefix-map ("'" . "shortcuts")
      :iro
      ,@(mapcan (lambda (pair)
          (list (car pair)
                `(insertchar ,@(cdr pair))))
        map-keybindings))))
(defconst
  map-keybindings '(
                    ("j" ?\()
                    ("k" ?\))
                    ("i" ?\[)
                    ("o" ?\])
                    ("n" ?\{)
                    ("m" ?\})
                    ("x" ?<)
                    ("c" ?>)
                    ("d" ?.)
                    ("a" ?\*)
                    ("b" ?\\)
                    ("g" ?\/)
                    ("q" ?\?)
                    ("y" ?\&)
                    ("u" ?\|)
                    ("s" ?\")
                    ("v" ?\')
                    ("f" ?\`)
                    ("'" ?\')
                   ; (";" ?\;)
                    ("3" ?\#)
                    ))

; put all the 'map-keybindings behind the
; prefix defined in (keybindings)
(keybindings)

; to reset a key:
; (map! :i "g" (insertchar ?\g))

; Example of the keybindings macro expansion:
;(map!
;; :prefix-map is necessary to avoid error over :prefix
;      (:prefix-map ("g" . "shortcuts")
;      :i
;      "g"
;      (insertchar ?g)
;      "j"
;      (insertchar ?\()
;      "k"
;      (insertchar ?\))))


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

; center always, similar to `set scrolloff=999' in vim
;(setq scroll-margin 99)
;(setq maximum-scroll-margin 0.49)
; ----> use centered-cursor-mode instead

; center cursor when searching with `evil-ex-search-next'
(advice-add 'evil-ex-search-next :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
(advice-add 'evil-ex-search-previous :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
(advice-add 'evil-ex-search-forward :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
; center cursor when jumping to a mark
(advice-add 'evil-goto-mark :after
            (lambda (&rest _x) (evil-scroll-line-to-center (line-number-at-pos))))
; quicker line up/down, commented lines are the same thing but remap remaps everywhere
;(map! :m "C-y" (cmd!! #'evil-scroll-line-up 4)
;      :m "C-e" (cmd!! #'evil-scroll-line-down 4))
;(map! [remap evil-scroll-line-up] (cmd!! #'evil-scroll-line-up 8)
;      [remap evil-scroll-line-down] (cmd!! #'evil-scroll-line-down 8))
; commented remap this time, due to centered-cursor-mode

(after! evil-escape (progn
                      (setq-default evil-escape-key-sequence "jk")
                      (setq-default evil-escape-unordered-key-sequence t)))


; Little snippet to zoom in globally, evaluate in scratch buffer or here:
; (set-face-attribute 'default nil :height 150)

; This advice makes zoom/scaling affect every buffer.
; Source: https://stackoverflow.com/a/18784131/2446144
;(defadvice text-scale-increase (around all-buffers (arg) activate)
;  (dolist (buffer (buffer-list))
;    (with-current-buffer buffer
;      ad-do-it)))

;; ----------------
;; keybinding ideas to implement
;; ----------------

; search word on cursor position, going to the top of the file first
; search word on cursor position
; snippets are missing
; open window with current buffer to given side, close buffer in previous window
; g as leader key in insert mode for symbols, replace ;

;; ----------------
;; MacOS keybindings
;; ----------------
;

(setq mac-command-modifier 'control) ; turn CMD into CTRL inside emacs
(setq mac-control-modifier 'super) ; turn CTRL into CMD inside emacs

;; ----------------
;; Web keybindings
;; ----------------
;

; tide jump to definition
; js2 jump to definition

;; ----------------
;; Web configuration
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
;(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js-jsx-mode))
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-jsx-mode))
;
; eelixir :/
;(add-to-list 'auto-mode-alist '("\\.html\.eex\\'"  . elixir-mode))
;(setq web-mode-engines-alist
;      '(("elixir" . "\\.html\\.eex\\'")))
(add-to-list 'auto-mode-alist '("\\.js\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'"  . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-tsx-mode))
;(add-hook 'js-jsx-mode-hook 'lsp!)
;(add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "typescriptreact"))
;(add-hook 'js-jsx-mode-hook 'lsp-mode)
;(add-hook 'lsp-mode-hook 'lsp)

; Lsp mode configuration (if it is used)
; ----------------------
;
(use-package! lsp-mode
  :commands lsp
  ; on startup:
  ; Ignoring ’:ensure t’ in ’lsp-mode’ config
  ;:ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  ; update elixir version if needed:
  (add-to-list 'exec-path "~/Code/GitBuilds/elixir-ls-1.13")
  ;(add-to-list 'exec-path "~/Code/GitBuilds/elixir-ls-1.13" "~/go/bin/gopls")
  )
(after! lsp-mode (add-to-list
   'lsp-language-id-configuration
   '(( web-mode . "typescriptreact" )
     ( js-jsx-mode . "typescriptreact" )
    )))
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


;; Eglot
; ----------------------
;
; commented until turned on through init.el with (lsp +eglot)
;(add-to-list 'eglot-server-programs '(web-mode . ("js-ts-ls.sh")))

;; web mode
; ----------------------
;
(use-package! web-mode
  :commands web-mode-set-engine
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)



  )

(setq web-mode-content-types-alist
  '(("json" . "\\.api\\'")
    ("xml"  . "\\.api\\'")
    ("jsx"  . "\\.js[x]?\\'")))

; do not use js2 minor with web mode
;(add-hook 'web-mode-hook 'js2-minor-mode)

; web-mode formatting options:
(use-package! flycheck
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode)) ; allow flycheck to be enabled on web-mode with javascript-eslint checker)


;; Emmet mode
; ----------------------
;
(setq emmet-expand-jsx-className? t) ;; default nil, expands class attributes to "className" instead of "class"

;; Tide mode (from their README)
; ----------------------
;

;(flycheck-add-next-checker 'typescript-tide 'javascript-eslint)

(use-package! tide
  :after flycheck
  :config
  (flycheck-add-next-checker
   'typescript-tide
   'javascript-eslint)
)

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
;(add-hook 'before-save-hook 'tide-format-before-save) ; removed because I'm using prettier and it generates conflict
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'typescript-mode-hook #'emmet-mode)
;(add-hook 'js-jsx-mode-hook #'setup-tide-mode)
(add-hook 'typescript-mode-hook #'prettier-mode)
(add-hook 'web-mode-hook #'prettier-mode)
; for .js files (ts-mode won't launch)
(add-hook 'rjsx-mode-hook #'prettier-mode)

;; end of Tide mode setup -------

;; super cool figure out import

(defun import-pls ()
  (interactive)
  (insert-for-yank
    (concat
     "import { } from '"
     (file-name-sans-extension
      (file-relative-name
        (read-string "Import from: ")
       (file-name-directory
       (or
        (file-relative-name (buffer-file-name (buffer-base-buffer)) (doom-project-root))
        (read-string "Import into: ")))
       ))
     "'")))


(add-hook 'emacs-lisp-mode 'parinfer-rust-mode)
(add-hook 'clojure-mode 'parinfer-rust-mode)
