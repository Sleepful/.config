;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; im using prettier, worked better
(package! prettier)
;; i don't remember the issue with prettier-js
;; but yeah
(package! prettier-js)
(package! import-js)
(package! emojify)
(package! rainbow-delimiters)
(package! yaml-mode)
(package! raku-mode)
(package! pyim)
(package! centered-cursor-mode
  :recipe (:host github :repo "andre-r/centered-cursor-mode.el"
           :branch "dev" :build (:not compile)))

;; super collider! Let the good boops roll.
(package! sclang-mode :recipe (:host github :repo "supercollider/scel" :files ("el/*.el")))
(package! w3m)

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;; ;(package! another-package
;; ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; ;(package! this-package
;; ;  :recipe (:host github :repo "username/repo"
;; ;           :files ("some-file.el" "src/lisp/*.el")))
(package! tide
  :recipe (:host github :repo "ananthakumaran/tide"
           :branch "master"))
;; ;(package! straight
;; ;  :recipe `(:host github
;; ;            :repo "raxod502/straight.el"
;; ;            :branch ,straight-repository-branch
;; ;            :local-repo "straight.el"
;; ;            :files ("straight*.el"))
;; ;  :pin "728ea18ea590fcd8fb48f5bed30e135942d97221")

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; ;(package! builtin-package :disable t)
;; ;(package! tide :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; ;(package! builtin-package :recipe (:nonrecursive t))
;; ;(package! builtin-package-2 :recipe (:repo "myfork/package"))
(package! format-all :recipe
  (:host github :repo "Sleepful/emacs-format-all-the-code" :branch "master" :build (:not compile)))
(package! evil :pin "5ce46a1fc175a8f13507ce2b6ec4c3618923f093")
(package! straight :pin "3eca39d")

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;; ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; ;(unpin! pinned-package)
;; ...or multiple packages
;; ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; ;(unpin! t)
(unpin! tide)
(unpin! format-all)
;; ;(unpin! straight)
