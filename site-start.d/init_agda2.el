(require 'agda2)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(agda2-include-dirs (list (expand-file-name "~/.agda/lib/stdlib") "."))
 '(agda-input-user-translations `(("bb" . ("𝔹")))))
;(setq haskell-ghci-program-name "agda-mode")
(setq auto-mode-alist
      (append '(("\\.agda$" . agda2-mode)) auto-mode-alist))

(add-hook 'agda2-mode-hook 'my-agda2-hook)


(defun my-agda2-hook ()
  (define-key agda2-mode-map (kbd "C-c C-g") 'agda2-give)
  )

(provide 'init_agda2)
