;; -*- emacs-lisp -*-

;; don't use tabs in shell scripts
(add-hook 'sh-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'shell-script-mode-hook (lambda () (setq indent-tabs-mode nil)))
