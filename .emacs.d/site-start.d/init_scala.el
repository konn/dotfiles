(require 'scala-mode-auto)
(eval-after-load 'scala-mode
  '(progn
     (define-key scala-mode-map (kbd "C-.") 'yas-expand)
     ))

(provide 'init_scala)
