;; -*- emacs-lisp -*-

;; (require 's)

;; pkg-config stuff

;; (defun pkg-config/is-includes? (s)
;;   (s-equals? "-I" (s-left 2 s)))

;; (defun pkg-config/is-defines? (s)
;;   (s-equals? "-D" (s-left 2 s)))

;; (defun pkg-config/paths (name)
;;   (-map
;;    (lambda (s) (s-chop-prefix "-I" s))
;;    (-filter
;;     'pkg-config/is-includes?
;;     (s-split " " (shell-command-to-string
;;                   (format "pkg-config --cflags %s" name))
;;              t))))

;; (pkg-config/paths "glib-2.0")

;; makefile stuff

;; (require 'dash)

;; (defun get-dirname (path)
;;   (file-name-directory path))

;; (defun get-filename (path)
;;   (file-name-nondirectory path))

;; (defun get-objectname (path)
;;   (s-concat
;;    (s-chop-suffixes
;;     '(".c" ".cc" ".ccp")
;;     (get-filename path))
;;    ".o"))

;; (defun get-make-output (path)
;;   (shell-command-to-string
;;    (format "make -C %s -n -W %s %s V=1"
;;            (get-dirname path)
;;            (get-filename path)
;;            (get-objectname path))))

;; (defun get-items (prefix path)
;;   (-map
;;    (lambda (s) (s-chop-prefix prefix s))
;;    (-filter
;;     '(lambda (s) (s-equals? prefix (s-left 2 s)))
;;     (s-split " " (get-make-output path) t))))

;; (defun add-includes-to-lists (path)
;;   (-each (get-items "-I" path)
;;     (lambda (item)
;;       (add-to-list 'flycheck-clang-include-path item))))

;; (defun add-defines-to-lists (path)
;;   (-each (get-items "-D" path)
;;     (lambda (item)
;;       (add-to-list 'flycheck-clang-definitions item))))

;; (require 'esh-arg)

;; (defun loldongs (buffer)
;;   (with-temp-buffer buffer
;;     (eshell-parse-arguments 1 3)))
;; (loldongs (get-make-output "/home/jonny/src/gtk+/gtk/gtkfilechooser.c"))

;; (eshell-parse-arguments (get-make-output "/home/jonny/src/gtk+/gtk/gtkfilechooser.c"))

;; (-each
;;     (get-items "-D" "/home/jonny/src/gtk+/gtk/gtkfilechooser.c")
;;   (lambda (s) (message "%s" s)))

;; test
;; (message "%s" (get-items "-I" "/home/jonny/src/gtk+/gtk/gtkfilechooser.c"))
;; end test

;; (defun foobar-cheese ()
;;   (interactive nil)
;;   (progn
;;     (add-includes-to-lists buffer-file-name)
;;     (add-defines-to-lists buffer-file-name)))

;; get make output
;;   get -I values
;;     add to clang include path
;;     add to gcc include path
;;   get -D values
;;     add to clang include path
;;     add to gcc include path
