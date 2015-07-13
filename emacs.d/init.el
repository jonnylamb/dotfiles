;; -*- emacs-lisp -*-

(setq config-dir
      (file-name-as-directory
       (expand-file-name "config" user-emacs-directory)))

(load (concat config-dir "dirs.el"))

;; before all else
(load (concat config-dir "defuns.el"))
(load (concat config-dir "globals.el"))

;; core stuff
(load (concat config-dir "utf8.el"))
(load (concat config-dir "appearance.el"))
(load (concat config-dir "x.el"))
(load (concat config-dir "desktop.el"))
(load (concat config-dir "keybindings.el"))
(load (concat config-dir "packages.el"))

;; languages
(load (concat config-dir "lang-c.el"))
(load (concat config-dir "lang-sh.el"))
(load (concat config-dir "lang-lisp.el"))
(load (concat config-dir "lang-python.el"))

;; vcs
(load (concat config-dir "vcs.el"))
(load (concat config-dir "git.el"))

;; formatting
(load (concat config-dir "behaviour.el"))
(load (concat config-dir "whitespace.el"))

;; misc
(load (concat config-dir "personal.el"))
