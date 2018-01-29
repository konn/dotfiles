(require 'prolog)
(setq  prolog-system 'swi)
(setq auto-mode-alist
      (cons '("\\.pl" . prolog-mode) auto-mode-alist))
(setq prolog-program-name "/opt/local/bin/swipl")
(setq prolog-consult-string "[user].\n")
(put 'narrow-to-region 'disabled nil)

(provide 'init_prolog)
