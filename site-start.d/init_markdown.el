(require 'markdown-mode)
(setq auto-mode-alist
   (append '(("\\.md" . markdown-mode) ("\\.markdown" . markdown-mode)) auto-mode-alist))
(setq markdown-command "/Users/hiromi/usr/bin/markdown")
(provide 'init_markdown)
