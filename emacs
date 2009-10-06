; -*- emacs-lisp -*-
;

(message "loading .emacs-standard")
(load "~/.emacs-standard")

(setq vc-follow-symlinks t)

(require 'jka-compr)
(auto-compression-mode t)

(cw/for-emacs
 (if (string-match "[Uu][Tt][Ff]-?8" (or (getenv "LC_ALL")
                                         (getenv "LANG")
                                         (format "")))
     (progn
       (set-language-environment "UTF-8") ; UTF-8 mode
       (if (not window-system)
           (progn
             (set-keyboard-coding-system 'utf-8)
             (set-terminal-coding-system 'utf-8))))
   (set-language-environment "Latin-1")))

;(prefer-coding-system "utf-8")

;(add-to-list 'load-path (expand-file-name "~/svn/elisp"))

(setq default-major-mode 'text-mode
      mail-user-agent 'gnus-user-agent
      read-mail-command 'gnus)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'debian-changelog-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'linum-mode)

(column-number-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "gnome-open"
      browse-url-browser-function gnus-button-url)
(global-set-key "\M-n" 'browse-url-at-point)

;; Clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Various programming settings and languages
(defun telepathy-c-initialization-hook ()
  (c-add-style "telepathy"
  '("gnu"
    (indent-tabs-mode . nil)
    (c-offsets-alist
     (arglist-intro . 4)
     (arglist-cont-nonempty . 4)))))

(add-hook 'c-initialization-hook 'telepathy-c-initialization-hook)
(setq c-default-style "telepathy")

(setq-default show-trailing-whitespace t)
(setq whitespace-style '(tabs tab-mark))

(setq european-calendar-style t)

(global-set-key (kbd "RET") 'newline-and-indent)

;(setq py-honor-comment-indentation nil)

; Highlight matching/nonmatching parens
(cw/for-emacs
 (global-font-lock-mode t)
 (font-lock-mode 1)
 (server-start))

(cw/for-emacs-21-and-later
 (blink-cursor-mode 0)
 (if window-system
     (tooltip-mode 0))
 (if window-system
     (tool-bar-mode 0))
 (global-set-key [home] 'beginning-of-buffer)
 (global-set-key [end] 'end-of-buffer)
 (menu-bar-mode 0)
 (setq cursor-in-non-selected-windows nil))

; Mode line

(cw/for-emacs-22-and-later
 (setq inhibit-splash-screen t)
 (setq inhibit-startup-echo-area-message "jonny")
)

(setq show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)

(setq add-log-full-name "Jonny Lamb")

(setq mouse-yank-at-point t)

(add-to-list 'window-size-change-functions
             (lambda (frame) (setq org-tags-column (* -1 (- (frame-width) 10))
                                   org-agenda-align-tags-to-column (- (frame-width) 10))))
