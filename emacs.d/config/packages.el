;; -*- emacs-lisp -*-

(require 'package)

;; remove gnu
(setq package-archives nil)

;; add melpa
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; go
(package-initialize)

;; only do this if the archive isn't already there as updates are boring.
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

;; now use use-package after this
(require 'use-package)
(setq use-package-always-ensure t)
