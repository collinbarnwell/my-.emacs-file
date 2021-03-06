(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(scroll-bar ((t (:background "steel blue" :foreground "spring green")))))
  (add-to-list 'load-path "/opt/neotree")
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Plugins list
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; melpa
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; ido
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;; Rails
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; (projectile-global-mode) ;; recommended, but idk why...
(add-hook 'ruby-mode-hook 'projectile-on)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; auto-completion in ruby
(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'company-complete)

;; completion stuff
(global-company-mode t)
(push 'company-robe company-backends)

(global-set-key (kbd "C-c r r") 'inf-ruby) ;; ruby shell inside emacs

;; comments
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-logical-line)))

(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)
(show-paren-mode 1) ;; highlight other parenthesis
(global-unset-key (kbd "C-z"))

;; Sass-mode
;; Add sass (and other gems?) to path
(setq exec-path (cons (expand-file-name "~/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems") exec-path))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(require 'scss-mode) ;; might not be necessary?
(add-hook 'scss-mode-hook 'flymake-mode)

;; fuzzy search file
(require 'git-find-file)
(global-set-key (kbd "C-x C-M-f") 'git-find-file)

;; MAY OR MAY NOT BE BROKEN BEYOND THIS POINT

;; tabs and spaces
(setq js-indent-level 2)

﻿(setq indent-tabs-mode nil) ;; tabs are spaces; comment out to set to tabs
