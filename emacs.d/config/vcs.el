;; -*- emacs-lisp -*-

;; follow symlinks
(setq vc-follow-symlinks t)

;; disable Git because it takes the lockfile which can get in the way
;; with huge slow repos
(delete 'Git vc-handled-backends)
