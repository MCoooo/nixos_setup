;; Install straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Shouldnt do this!!
(setq warning-minimum-level :emergency)

;; Install use-package
(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(use-package straight
  :custom
  (straight-use-package-by-default t))

;; stop create backup~ files
(setq make-backup-files nil)

;;; Garbage collection
;; Increase the GC threshold for faster startup
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;;; UI configuration
;; Remove some unneeded UI elements (the user can turn back on anything they wish)
(setq inhibit-startup-message t)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)


;; general settings
(setq initial-scratch-message nil)

;; Don’t compact font caches during GC.
(setq inhibit-compacting-font-caches t)

;; Set up the visible bell
(setq visible-bell t)

;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative)

; (column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (set-face-attribute 'default nil :font "Fira Code Retina" :height 118)
;; (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 118)

(set-face-attribute 'default nil
  :font "Fira Code Nerd Font"
  :height 144
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Hasklig"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono"
  :height 118
  :weight 'medium)

;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
;; (set-face-attribute 'font-lock-comment-face nil
;;   :slant 'italic)
;; (set-face-attribute 'font-lock-keyword-face nil
;;   :slant 'italic)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package all-the-icons)

(use-package doom-themes
  :init (load-theme 'doom-henna t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :bind (:map evil-normal-state-map
	      ("gc" . evil-commentary)))

(use-package anzu
  :ensure t
  :hook (after-init . global-anzu-mode)
  :diminish
  :init
  (setq anzu-mode-lighter ""))

(use-package evil-anzu
  :ensure t
  :after (evil anzu))


(use-package drag-stuff
  :ensure t
  :diminish drag-stuff-mode
  :config
  (drag-stuff-global-mode t)
  (drag-stuff-define-keys))

(use-package ivy
       :diminish
       :bind (("C-s" . swiper)
       		:map ivy-minibuffer-map
       		("TAB" . ivy-alt-done)
       		("C-l" . ivy-alt-done)
       		("C-j" . ivy-next-line)
       		("C-k" . ivy-previous-line)
	        :map ivy-switch-buffer-map
	        ("C-k" . ivy-previous-line)
	        ("C-l" . ivy-done)
	        ("C-d" . ivy-switch-buffer-kill)
	        :map ivy-reverse-i-search-map
	        ("C-k" . ivy-previous-line)
	        ("C-d" . ivy-reverse-i-search-kill))
	:config
	(ivy-mode 1))

(use-package ivy-rich
	:after ivy
	:init
	(ivy-rich-mode 1))


(use-package counsel
       :bind (("C-M-s" . 'counsel-switch-buffer)
       :map minibuffer-local-map
       ("C-r" . 'counsel-minibuffer-history))
       :custom
       (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
       :config
       (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package hydra
  :defer t)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; (require 'org-habit)
  ;; (add-to-list 'org-modules 'org-habit)
  ;; (setq org-habit-graph-column 60)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)"))))

  ;; (setq org-refile-targets
  ;;   '(("Archive.org" :maxlevel . 1)
  ;;     ("Tasks.org" :maxlevel . 1))))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; (defun efs/org-mode-visual-fill ()
;;   (setq visual-fill-column-width 100
;;         visual-fill-column-center-text t)
;;   (visual-fill-column-mode 1))

;; (use-package visual-fill-column
;;   :hook (org-mode . efs/org-mode-visual-fill))
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  ;; (when (file-directory-p "/AXAXL/general_repos")
  (setq projectile-project-search-path '("/AXAXL/general_repos" "C:/Users/x124129/OneDrive - AXAXL/Dev/Scripts" "C:/Users/x124129/OneDrive - AXAXL/Dev/src"))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))


(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(add-hook 'dired-mode-hook
      (lambda ()
        ;; Set dired-x buffer-local variables here.  For example:
        (dired-omit-mode 1)
        ))

(setq confirm-kill-emacs 'y-or-n-p)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer mc/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (mc/leader-keys
    "b" '(:ignore t :wk "buffer/browse")
    "bb" '(switch-to-buffer :wk "Switch buffer")
    "bk" '(kill-this-buffer :wk "Kill this buffer")
    "bn" '(next-buffer :wk "Next buffer")
    "bp" '(previous-buffer :wk "Previous buffer")
    "br" '(revert-buffer :wk "Reload buffer")
    "bw" '(eww :wk "EWW open"))

  (mc/leader-keys
    "f" '(:ignore t : "file")
    "ff" '(find-file :wk "Find file")
    "fr" '(counsel-recentf :wk "Recent files")
    "fP" '(lambda () (interactive) (find-file "~/.emacs.d/init.el") :wk "Configs"))

  (mc/leader-keys
    "h" '(:ignore t :wk "help")
    "ht" '(load-theme :wk "Load theme"))

  (mc/leader-keys
    "," '(switch-to-buffer :wk "Switch buffer")
    "." '(counsel-recentf :wk "Recent files")
    "y" '(evil-yank :wk "Yank")
    "p" '(evil-paste-after :wk "Paste")))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode)
  (let ((lsp-keymap-prefix "C-c l"))
  (lsp-enable-which-key-integration)))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :bind (:map lsp-mode-map
    ("C-c C-d" . lsp-describe-thing-at-point))
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-enable-indentation t)
  ; (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  ;; (lsp-ui-sideline-show-hover y)
  (lsp-ui sideline-enable t)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-sideline-show-flycheck t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-code-actions t))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package go-mode
  :mode "\\.go\\'")
  ; :hook (go-mode-hook . lsp-deferred))

(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)
            (setq indent-tabs-mode 1)))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
;; (defun lsp-go-install-save-hooks ()
;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)

(yas-global-mode t) ;; activate yasnippet

(use-package rust-mode
   :mode "\\.rs'"
   :hook 'rust-mode-hook
   :config
  (setq rust-format-on-save t))
(add-hook 'rust-mode-hook #'lsp-deferred)

(use-package powershell-mode
  :mode "\\.ps1\\'"
  :hook (powershell-mode . lsp-deferred)
  :config
  (setq lsp-powershell-exe "powershell")
  (setq lsp-powershell-args '("-NoLogo" "-NoProfile" "-NonInteractive" "-Command" "Microsoft.PowerShell.EditorServices.Hosting.dll")))

; (add-hook 'powershell-mode
;           (lambda ()
;             (setq tab-width 2)
;             (setq indent-tabs-mode 1)))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	    ("<tab>" . company-select-next)
	    ("S-<tab>" . company-select-previous)
	    ("<ret>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.0))

(use-package ripgrep)

;; (grep-apply-setting
;;    'grep-find-command
;;    ;; '("rg -n -H --no-heading -e '' " . 27))
;;    '("rg ''"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(go-ts-mode-indent-offset 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
