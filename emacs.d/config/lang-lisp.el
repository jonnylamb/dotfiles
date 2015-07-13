;; -*- emacs-lisp -*-

;; close brackets automatically
(add-hook 'emacs-lisp-common-hook 'electric-pair-mode)
(add-hook 'lisp-interaction-common-hook 'electric-pair-mode)
(add-hook 'lisp-common-hook 'electric-pair-mode)
