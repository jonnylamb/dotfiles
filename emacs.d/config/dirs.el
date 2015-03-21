; -*- emacs-lisp -*-

; set where submodules are
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)

; set themes dir
(setq jonny/themes-base-dir
      (expand-file-name (file-name-as-directory "themes") user-emacs-directory))
