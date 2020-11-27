;; -*- emacs-lisp -*-

;; show tabs and stuff
(require 'whitespace)

;; maybe this should be less of a whitelist and perhaps a blacklist...
(setq whitespace-global-modes
      '(c-mode
        c++-mode
        sh-mode
        emacs-lisp-mode
        js2-mode
        makefile-mode
        python-mode
        rjsx-mode
        scala-mode
        thrift-mode
        go-mode))

;; don't enable everything (like end of line markers)
(setq whitespace-style
      '(face
        tabs
        spaces
        trailing
        space-before-tab
        empty
        space-after-tab::tab
        space-mark
        tab-mark))

(global-whitespace-mode t)
