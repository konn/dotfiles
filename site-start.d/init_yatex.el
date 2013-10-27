(defun yatex-mode-my-hook ()
  (setq auto-fill-function nil)
  (add-hook 'before-save-hook 'commaperiod nil t)
  (YaTeX-define-begend-key "ba" "align*")
  )

(add-hook 'yatex-mode-hook 'yatex-mode-my-hook)
(setq YaTeX-use-hilit19 nil
        YaTeX-use-font-lock t)
(setq YaTeX-kanji-code 4)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode) ("\\.sty$" . yatex-mode)) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-use-AMS-LaTeX t)

(setq YaTeX-template-file "~/.emacs.d/share/yatextemplate.tex")
(setq tex-command "~/usr/bin/platex2pdf"
     dvi2-command "open -a Skim"
     makeindex-command "mendex -U")

(setq
 YaTeX-math-sign-alist-private
 '(("T" "top" "T")
   ("Q" "mathbb{Q}" "(Q)")
   ("Z" "mathbb{Z}" "ZZ")
   ("R" "mathbb{R}" "R")
   ("C" "mathbb{C}" "R")
   ("Z" "mathbb{N}" "N")
   ("st" "text{s.t.}" "s.t.")
   ("op" "^{\\text{op}}" "op")
   ("{/" "notin" "∉")
   ("..." "dots" "...")
   ("()" "concat" "⌢")
   ("|`" "restr" "|`")
   (">->" "rightarrowtail" ">->")
   ("->>" "twoheadrightarrow" "->>")
   ("~>" "leadsto" "~>")
   )
 )

(setq
 YaTeX-font-list-private
 '(("c"  "mathcal")
   ("f"  "mathfrak")
   ("bb" "mathbb")
   ("bf" "mathbf")
   ("r"  "mathrm")
   )
 )

(setq
 YaTeX-math-key-list-private
 '(("@" . YaTeX-font-list-private)
   )
 )

(provide 'init_yatex)
