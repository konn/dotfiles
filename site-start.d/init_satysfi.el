(require 'satysfi)
(setq auto-mode-alist (cons '("\\.saty$" . satysfi-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.satyh$" . satysfi-mode) auto-mode-alist))
(eval-after-load "satysfi"
  '(progn
     (define-key satysfi-mode-map (kbd "C-z") nil)
     )
  )
(provide 'init_satysfi)
