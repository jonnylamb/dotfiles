; -*- emacs-lisp -*-

; set where submodules are
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)

; set themes dir
(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))
