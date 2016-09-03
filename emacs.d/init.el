;; -*- emacs-lisp -*-

(setq config-dir
      (file-name-as-directory
       (expand-file-name "config" user-emacs-directory)))

(defun load-config (name)
  (load (concat config-dir name ".el")))

(load-config "dirs")

;; before all else
(load-config "defuns")

;; core stuff
(load-config "utf8")
(load-config "appearance")
(load-config "x")
(load-config "desktop")
(load-config "keybindings")
(load-config "packages")

;; languages
(load-config "lang-c")
(load-config "lang-sh")
(load-config "lang-lisp")
(load-config "lang-python")

;; vcs
(load-config "vcs")
(load-config "git")

;; formatting
(load-config "behaviour")
(load-config "whitespace")

;; misc
(load-config "personal")
