;; -*- emacs-lisp -*-

(setq config-dir
      (file-name-as-directory
       (expand-file-name "config" user-emacs-directory)))

(defun load-config (name)
  (load (concat config-dir name ".el")))

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
(load-config "keybindings")
(load-config "server")
(load-config "behaviour")
(load-config "whitespace")
(load-config "lsp")

;; languages
(load-config "lang-c")
(load-config "lang-go")
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
