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
(defun c-mode-semantic-hook ()
  (progn
    (set-default 'semantic-case-fold t)
    (global-semanticdb-minor-mode 1)
    (global-semantic-idle-scheduler-mode 1)
    (semantic-mode 1)))

(jonny/when-installed
 'semantic
 (add-hook 'c-mode-common-hook 'c-mode-semantic-hook))

;; code completion
(defun c-mode-company-hook ()
  (progn
    ;; disable autocompletion
    (setq company-idle-delay nil)
    (company-mode)
    (local-set-key (kbd "M-/") 'company-complete)))

(jonny/when-installed
 'company
 (add-hook 'c-mode-common-hook 'c-mode-company-hook))
