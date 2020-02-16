;; Following https://huytd.github.io/emacs-from-scratch.html

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")))

(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(let* ((org-dir (expand-file-name
		 "lisp" (expand-file-name
			 "org" (expand-file-name
				"src" dotfiles-dir))))
       (org-contrib-dir (expand-file-name
			 "lisp" (expand-file-name
				 "contrib" (expand-file-name
					    ".." org-dir))))
       (load-path (append (list org-dir org-contrib-dir)
			  (or load-path nil))))
  ;; load up Org-mode and Org-babel
  (require 'org-install)
  (require 'ob-tangle))

;; Configure the VC package to echo when we follow a symlink to the
;; real file, but don't prompt, which is the default
(setq vc-follow-symlinks t)

(setq use-package-always-ensure t)

(use-package ox-hugo
  :ensure t
  :after ox)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)

(add-to-list 'default-frame-alist '(font . "Source Code Pro-13"))
(add-to-list 'default-frame-alist '(height . 81))
(add-to-list 'default-frame-alist '(width . 157))

;; Match titlebar colour to theme on Emacs >= 26 on OSX
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

;; Automatically update buffers when files change on disk
(global-auto-revert-mode t)

;; Vim mode
(setq evil-want-C-u-scroll t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-org
  :ensure t)

(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package all-the-icons :ensure t)

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
	helm-mode-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-candidate-number-list 150
	helm-split-window-in-side-p t
	helm-move-to-line-cycle-in-source t
	helm-echo-input-in-header-line t
	helm-autoresize-max-height 0
	helm-autoresize-min-height 20)
  :config
  (helm-mode 1))

(use-package helm-fuzzy-find
  :ensure t
  :init)

(global-set-key (kbd "M-x") 'helm-M-x)

(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(global-set-key (kbd "C-x b") 'helm-mini)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(use-package magit
  :ensure t)

(use-package git-gutter
  :ensure t)

;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; NeoTree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

(use-package markdown-mode
  :ensure t)

(use-package edit-server
  :ensure t
  :config
  (edit-server-start)
  (add-hook 'edit-server-start-hook 'markdown-mode))

(define-key key-translation-map (kbd "M-3") (kbd "#"))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;; Custom keybinding
(use-package general
  :ensure t
  :config (general-define-key
	   :states '(normal visual insert emacs)
	   :prefix "SPC"
	   :non-normal-prefix "M-SPC"
	   ;; "/"   '(counsel-rg :which-key "ripgrep") ; You'll need counsel package for this
	   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
	   "SPC" '(helm-M-x :which-key "M-x")
	   "f"   '(save-buffer)
	   "ed"  '(lambda() (interactive)(find-file "~/.emacs.d/init.el"))
	   "pf"  '(helm-find-files :which-key "find files")
	   ;; Buffers
	   "bb"  '(helm-buffers-list :which-key "buffers list")
	   ;; Window
	   "wl"  '(windmove-right :which-key "move right")
	   "wh"  '(windmove-left :which-key "move left")
	   "wk"  '(windmove-up :which-key "move up")
	   "wj"  '(windmove-down :which-key "move bottom")
	   "w/"  '(split-window-right :which-key "split right")
	   "w-"  '(split-window-below :which-key "split bottom")
	   "wx"  '(delete-window :which-key "delete window")
	   ;; Others
	   "at"  '(ansi-term :which-key "open terminal")
	   "]h"  '(git-gutter:next-hunk :which-key "next hunk")
	   "[h"  '(git-gutter:previous-hunk :which-key "previous hunk")
	   ))

;; Magit global key bindings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(global-git-gutter-mode +1)

(use-package org
  :ensure org-plus-contrib
  :pin org
  :bind
  ("\C-cl" . org-store-link)
  ("\C-ca" . org-agenda)
  ("\C-cc" . org-capture)
  ("\C-cb" . org-switchb)
  :init
  (setq org-default-notes-file (concat org-directory "/notes.org")
	org-capture-templates '(("t" "Todo [inbox]" entry
				 (file+headline "~/Dropbox/org/inbox.org" "Tasks")
				 "* TODO %i%?")
				("T" "Tickler" entry
				 (file+headline "~/Dropbox/org/tickler.org" "Tickler")
				 "* %i%? \n %U")
				("w" "Weekly Journal" entry (file+olp+datetree "~/Dropbox/org/weekly-journal.org")
				 "* %?" :tree-type week)
				("m" "Monthly Journal" entry (file+olp+datetree "~/Dropbox/org/monthly-journal.org")
				 "** %?")
				)
	org-refile-targets '((nil :maxlevel . 4)
			     (org-agenda-files :maxlevel . 4))
	org-outline-path-complete-in-steps nil         ; Use helm for completion
	org-refile-use-outline-path 'file              ; Show full paths for refiling

	org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "STARTED(s!)" "WAIT(w@/!)" "DELEGATED(g@/!)" "|" "DONE(d!)" "CANCELLED(l@)"))

	org-log-into-drawer t

	org-catch-invisible-edits 'smart
	org-startup-indented t
	)

  (define-key global-map "\C-cc" 'org-capture)

  (customize-set-variable 'org-directory "~/Dropbox/org")
  (customize-set-variable 'org-agenda-files (list org-directory))

  :custom
  ;; Save all org files after refiling or archiving
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (advice-add 'org-archive-subtree :after 'org-save-all-org-buffers)

  (add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
  (add-hook 'org-mode-hook 'turn-on-auto-fill))

(require 'org-install)
(setq org-modules '(org-habit))
(org-load-modules-maybe t)

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (org-bullets-mode 1))))

(use-package deft
  :bind ("C-c D" . deft)
  :config (setq deft-directory "~/Dropbox/deft"
		deft-default-extension "org"
		deft-use-filter-string-for-filename t
                deft-extensions '("md" "org")))

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
