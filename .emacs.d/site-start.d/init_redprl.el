(require 'redprl)
(setq auto-mode-alist
      (append '(("\\.prl$" . redprl-mode)) auto-mode-alist))
(provide 'init_redprl)
