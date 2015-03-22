;; -*- emacs-lisp -*-

;; open commit messages in diff-mode
(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . diff-mode) auto-mode-alist))

;; git diff buffer
;; this doesn't work and I don't know why
;;(jonny/when-installed
;; 'git-gutter
;; (global-git-gutter-mode t))
