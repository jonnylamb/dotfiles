;; -*- emacs-lisp -*-

(setq config-dir
      (file-name-as-directory
       (expand-file-name "config" user-emacs-directory)))
(add-to-list 'load-path config-dir)

(require 'dirs)

;; before all else
(require 'custom-functions)
(require 'custom-globals)

;; core stuff
(require 'utf8)
(require 'appearance)
(require 'x)
(require 'setup-desktop)
(require 'keybindings)
(require 'setup-packages)

;; languages
(require 'lang-c)
(require 'lang-sh)

;; vcs
(require 'setup-vcs)
(require 'setup-git)

;; formatting
(require 'behaviour)
(require 'setup-whitespace)

;; misc
(require 'personal)
