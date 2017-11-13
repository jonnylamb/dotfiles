;; -*- emacs-lisp -*-

(setq config-dir
      (file-name-as-directory
       (expand-file-name "config" user-emacs-directory)))

(defun load-config (name)
  (load (concat config-dir name ".el")))

(package-initialize)

;; set up directories to refer to later
(load-config "dirs")

;; before all else
(load-config "defuns")

;; package support
(load-config "packages")

;; core stuff
(load-config "utf8")
(load-config "x")
(load-config "desktop")
(load-config "appearance")
(load-config "ligatures")
(load-config "keybindings")
(load-config "behaviour")
(load-config "whitespace")

;; languages
(load-config "lang-c")
(load-config "lang-hs")
(load-config "lang-js")
(load-config "lang-sh")
(load-config "lang-scala")
(load-config "lang-thrift")

;; vcs
(load-config "vcs")
(load-config "git")

;; misc
(load-config "personal")
