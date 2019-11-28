;; -*- emacs-lisp -*-

(use-package dante
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'dante-mode)
  (add-hook 'haskell-mode-hook 'flycheck-mode))

(add-hook 'dante-mode-hook
          '(lambda () (flycheck-add-next-checker 'haskell-dante
                                                 '(warning . haskell-hlint))))
