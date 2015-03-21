; -*- emacs-lisp -*-

; core stuff
(load "~/.emacs.d/config/dirs.el")
(load "~/.emacs.d/config/utf8.el")
(load "~/.emacs.d/config/appearance.el")
(load "~/.emacs.d/config/x.el")
(load "~/.emacs.d/config/desktop.el")
(load "~/.emacs.d/config/keys.el")
(load "~/.emacs.d/config/server.el")

; languages
(load "~/.emacs.d/config/c.el")
(load "~/.emacs.d/config/sh.el")

; vcs
(load "~/.emacs.d/config/vcs.el")
(load "~/.emacs.d/config/git.el")

; formatting
(load "~/.emacs.d/config/formatting.el")
(load "~/.emacs.d/config/whitespace.el")

; misc
(load "~/.emacs.d/config/personal.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0eebf69ceadbbcdd747713f2f3f839fe0d4a45bd0d4d9f46145e40878fc9b098" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
