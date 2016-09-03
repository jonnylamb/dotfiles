;; -*- emacs-lisp -*-

;; telepathy coding style
;; http://telepathy.freedesktop.org/wiki/Style
(c-add-style
 "telepathy"
 '("gnu"
   (indent-tabs-mode . nil)
   (c-offsets-alist
    (arglist-intro . 4)
    (arglist-cont-nonempty . 4))))

;; gtk+ style
(c-add-style
 "gtk"
 '("gnu"
   (indent-tabs-mode . nil)))

;; wayland style
(c-add-style
 "wayland"
 '("linux"
   (indent-tabs-mode . t)))

;; use wayland style by default
(setq c-default-style "gtk")

;; close brackets automatically
(add-hook 'c-mode-common-hook 'electric-pair-mode)

;; cedet
(set-default 'semantic-case-fold t)

(defun c-mode-semantic-hook ()
  (progn
    (global-semanticdb-minor-mode 1)
    (global-semantic-idle-scheduler-mode 1)
    (local-set-key (kbd "M-.") 'semantic-ia-fast-jump)
    (semantic-mode t)))

(require 'semantic)
(add-hook 'c-mode-common-hook 'c-mode-semantic-hook)

;; code completion
(use-package company
  :config
  (setq company-idle-delay nil))

(defun c-mode-company-hook ()
  (progn
    ;; disable autocompletion
    (company-mode)
    (local-set-key (kbd "M-/") 'company-complete)))

(add-hook 'c-mode-common-hook 'c-mode-company-hook)
