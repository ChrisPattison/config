;; ======= Straight =========

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously

        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.silent"
         'el 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; (setq backup-directory-alist
;;       `((".*" . "~/.saves")))
;; (setq auto-save-file-name-transforms
;;       `((".*" "~/.saves" t)))

(setq straight-vc-git-default-protocol 'https)

;; =========== Theme =======

(straight-use-package 'zenburn-theme)
(straight-use-package 'material-theme)
(load-theme 'material t)

;; ======== Tex ========

(straight-use-package 'auctex)
(straight-use-package 'cdlatex)
(straight-use-package 'yasnippet)
(yas-global-mode 1)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(setq TeX-source-correlate-start-server t)
(setq-default TeX-master t)
(setq-default fill-column 120)
(setq TeX-view-program-selection '((output-pdf "Zathura")))

(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;; (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(setq TeX-electric-math (cons "\\(" "\\)"))

;; ======== Misc Editor Config ===========

(straight-use-package '(better-defaults :host nil :repo "https://git.sr.ht/~technomancy/better-defaults"))

(global-auto-revert-mode t)
(setq inhibit-startup-message t)

(setq make-backup-files nil)

(global-auto-revert-mode t)
(global-hl-line-mode t)
(delete-selection-mode t)
(global-linum-mode t)

(straight-use-package 'multiple-cursors)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-p") 'mc/mark-previous-like-this)

(straight-use-package 'magit)

(straight-use-package 'treemacs)

(straight-use-package 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; =========== Org =========

(straight-use-package 'org)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(add-hook 'org-mode-hook #'turn-on-org-cdlatex)

(setq org-pretty-entities t)
(setq org-log-done t)

;; ========== Misc modes ======

(straight-use-package 'rust-mode)
(straight-use-package 'nix-mode)
(straight-use-package '(asy-mode
	     :host github
             :files ("base/asy-mode.el")
             :repo "vectorgraphics/asymptote"))


;; ======== Python ========

(straight-use-package 'elpy)
(straight-use-package 'flycheck)
(straight-use-package 'blacken)
(elpy-enable)

;; Use flycheck
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode)
