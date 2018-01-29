(autoload 'teyjus-edit-mode "teyjus.el" nil t)
(add-to-list 'auto-mode-alist '("\\.mod$" . teyjus-edit-mode))
(add-to-list 'auto-mode-alist '("\\.sig$" . teyjus-edit-mode))
(provide 'init_teyjus)
