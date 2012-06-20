(require 'hamlet-mode)

(setq auto-mode-alist (cons '("\\.julius$" . javascript-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.lucius$" . css-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.hamlet$" . hamlet-mode) auto-mode-alist))

(provide 'init_hamlet)
