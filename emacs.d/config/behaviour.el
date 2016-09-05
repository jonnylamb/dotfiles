;; -*- emacs-lisp -*-

;; wrap lines automatically, like M-q
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'debian-changelog-mode-hook 'turn-on-auto-fill)

;; tabs off by default
(setq-default indent-tabs-mode nil)

;; save location of cursor
(require 'saveplace)
(setq save-place-file (expand-file-name "saved-places" user-emacs-directory))
(setq-default save-place t)

;; offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))
(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)

;; enable linum-mode only after having called goto-line
;; http://whattheemacsd.com/key-bindings.el-01.html
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))
(global-set-key [remap goto-line] 'goto-line-with-feedback)

;; use shell path
(use-package exec-path-from-shell
  :if 'jonny/is-mac
  :config
  (exec-path-from-shell-initialize))

;; automatically close brackets
(use-package smartparens
  :diminish smartparens-mode
  :commands smartparens-strict-mode smartparens-mode sp-restrict-to-pairs-interactive sp-local-pair
  :init
  (setq sp-interactive-dwim t)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)

  (sp-pair "(" ")" :wrap "C-(") ;; how do people live without this?
  ;; (sp-pair "[" "]" :wrap "s-[") ;; C-[ sends ESC
  (sp-pair "{" "}" :wrap "C-{")

  (smartparens-global-mode))
