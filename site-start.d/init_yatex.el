(setq YaTeX-use-hilit19 nil
        YaTeX-use-font-lock t)
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-use-AMS-LaTeX t)

(setq YaTeX-template-file "~/.emacs.d/share/yatextemplate.tex")
(setq tex-command "~/usr/bin/platex2pdf"
     dvi2-command "open -a Skim"
     makeindex-command "mendex -U")

(setq
 YaTeX-math-sign-alist-private
 '(("Q" "mathbb{Q}" "(Q)")
   ("Z" "mathbb{Z}" "ZZ")
   ("R" "mathbb{R}" "R")
   ("C" "mathbb{C}" "R")
   ("Z" "mathbb{N}" "N")
   ("st" "text{s.t.}" "s.t.")
   ("op" "^{\\text{op}}" "op")
   ("<" "langle" "<")
   (">" "rangle" ">")
   )
 )

(provide 'init_yatex)
