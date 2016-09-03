;; -*- emacs-lisp -*-

(defun jonny/is-mac (&rest body)
  (if (string-equal system-name "darwin")
      body))

(defun reload-config ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
