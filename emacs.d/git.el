; -*- emacs-lisp -*-

; open commit messages in diff-mode
(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . diff-mode) auto-mode-alist))

; git diff buffer
(if (file-exists-p "~/src/emacs-git-gutter/")
    (add-to-list 'load-path "~/src/emacs-git-gutter/")
  (require 'git-gutter)
  (global-git-gutter-mode t))
