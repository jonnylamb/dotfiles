;; -*- emacs-lisp -*-

;; use the X clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(provide 'x)
