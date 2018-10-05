(require 'scala-mode-auto)
(eval-after-load 'scala-mode
  '(progn
     (define-key scala-mode-map [tab] nil)
     (define-key scala-mode-map [tab] 'yas-expand)
     (define-key scala-mode-map (kbd "C-:") 'company-complete-common)
     ))

(provide 'init_scala)
