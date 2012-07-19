(autoload 'egison-mode "egison-mode" "Major mode for editing Egison code." t)
(setq auto-mode-alist
(cons `("\\.egi$" . egison-mode) auto-mode-alist))

(provide 'init_egison)

