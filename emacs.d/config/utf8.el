; -*- emacs-lisp -*-

; utf8
(if (string-match "[Uu][Tt][Ff]-?8" (or (getenv "LC_ALL")
                                        (getenv "LANG")
                                        (format "")))
    (progn
      (set-language-environment "UTF-8")
      (if (not window-system)
          (progn
            (set-keyboard-coding-system 'utf-8)
            (set-terminal-coding-system 'utf-8))))
  (set-language-environment "Latin-1"))
