;; Following https://huytd.github.io/emacs-from-scratch.html

;; Making emacs find latex (so that C-c C-x C-l works on orgmode)
(setenv "PATH" "$PATH:/Library/TeX/texbin/" t)

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

(with-eval-after-load 'org
  (setq org-startup-indented t)
  (add-hook 'org-mode-hook #'visual-line-mode))


;; Configure the VC package to echo when we follow a symlink to the
;; real file, but don't prompt, which is the default
(setq vc-follow-symlinks t)

(setq use-package-always-ensure t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(setq python-shell-completion-native-enable nil)

(setq org-confirm-babel-evaluate nil)

(use-package htmlize)

(use-package ox-hugo
  :ensure t
  :after ox)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)

(add-to-list 'default-frame-alist '(font . "Source Code Pro-15"))
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
  (setq projectile-project-search-path '("~/Workspace"))
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package helm-projectile
             :ensure t
             :config
             (helm-projectile-on))

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
	   "f"   '(lambda() (interactive)(save-buffer))
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

(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                                (file+headline "~/Dropbox/org/inbox.org" "Tasks")
                                "* TODO %i%?")
                              ("T" "Tickler" entry
                                (file+headline "~/Dropbox/org/tickler.org" "Tickler")
                                "* %i%? \n %U")
                              ("w" "Weekly Journal" entry (file+olp+datetree "~/Dropbox/org/weekly-journal.org")
                                "* %?" :tree-type week)
                              ("j" "Journal" entry (file+olp+datetree "~/Dropbox/org/journal.org")
                                "** %?")
                              ))

(setq org-refile-targets '((nil :maxlevel . 4)
                           (org-agenda-files :maxlevel . 4)))

(setq org-outline-path-complete-in-steps nil)         ; Use helm for completion
(setq org-refile-use-outline-path 'file)              ; Show full paths for refiling

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "STARTED(s!)" "WAIT(w@/!)" "DELEGATED(g@/!)" "|" "DONE(d@/!)" "CANCELLED(l@/!)" "MIGRATED(m!)")))

(setq org-log-into-drawer t)

(setq org-catch-invisible-edits 'smart)

(setq org-startup-indented t)

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-cb" 'org-switchb)

(customize-set-variable 'org-directory "~/Dropbox/org")
(customize-set-variable 'org-agenda-files (list org-directory))

;; Save all org files after refiling or archiving
(advice-add 'org-refile :after 'org-save-all-org-buffers)
(advice-add 'org-archive-subtree :after 'org-save-all-org-buffers)

(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(require 'org-install)
(setq org-modules '(org-habit))
(org-load-modules-maybe t)

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (org-bullets-mode 1))))

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/Dropbox/roam"))

(use-package org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  :custom
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-dir "~/Dropbox/roam")
  (org-journal-date-format "%A, %d %B %Y"))

(use-package org-roam
  :after org
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Dropbox/roam")
  (org-roam-graph-executable "/usr/local/bin/dot")
  (org-roam-db-location "~/org-roam.db")
  :bind
  ("C-c n l" . org-roam)
  ("C-c n t" . org-roam-today)
  ("C-c n f" . org-roam-find-file)
  ("C-c n i" . org-roam-insert)
  ("C-c n g" . org-roam-graph))

(use-package org-ref)

(setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
         (("C-c n a" . orb-note-actions))))

(use-package org-cliplink
  :bind
  ("C-x p i" . org-cliplink))

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
