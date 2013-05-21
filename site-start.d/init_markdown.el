(require 'markdown-mode)
; (require 'yatex)
(setq auto-mode-alist
   (append '(("\\.md" . markdown-mode) ("\\.markdown" . markdown-mode)) auto-mode-alist))
(setq markdown-command "/Users/hiromi/usr/bin/markdown")
(require 'mmm-mode)
; (setq mmm-global-mode 'maybe)
;(mmm-add-mode-ext-class nil "\\.md?\\'" 'markdown-yatex)
(mmm-add-group
 'markdown-yatex
 '((markdown-block-yatex
    :submode yatex-mode
    :face mmm-code-submode-face
    :save-matches 1
    :front "\\(\\$\\$?\\)[ \n\t]*"
    :back  "[ \n\y]*~1")
   )
 )
(provide 'init_markdown)
