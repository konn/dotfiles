(require 'yatex)
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-use-AMS-LaTeX t)

(setq YaTeX-template-file "~/.emacs.d/share/yatextemplate.tex")
(setq tex-command "~/usr/bin/platex2pdf"
     dvi2-command "open -a Skim")

(provide 'init_yatex)