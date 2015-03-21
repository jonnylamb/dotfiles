; -*- emacs-lisp -*-

; give a newline and indent when return is pressed
(global-set-key (kbd "RET") 'newline-and-indent)

; delete text in selection just by typing
(delete-selection-mode 1)

; home and end refer to buffer
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
