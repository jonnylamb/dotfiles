;; -*- emacs-lisp -*-

;; only start the server if one isn't already started
(if (not (file-exists-p "/tmp/emacs1000/server"))
    (server-start))
