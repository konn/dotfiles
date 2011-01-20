(require 'yatex)
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq tex-command "dotexshop"
     dvi2-command "open -a Preview")

(provide 'init_yatex)