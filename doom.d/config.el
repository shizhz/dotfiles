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

(setq read-process-output-max (* 3 1024 1024))
(setq gc-cons-threshold 100000000)
; evil-snipe config
(evil-snipe-mode +1)
(evil-snipe-override-mode +1)
(push 'wdired-mode evil-snipe-disabled-modes)
(push 'dired-mode evil-snipe-disabled-modes)
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
      "C-S-H" #'evil-window-left
      "C-S-J" #'evil-window-down
      "C-S-K" #'evil-window-up
      "C-S-L" #'evil-window-right
      )
(define-key evil-insert-state-map (kbd "C-j") 'company-yasnippet) ;; Used to map to +default/newline
(define-key evil-insert-state-map (kbd "C-x C-s") 'save-buffer);; Used to map to company-yasnippet
(define-key evil-insert-state-map (kbd "C-k") 'kill-line) ;; Used to map to evil-insert-digraph

(map! :leader "SPC" #'counsel-M-x)
(map! :leader "p z" #'counsel-fzf)
(map! "<print>" #'+treemacs/toggle)
;; (map! :leader "o p" #'tremacs-display-current-project-exclusively)
(map! (:when (featurep! :completion company)
       (:after company
        (:map company-active-map
         "TAB"     #'company-complete-selection
         [tab]     #'company-complete-selection))))
                                        ;(define-key company-active-map (kbd "TAB") 'company-complete-selection)
                                        ;(define-key company-active-map (kbd "<tab>") 'company-complete-selection)
;; (define-key company-active-map (kbd "<return>") 'newline-and-indent) 
;; (define-key company-active-map (kbd "RET") 'newline-and-indent) 

(setq lsp-prefer-capf t)
(setq lsp-ui-sideline-show-hover nil)
(setq ivy-read-action-function #'ivy-hydra-read-action)

;; Auto-format after paste: https://discordapp.com/channels/406534637242810369/603399769015975996/714207056902619138
(defadvice! reindent-after-paste (&rest _)
  :after #'evil-paste-after
  (call-interactively #'+evil/reselect-paste)
  (call-interactively #'evil-indent))

;; golangci-lint config, refer to https://github.com/weijiangan/flycheck-golangci-lint for more details
(setq flycheck-golangci-lint-fast t)

(defhydra hydra-zoom (global-map "<f2>")  
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))


(defhydra hydra-window ()
  "window"
  ("h" windmove-left) 
  ("j" windmove-down) 
  ("k" windmove-up) 
  ("l" windmove-right) 
  ("H" +evil/window-move-left)
  ("L" +evil/window-move-right)
  ("J" +evil/window-move-down)
  ("K" +evil/window-move-up)
  ("n" evil-window-new)
  ("w" ace-window)
  ("v" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)
         "vert"
         ))
  ("s" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)
         "horz"
         ))
  ("x" +workspace/close-window-or-workspace)
  ("X" +workspace/close-window-or-workspace :color blue)
  ("c" ace-delete-window)
  ("1" delete-other-windows :color blue)
  ("f" +ivy/projectile-find-file :color blue)
  ("F" counsel-fzf :color blue)   
  ("b" counsel-projectile-switch-to-buffer :color blue)
  ("B" ivy-switch-buffer :color blue)
  ("t" projectile-toggle-between-implementation-and-test :color blue)
  ("<" evil-window-decrease-width)
  (">" evil-window-increase-width)
  ("+" evil-window-increase-height)
  ("-" evil-window-decrease-height)
  ("=" balance-windows)
  ("q" nil "quit")
  )

(define-key evil-normal-state-map (kbd ",w") #'hydra-window/body)

(defhydra hydra-jump ()
  "jump"
  ("o" #'avy-goto-word-1 :color blue)
  ("p" #'avy-goto-word-0 :color blue)
  ("i" #'avy-goto-symbol-1 :color blue)
  ("l" #'(lambda ()
           (interactive)
           (avy-goto-line)
           (recenter)))
  ("s" evil-snipe-s)
  ("S" evil-snipe-S)
  ("f" evil-snipe-f)
  ("F" evil-snipe-F)
  ("j" evil-snipe-repeat)
  ("k" evil-snipe-repeat-reverse)
  ("q" doom/escape :color blue)
  ) 

(setq evil-repeat-keys nil)                                                 
(define-key evil-normal-state-map [remap evil-snipe-s]  #'hydra-jump/body) ;; Remap evil-snip-s to hydra-snipe/body

(defhydra hydra-comment ()
  "comment"
  ("l" comment-line)
  ("d" comment-dwim)
  ("b" comment-box :color blue)
  ("r" comment-or-uncomment-region :colur blue)
  ("q" doom/escape :color blue)
  )

(define-key evil-normal-state-map (kbd ",c") #'hydra-comment/body)
(define-key evil-visual-state-map (kbd ",c") #'hydra-comment/body)

(defhydra hydra-select ()
  "select"
  ("s" er/expand-region)
  ("q" doom/escape :color blue)
  )

(define-key evil-normal-state-map (kbd ",s") #'hydra-select/body)

(whitespace-mode -1)
