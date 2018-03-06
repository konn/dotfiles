(require 'satysfi)
(require 'flycheck)
(setq auto-mode-alist (cons '("\\.saty$" . satysfi-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.satyh$" . satysfi-mode) auto-mode-alist))
(eval-after-load "satysfi"
  '(progn
     (define-key satysfi-mode-map (kbd "C-z") nil)
     )
  )
(flycheck-define-checker satysfi
  "A SATySFi syntax and type checker using SATySFi compiler"

  :command ("satysfi" source)
  :error-patterns
   ((error
     bol "![" (message) "] at line" (zero-or-more space) line ", characters" (zero-or-more space) column "-" (zero-or-more anything) eol))
  :modes satysfi-mode
  )
(add-to-list 'flycheck-checkers 'satysfi)
(provide 'init_satysfi)
