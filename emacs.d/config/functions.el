; -*- emacs-lisp -*-

(require 's)

; misc useful functions
(defun jonny/first-char (s)
  "first char of string"
  (s-left 1 s))

; work out whether submodules are loaded
(defun jonny/test-submodules/list ()
  "list of submodules"
  (s-lines (s-trim-right (shell-command-to-string "git submodule status"))))

(defun jonny/test-submodules/statuses ()
  "list of submodule statuses"
  (mapcar 'jonny/first-char (jonny/test-submodules/list)))

(defun jonny/test-submodules ()
  "whether all submodules are in clean state in current working directory"
  (s-blank? (s-trim (s-join "" (jonny/test-submodules/statuses)))))
