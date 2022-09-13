;; ======= Straight =========

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

;; (setq backup-directory-alist
;;       `((".*" . "~/.saves")))
;; (setq auto-save-file-name-transforms
;;       `((".*" "~/.saves" t)))


;; =========== Theme =======

(straight-use-package 'zenburn-theme)
(straight-use-package 'material-theme)
(load-theme 'material t)

;; ======== Tex ========

(straight-use-package 'auctex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(setq TeX-source-correlate-start-server t)
(setq-default TeX-master t)
(setq-default fill-column 120)
(setq TeX-view-program-selection '((output-pdf "Zathura")))

(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; ======== Misc Editor Config ===========

(straight-use-package 'better-defaults)

(setq inhibit-startup-message t)
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
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; ========== Misc modes ======

(straight-use-package 'rust-mode)
(straight-use-package 'nix-mode)


;; ======== Python ========

(straight-use-package 'elpy)
(straight-use-package 'flycheck)
(straight-use-package 'blacken)
(elpy-enable)

;; Use flycheck
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode)
