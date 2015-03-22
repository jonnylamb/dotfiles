;; -*- emacs-lisp -*-

;; open commit messages in diff-mode
(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . diff-mode) auto-mode-alist))

;; git diff buffer
(when (require 'git-gutter nil 'noerror)
  (global-git-gutter-mode t))
