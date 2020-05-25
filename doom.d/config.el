;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zhz SHI"
      user-mail-address "messi.shizz@gmail.com")

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
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; (setq which-key-idle-delay 0.5)
;; (setq which-key-idle-secondary-delay 0)
(setq frame-title-format '(buffer-file-name "%f" (dired-directory dired-directory "%b")))
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
     ("http" . "localhost:7890")
     ("https" . "localhost:7890")))

;; (setq which-key-idle-delay 0)
;; (setq which-key-idle-secondary-delay 0)

;; (setq lsp-log-io 1)
;; (setq lsp-print-performance 1)
(setq doom-themes-treemacs-theme "doom-colors")

(global-undo-tree-mode)

;; evil-snipe config
(evil-snipe-mode +1)
(evil-snipe-override-mode +1)
(push 'wdired-mode evil-snipe-disabled-modes)
(push 'magit-mode evil-snipe-disabled-modes)
(push '(?\[ "[[({]") evil-snipe-aliases)
(setq evil-snipe-scope 'buffer)

(add-hook! 'before-save-hook
           #'lsp-format-buffer
           #'lsp-organize-imports)

;; key bindings
(map! "C-s" #'counsel-grep-or-swiper
      "C-M-[" #'+evil/previous-beginning-of-method 
      "C-M-]" #'+evil/next-beginning-of-method 
      )
(map! :leader "SPC" #'counsel-M-x)

(setq lsp-ui-sideline-show-hover nil)

(undo-tree-mode)
