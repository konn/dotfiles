(require 'redtt)
(setq auto-mode-alist
      (append '(("\\.red$" . redtt-mode)) auto-mode-alist))
(provide 'init_redtt)
