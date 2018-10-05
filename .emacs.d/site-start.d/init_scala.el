(require 'scala-mode-auto)
(eval-after-load 'scala-mode
  '(progn
     (define-key company-active-map [tab] nil)
     (define-key scala-mode-map [tab] 'yas-expand)
     (define-key scala-mode-map (kbd "C-:") 'ensime-company-complete-or-indent)
     ))

(provide 'init_scala)
