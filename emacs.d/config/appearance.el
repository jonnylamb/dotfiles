; -*- emacs-lisp -*-

; theme
(when jonny/submodules
  (progn
    (add-to-list 'custom-theme-load-path (concat jonny/themes-base-dir "monokai"))
    (load-theme 'monokai t)))

; font
(set-default-font "Inconsolata-11")

; no line numbers
(global-linum-mode 0)

; display the column number in the bottom
(column-number-mode t)

; use "y" and "n" instead of "yes" and "no"
(fset 'yes-or-no-p 'y-or-n-p)

; no scrollbar
(scroll-bar-mode -1)

; more misc
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message "jonny")

; syntax highlighing
(global-font-lock-mode t)
(font-lock-mode 1)

; stop the cursor blinking
(blink-cursor-mode 0)

; no tooltips
(if window-system
    (tooltip-mode 0))

; no toolbar
(if window-system
    (tool-bar-mode 0))

; no menu bar
(menu-bar-mode 0)

; don't show a cursor if the window isn't selected
(setq cursor-in-non-selected-windows nil)
