; -*- emacs-lisp -*-

; show tabs and stuff
(require 'whitespace)
(global-whitespace-mode t)
(setq whitespace-global-modes '(c-mode c++-mode sh-mode emacs-lisp-mode))
(setq whitespace-style '(face tabs spaces trailing space-before-tab empty space-after-tab::tab space-mark tab-mark))
