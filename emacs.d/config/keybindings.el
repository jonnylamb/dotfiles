;; -*- emacs-lisp -*-

;; give a newline and indent when return is pressed
(global-set-key (kbd "RET") 'newline-and-indent)

;; delete text in selection just by typing
(delete-selection-mode 1)

;; home and end refer to buffer
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

;; expand region
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; multiple cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; smex
(use-package smex
  :bind ("M-x" . smex))

;; iy-go-to-char
(use-package iy-go-to-char
  :bind (("C-c f" . iy-go-to-char)
         ("C-c F" . iy-go-to-char-backward))
  :config
  (add-to-list 'mc/cursor-specific-vars 'iy-go-to-char-start-pos))

;; jumping around files
(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

;; mac stuff
(when 'jonny/is-mac
  (setq mac-command-modifier 'meta))
