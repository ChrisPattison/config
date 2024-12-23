;; http://alhassy.com/ElispCheatSheet/CheatSheet.pdf
;; (when (not (featurep 'typst-ts-mode))
;;   ((package-vc-install '(typst-ts-mode :url "https://codeberg.org/meow_king/typst-ts-mode.git"))
;;    (typst-ts-mc-install-grammar)))
(add-to-list 'exec-path "/Users/chris/.nix-profile/bin")

;; ======== Typst ========

(with-eval-after-load 'eglot
  (with-eval-after-load 'typst-ts-mode
    (add-to-list 'eglot-server-programs
                 `((typst-ts-mode) .
                   ("tinymist")))))
(setq-default eglot-workspace-configuration
              '(:tinymist (:exportPdf "onSave")))

(add-hook 'typst-ts-mode-hook 'eglot-ensure)



;; ======== Lean ========

;; (package-vc-install '(lean4-mode :url "https://github.com/leanprover-community/lean4-mode.git"))
(require 'lean4-mode)
(setq-default lsp-headerline-breadcrumb-enable t)

