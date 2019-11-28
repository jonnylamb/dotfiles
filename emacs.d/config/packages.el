;; -*- emacs-lisp -*-

(require 'package)

;; add melpa
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

;; only do this if the archive isn't already there as updates are boring.
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

;; now use use-package after this
(require 'use-package)

;; so :ensure isn't required everywhere
(setq use-package-always-ensure t)
