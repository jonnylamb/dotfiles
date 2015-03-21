; -*- emacs-lisp -*-

; misc useful functions
(defun jonny/first-char (s)
  "first char of string"
  (substring s 0 1))

; work out whether submodules are loaded
(defun jonny/test-submodules/list ()
  "list of submodules"
  (split-string (substring (shell-command-to-string "git submodule status") 0 -1) "\n"))

(defun jonny/test-submodules/statuses ()
  "list of submodule statuses"
  (delete
   " "
   (mapcar 'jonny/first-char (jonny/test-submodules/list))))

(defun jonny/test-submodules ()
  "whether all submodules are in clean state in current working directory"
  (= 0 (length (jonny/test-submodules/statuses))))
