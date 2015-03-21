; -*- emacs-lisp -*-

(require 's)

; misc useful functions
(defun jonny/first-char (s)
  "first char of string"
  (substring s 0 1))

; work out whether submodules are loaded
(defun jonny/test-submodules/list ()
  "list of submodules"
  (s-lines (s-trim-right (shell-command-to-string "git submodule status"))))

(defun jonny/test-submodules/statuses ()
  "list of submodule statuses"
  (delete
   " "
   (mapcar 'jonny/first-char (jonny/test-submodules/list))))

(defun jonny/test-submodules ()
  "whether all submodules are in clean state in current working directory"
  (= 0 (length (jonny/test-submodules/statuses))))
