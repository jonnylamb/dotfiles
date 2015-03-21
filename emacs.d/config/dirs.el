;; -*- emacs-lisp -*-

;; set where submodules are
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)

;; add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; set themes dir
(setq themes-dir
      (expand-file-name (file-name-as-directory "themes") user-emacs-directory))

;; add external themes to load path
(dolist (theme (directory-files themes-dir t "\\w+"))
  (when (file-directory-p theme)
    (add-to-list 'custom-theme-load-path theme)))

;; keep custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
