(require 'agda2)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "/Users/hiromi/Library/Haskell/bin/agda-mode locate")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(agda2-include-dirs (quote ("/Users/hiromi/.agda/lib/stdlib" "."))))
(setq haskell-ghci-program-name "agda-mode")


(provide 'init_agda2)
