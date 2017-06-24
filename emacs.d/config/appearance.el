;; -*- emacs-lisp -*-

;; set theme
(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))

;; font
(set-default-font "Fira code-14")

;; no line numbers
(global-linum-mode 0)

;; display the column number in the bottom
(column-number-mode t)

;; use "y" and "n" instead of "yes" and "no"
(fset 'yes-or-no-p 'y-or-n-p)

;; no scrollbar
(scroll-bar-mode -1)

;; more misc
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message "jonny")

;; syntax highlighing
(global-font-lock-mode t)
(font-lock-mode 1)

;; stop the cursor blinking
(blink-cursor-mode 0)

;; no tooltips
(tooltip-mode 0)

;; no toolbar
(tool-bar-mode 0)

;; no menu bar
(menu-bar-mode 0)

;; don't show a cursor if the window isn't selected
(setq cursor-in-non-selected-windows nil)

;; show current function
(which-function-mode t)

;; show matching parens
(show-paren-mode t)

;; only have one space at sentence ends
(setq sentence-end-double-space nil)

;; auto revert unmodified buffers
(global-auto-revert-mode 1)

;; don't defer screen updates when performing operations
(setq redisplay-dont-pause t)
