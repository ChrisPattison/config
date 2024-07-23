(require 'package)
(package-initialize)

(eval-when-compile
  (require 'use-package))

(setq inhibit-startup-screen t)
;; =========== Theme =======

(setq custom-safe-themes t)

(use-package zenburn-theme
  :ensure t)
(use-package material-theme
  :ensure t)


(load-theme 'material-light t)

;; ======== Tex ========

(use-package auctex
	     :defer t
	     :init
	     (setq TeX-auto-save t)
	     (setq TeX-parse-self t)
	     (setq TeX-PDF-mode t)
	     (setq TeX-source-correlate-start-server t)
	     (setq-default TeX-master t)
	     (setq-default fill-column 120)
             (setq-default preview-scale-function 2)
	     (setq TeX-view-program-selection '((output-pdf "Zathura")))
	     (setq TeX-electric-math (cons "\\(" "\\)"))
	     (add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)
	     (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
	     ;; (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
	     (add-hook 'LaTeX-mode-hook 'visual-line-mode)
	     (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
	     :ensure t)
(use-package cdlatex
	     :ensure t)
(use-package yasnippet
	     :config
	     (yas-global-mode 1)
	     :ensure t)


;; ======== Misc Editor Config ===========

(use-package better-defaults
	     :ensure t)

(global-auto-revert-mode t)

(setq inhibit-startup-message t)

(setq make-backup-files nil)

(global-auto-revert-mode t)
(global-hl-line-mode t)
(delete-selection-mode t)
(global-display-line-numbers-mode t)

(use-package multiple-cursors
	     :ensure t)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-p") 'mc/mark-previous-like-this)

(use-package magit
	     :ensure t)

(use-package treemacs
	     :ensure t)

(use-package projectile
	     :ensure t)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; ======== Lean ========
;; (setq load-path (cons "~/.emacs.d/lean4-mode" load-path))
;; (use-package lean4-mode)
(use-package dash :ensure t)
(use-package f :ensure t)
(use-package flycheck :ensure t)
(use-package lsp-mode :ensure t)
(use-package magit-section :ensure t)
(use-package s :ensure t)

;; ========== Misc modes ======

(use-package rust-mode
	     :ensure t)
(use-package nix-mode
	     :ensure t)
;; (straight-use-package '(asy-mode
;; 	     :host github
;;              :files ("base/asy-mode.el")
;;              :repo "vectorgraphics/asymptote"))


;; ======== Python ========
(setq python-indent-offset 4)
(setq python-indent-guess-indent-offset nil)

;; (straight-use-package 'elpy)
;; (straight-use-package 'flycheck)
;; (straight-use-package 'blacken)
;; (elpy-enable)

;; ;; Use flycheck
;; (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;; (add-hook 'elpy-mode-hook 'flycheck-mode)

