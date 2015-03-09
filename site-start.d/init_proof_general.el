(autoload 'coq-mode "proof-site" "Proof General" t)
(autoload 'isar-mode "proof-site" "Proof General" t)
(setq auto-mode-alist
      (append '(("\\.v$" . coq-mode)
		("\\.thy$" . isar-mode)) auto-mode-alist))
(add-hook 'proof-ready-for-assistant-hook (lambda () (show-paren-mode 0)))


(provide 'init_proof_general)
