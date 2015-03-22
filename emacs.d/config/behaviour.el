;; -*- emacs-lisp -*-

;; wrap lines automatically, like M-q
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'debian-changelog-mode-hook 'turn-on-auto-fill)

;; tabs off by default
(setq-default indent-tabs-mode nil)
