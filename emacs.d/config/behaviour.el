;; -*- emacs-lisp -*-

;; wrap lines automatically, like M-q
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'debian-changelog-mode-hook 'turn-on-auto-fill)

;; tabs off by default
(setq-default indent-tabs-mode nil)

;; save location of cursor
(require 'saveplace)
(setq save-place-file (expand-file-name "saved-places" user-emacs-directory))
(setq-default save-place t)
