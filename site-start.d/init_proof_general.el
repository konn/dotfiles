(autoload 'coq-mode "proof-site" "Proof General" t)
(autoload 'isar-mode "proof-site" "Proof General" t)
(setq auto-mode-alist
      (append '(("\\.v$" . coq-mode)
		("\\.thy$" . isar-mode)) auto-mode-alist))

(provide 'init_proof_general)
