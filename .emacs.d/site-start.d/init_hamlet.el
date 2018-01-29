(require 'hamlet-mode)

(setq auto-mode-alist (cons '("\\.julius$" . javascript-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.lucius$" . css-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.hamlet$" . hamlet-mode) auto-mode-alist))
(setq tab-width 2 indent-tabs-mode nil)

(provide 'init_hamlet)
