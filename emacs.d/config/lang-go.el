;; -*- emacs-lisp -*-

;; from https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

(add-hook 'go-mode-hook 'lsp-deferred)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
