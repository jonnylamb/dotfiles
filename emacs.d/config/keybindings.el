;; -*- emacs-lisp -*-

;; give a newline and indent when return is pressed
(global-set-key (kbd "RET") 'newline-and-indent)

;; delete text in selection just by typing
(delete-selection-mode 1)

;; home and end refer to buffer
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

;; expand region
(jonny/when-installed
 'expand-region
 (global-set-key (kbd "C-=") 'er/expand-region))

;; multiple cursors
(jonny/when-installed
 'multiple-cursors
 (progn
   (global-set-key (kbd "C->") 'mc/mark-next-like-this)
   (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
   (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)))

;; smex
(jonny/when-installed
 'smex
 (progn
   (smex-initialize)
   (global-set-key (kbd "M-x") 'smex)))

(provide 'keybindings)
