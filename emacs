; -*- emacs-lisp -*-

; stolen from Tollef
(message "loading .emacs-standard")
(load "~/.emacs-standard")

; follow symlinks in a vcs
(setq vc-follow-symlinks t)

; utf8
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

; set line numbers globally
(global-linum-mode 1)

; auto-fill mode is line wrapping
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'debian-changelog-mode-hook 'turn-on-auto-fill)

; display the column number in the bottom
(column-number-mode t)

; use "y" and "n" instead of "yes" and "no"
(fset 'yes-or-no-p 'y-or-n-p)

; this is nice
(delete-selection-mode 1)

; M-n to open a link at the cursor
(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "gnome-open"
      browse-url-browser-function gnus-button-url)
(global-set-key "\M-n" 'browse-url-at-point)

; use the X clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

; telepathy coding style
; http://telepathy.freedesktop.org/wiki/Style
(defun telepathy-c-initialization-hook ()
  (c-add-style "telepathy"
  '("gnu"
    (indent-tabs-mode . nil)
    (c-offsets-alist
     (arglist-intro . 4)
     (arglist-cont-nonempty . 4)))))
(add-hook 'c-initialization-hook 'telepathy-c-initialization-hook)

; default c coding style
(setq c-default-style "telepathy")

; show trailing whitespace
(setq-default show-trailing-whitespace t)
(setq whitespace-style '(tabs tab-mark))

; hmm
(setq european-calendar-style t)

; give a newline and indent when return is pressed
(global-set-key (kbd "RET") 'newline-and-indent)

; highlight matching/nonmatching parenthesis
(cw/for-emacs
 (global-font-lock-mode t)
 (font-lock-mode 1))

; only start the server if one isn't already started
(if (not (file-exists-p "/tmp/emacs1000/server"))
     (server-start))

; misc stolen from Tollef
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

; more misc
(cw/for-emacs-22-and-later
 (setq inhibit-splash-screen t)
 (setq inhibit-startup-echo-area-message "jonny")
)

; set my name
(setq add-log-full-name "Jonny Lamb")

; hmm
(setq-default indent-tabs-mode nil)
(setq mouse-yank-at-point t)
(add-to-list 'window-size-change-functions
             (lambda (frame) (setq org-tags-column (* -1 (- (frame-width) 10))
                                   org-agenda-align-tags-to-column (- (frame-width) 10))))

; put the scroll bar on the right
(set-scroll-bar-mode 'right)

; mutt
; stolen from http://fsinfo.noone.org/~abe/mutt/
(defun axels-mail-mode-hook ()
  (turn-on-auto-fill) ;;; Auto-Fill is necessary for mails
  (turn-on-font-lock) ;;; Font-Lock is always cool *g*
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ;;; Kills quoted sigs.
  (not-modified) ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text) ;;; Jumps to the beginning of the mail text
  (setq make-backup-files nil) ;;; No backups necessary.
  )
(add-to-list 'auto-mode-alist '("/mutt-" . mail-mode))
(add-hook 'mail-mode-hook 'axels-mail-mode-hook)

; git stuff
(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . diff-mode) auto-mode-alist))
