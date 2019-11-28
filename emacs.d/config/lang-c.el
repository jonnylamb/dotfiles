;; -*- emacs-lisp -*-

;; telepathy coding style
;; http://telepathy.freedesktop.org/wiki/Style
(c-add-style
 "telepathy"
 '("gnu"
   (indent-tabs-mode . nil)
   (c-offsets-alist
    (arglist-intro . 4)
    (arglist-cont-nonempty . 4))))

;; gtk+ style
(c-add-style
 "gtk"
 '("gnu"
   (indent-tabs-mode . nil)))

;; wayland style
(c-add-style
 "wayland"
 '("linux"
   (indent-tabs-mode . t)))

(c-add-style
 "gstreamer"
 '("K&R"
   (indent-tabs-mode . nil)
   (c-basic-offset . 4)))

;; use wayland style by default
(setq c-default-style "gtk")
