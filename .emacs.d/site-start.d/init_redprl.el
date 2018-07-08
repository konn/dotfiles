(require 'redprl)
(setq auto-mode-alist
      (append '(("\\.red$" . redprl-mode)) auto-mode-alist))
(provide 'init_redprl)
