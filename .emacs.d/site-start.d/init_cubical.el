(autoload 'cubicaltt-mode "cubicaltt" "cubical editing mode" t)
(setq auto-mode-alist (append auto-mode-alist '(("\\.ctt$" . cubicaltt-mode))))

(autoload 'yacctt-mode "yacctt" "cubical editing mode" t)
(setq auto-mode-alist (append auto-mode-alist '(("\\.ytt$" . yacctt-mode))))

(provide 'init_cubical)
