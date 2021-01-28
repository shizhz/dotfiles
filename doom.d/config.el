;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

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
;; (setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Work/Self/org")

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
;; (setq frame-title-format '(buffer-file-name "%f" (dired-directory dired-directory "%b")))
(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
     ("http" . "localhost:7890")
     ("https" . "localhost:7890")))

;; (setq which-key-idle-delay 0)
;; (setq which-key-idle-secondary-delay 0)

;; (setq lsp-log-io 1)
;; (setq lsp-print-performance 1)
(setq doom-themes-treemacs-theme "doom-colors")
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%F %a>" . "<%F %a %r>"))
(setq org-log-done 'time)

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

(after! go-mode
  (add-hook! 'before-save-hook
             #'lsp-format-buffer
             #'lsp-organize-imports))

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
;; (define-key evil-insert-state-map (kbd "C-x C-s") 'save-buffer);; Used to map to company-yasnippet
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
(setq lsp-file-watch-threshold 20000)

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
  ("w" ace-window :color blue)
  ("v" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right))
   "vert")
  ("V" clone-indirect-buffer-other-window :color blue)
  ("s" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down))
   "horz")
  ("e" kill-current-buffer)
  ("x" +workspace/close-window-or-workspace)
  ("X" +workspace/close-window-or-workspace :color blue)
  ("c" ace-delete-window)
  ("1" delete-other-windows :color blue)
  ("f" +ivy/projectile-find-file :color blue)
  ("F" counsel-fzf :color blue)   
  ("o" counsel-find-file :color blue)
  ("d" dired :color blue)
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

(defun szz/dired-jump-below ()
  (interactive)
  (split-window-below)
  (windmove-down)
  (dired-jump))

(defun szz/dired-jump-right ()
  (interactive)
  (split-window-right)
  (windmove-right)
  (dired-jump))

(map! :leader
      "d j" #'szz/dired-jump-below
      "d l" #'szz/dired-jump-right)

(whitespace-mode -1)
(global-prettify-symbols-mode t)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-todo-keywords 
      '((sequence "TODO(t)" "DOING(i)" "BLOCKED(b)" "HOLD(h)" "|" "DONE(d)" "CANCELED(c)")
       (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")))
(setq org-todo-keyword-faces
      '(("[-]" . +org-todo-active)
       ("DOING" . +org-todo-active)
       ("[?]" . +org-todo-onhold)
       ("WAIT" . +org-todo-onhold)
       ("HOLD" . +org-todo-onhold)
       ("BLOCKED" . +org-todo-onhold)
       ("PROJ" . +org-todo-project)))
(setq org-hide-emphasis-markers t)
(add-hook! 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; go-mode key bindings
(define-key global-map (kbd "C-M-t") #'projectile-toggle-between-implementation-and-test)
(setq projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

(setq rime-user-data-dir "~/.config/fcitx/rime")
(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            ;; :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))
(setq rime-title "中")
(define-key global-map (kbd "M-s-SPC") #'toggle-input-method)
(define-key evil-insert-state-map (kbd "M-s-j") #'rime-force-enable) ;
(define-key evil-insert-state-map (kbd "M-s-k") #'rime-inline-ascii) ;
(setq rime-disable-predicates
      '(rime-predicate-evil-mode-p
        rime-predicate-ace-window-p
        rime-predicate-hydra-p
        rime-predicate-space-after-cc-p
        rime-predicate-auto-english-p
        rime-predicate-current-uppercase-letter-p
        rime-predicate-prog-in-code-p))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)
(global-unset-key (kbd "C-\\"))

;; Javascript config
(after! tide
  (setq tide-completion-detailed t
        tide-always-show-documentation t)
  )

(setq prettier-js-args '(
                         "--trailing-comma" "none"
                         "--parser" "flow"
                         "--semi" "false"
                         "--tab-width" "2"
                         "--use-tabs" "false"
                         ))
(add-hook! (rjsx-mode js2-mode)
           #'(prettier-js-mode ;; flow-minor-enable-automatically
                               ))

(setq ivy-sort-max-size 50000)

(sp-local-pair
 '(org-mode)
 "<<" ">>"
 :actions '(insert))

;; yas config
(setq yas-triggers-in-field t)

;; treemacs

(after! treemacs
  (defvar treemacs-file-ignore-extensions '()
    "File extension which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-globs '()
    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-regexps '()
    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
  (defun treemacs-file-ignore-generate-regexps ()
    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
  (defun treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (let ((ignore-file nil))
          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))

;; (setq treemacs-file-ignore-extensions
;;       '(;; LaTeX
;;         "aux"
;;         "ptc"
;;         "fdb_latexmk"
;;         "fls"
;;         "synctex.gz"
;;         "toc"
;;         ;; LaTeX - glossary
;;         "glg"
;;         "glo"
;;         "gls"
;;         "glsdefs"
;;         "ist"
;;         "acn"
;;         "acr"
;;         "alg"
;;         ;; LaTeX - pgfplots
;;         "mw"
;;         ;; LaTeX - pdfx
;;         "pdfa.xmpi"
;;         ))
;; (setq treemacs-file-ignore-globs
;;       '(;; LaTeX
;;         "*/_minted-*"
;;         ;; AucTeX
;;         "*/.auctex-auto"
;;         "*/_region_.log"
;;         "*/_region_.tex"))


(global-visual-line-mode)
(blink-cursor-mode)
;; (global-term-cursor-mode)
(setq-default fill-column 80)
;; (add-hook! 'text-mode-hook 'auto-fill-mode)

;; DON'T use (`font-family-list'), it's unreliable on Linux
;; (when (find-font (font-spec :name "Sarasa Mono SC Nerd"))
;; (setq doom-font (font-spec :family "Sarasa Mono SC Nerd" :size 16)
;;       doom-variable-pitch-font (font-spec :family "Sarasa Mono SC Nerd")
;;       doom-unicode-font (font-spec :family "Sarasa Mono SC Nerd")
;;       doom-big-font (font-spec :family "Sarasa Mono SC Nerd" :size 20))
;;   )

;; 使用等距更纱黑体解决org-mode中table对齐问题， 参考 https://emacs-china.org/t/org-mode/440/103
;; 1. 安装字体：sudo pacman -S ttf-sarasa-gothic
;; 2. 安装nerd字体补丁：https://github.com/laishulu/Sarasa-Mono-SC-Nerd
;;    下载ttf文件copy到~/.local/share/fonts/目录，然后执行fc-cache -vf
;; 3. 使用如下配置，参考 https://github.com/laishulu/conf/blob/master/emacs/doom/ui.el
;; Notes： 改变字体大小可能又对不齐了，据说是因为中英文不同的font-size导致的，还没有找到原因

(defun +szz/set-font()
  (setq doom-font (font-spec :family "Sarasa Mono SC Nerd" :size 16)
        doom-variable-pitch-font (font-spec :family "Sarasa Mono SC Nerd")
        doom-unicode-font (font-spec :family "Sarasa Mono SC Nerd")
        doom-big-font (font-spec :family "Sarasa Mono SC Nerd" :size 20))
  )

;; (defun +szz|init-font(frame)
;;   (with-selected-frame frame
;;     (if (display-graphic-p)
;;         (+szz/set-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (if (display-graphic-p)
                      (+szz/set-font))
                  ))))
(+szz/set-font)
;; 去掉 file-icons, 否则 "言" 字显示不正确，参考：https://emacs-china.org/t/emacs/13669/15
(setq doom-unicode-extra-fonts (remove "file-icons" doom-unicode-extra-fonts))

(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))
;; highlight-indent-guides
(setq highlight-indent-guides-suppress-auto-error t)

;; 配置 org -> pdf 转换，默认 pdflatex 不支持中文，使用 xelatex. 使用前先：sudo pacman -S texlive-latexextra
;; 其他讨论见：https://emacs-china.org/t/latex/4820/19
;; (setq org-latex-pdf-process
;;       '(
;;         "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "rm -fr %b.out %b.log %b.tex auto"
;;         ))
;; ;; 设置默认后端为 `xelatex'
;; (setq org-latex-compiler "xelatex")
