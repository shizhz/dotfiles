;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here, run 'doom sync' on
;; the command line, then restart Emacs for the changes to take effect.
;; Alternatively, use M-x doom/reload.


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))
(package! prettier-js)
;; (package! flow-minor-mode)
;(use-package rime
;              :custom
;              (default-input-method "rime"))
(package! magit-section)
;; 2022-02-10: doom upgrade 之后magit 无法正常工作，提示函数 magit--version>= 非法，参见：https://github.com/hlissner/doom-emacs/issues/5935
(package! code-review :disable t)

(package! rime :recipe
          (:host github
          :repo "DogLooksGood/emacs-rime"
          :files ("*.el" "Makefile" "lib.c")))
(setq default-input-method "rime")
;(use-package rime
;  :straight (rime :type git
;                  :host github
;                  :repo "DogLooksGood/emacs-rime"
;                  :files ("*.el" "Makefile" "lib.c"))
;  :custom
;  (default-input-method "rime"))

(package! org-super-agenda)
(package! org-ref)
(package! org-bullets)
(package! protobuf-mode)
;; (package! doc;; t
 ;;   :recipe (:host github :repo "progfolio/doct")
   ;; :pin "dabb30ebea..."
  ;; )

;; https://github.com/tecosaur/lexic
;; (package! lexic :recipe (:host github :repo "tecosaur/lexic"))

(package! lsp-java)

(package! dap-mode)
;; (package! dap-java)
;; (package! dap-go)
