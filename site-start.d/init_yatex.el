(defun yatex-mode-my-hook ()
  (setq auto-fill-function nil)
  ;(add-hook 'before-save-hook 'commaperiod nil t)
  (YaTeX-define-begend-key "ba" "align*")
  (turn-on-reftex)
  (define-key reftex-mode-map
    (concat YaTeX-prefix ">") 'YaTeX-comment-region)
  (define-key reftex-mode-map
    (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)
  (define-key reftex-mode-map (concat YaTeX-prefix ")") 'YaTeX-insert-parens-region)
  )

(add-hook 'reftex-mode-hook
 '(lambda ()
               (define-key reftex-mode-map "\C-h)" 'reftex-reference)
               (define-key reftex-mode-map "\C-h=" 'reftex-toc)
               (define-key reftex-mode-map "\C-h(" 'reftex-label)
               (define-key reftex-mode-map "\C-h[" 'reftex-citation)
               (define-key reftex-mode-map "\C-h<" 'reftex-index)
               (define-key reftex-mode-map "\C-h>" 'reftex-display-index)
               (define-key reftex-mode-map "\C-h/" 'reftex-index-selection-or-word)
               (define-key reftex-mode-map "\C-h\\" 'reftex-index-phrase-selection-or-word)
               (define-key reftex-mode-map "\C-h|" 'reftex-index-visit-phrases-buffer)
               (define-key reftex-mode-map "\C-h&" 'reftex-view-crossref)

	       ;; forward-search for Skim
	       (define-key YaTeX-mode-map [?\s-R] 'skim-forward-search)
	       (define-key YaTeX-mode-map (kbd "C-c C-g") 'skim-forward-search)

))

(setq reftex-label-alist 
      '((nil ?e nil "\\eqref{%s}" nil nil)
	("section"   ?s "%S" "~\\ref{%s}" (nil . t)
	 (regexp "parts?" "chapters?" "chap\\." "sections?" "sect?\\."
		 "paragraphs?" "par\\."
		 "\\\\S" "\247" "Teile?" "Kapitel" "Kap\\." "Abschnitte?"
		 "appendi\\(x\\|ces\\)" "App\\."  "Anh\"?ange?" "Anh\\."))

	("enumerate" ?i "item:" "\\ref{%s}" item
	 (regexp "items?" "Punkte?"))
	
	("equation"  ?e "eq:" "\\eqref{%s}" t
	 (regexp "equations?" "eqs?\\." "eqn\\." "Gleichung\\(en\\)?"  "Gl\\."))
	("equation*"  ?e "eq:" "\\eqref{%s}" t
	 (regexp "equations?" "eqs?\\." "eqn\\." "Gleichung\\(en\\)?"  "Gl\\."))
	("eqnarray*"  ?e "eq:" nil eqnarray-like)
	("align*"  ?e "eq:" nil eqnarray-like)
	("align"  ?e "eq:" nil eqnarray-like)
	
	("figure"    ?f "fig:" "\\ref{%s}" caption
	 (regexp "figure?[sn]?" "figs?\\." "Abbildung\\(en\\)?" "Abb\\."))
	("figure*"   ?f nil nil caption)
	
	("table"     ?t "tab:" "\\ref{%s}" caption
	 (regexp "tables?" "tab\\." "Tabellen?"))
	("table*"    ?t nil nil caption)
	
	("\\footnote[]{}" ?n "fn:" "\\ref{%s}" 2
	 (regexp "footnotes?" "Fussnoten?"))
	
	("theorem" ?h "thm:" "\\ref{%s}" t ("定理"))
	("axiom" ?a "axiom:" "\\ref{%s}" t ("公理"))
	("prop" ?p "prop:" "\\ref{%s}" nil ("命題"))
	("lemma" ?l "lem:" "\\ref{%s}" nil ("補題"))
	("claim" ?l "cla:" "\\ref{%s}" nil ("主張"))
	("definition" ?d "def:" "\\ref{%s}" nil ("定義"))
	("corollary" ?c "cor:" "\\ref{%s}" nil ("系"))
	("any"       ?\  " "   "\\ref{%s}" nil)
	))

(setq reftex-bibliography-commands '("addbibresource" "bibliography"))
(setq reftex-default-bibliography '("~/Library/texmf/bibtex/bib/myreference.bib"))

(setenv "BIBINPUTS"
	(concat (expand-file-name "~/texmf/bibtex/bib") (getenv "BIBINPUTS")))
(add-hook 'yatex-mode-hook 'yatex-mode-my-hook)
(setq YaTeX-use-hilit19 nil
        YaTeX-use-font-lock t)
(setq YaTeX-kanji-code 4)
(setq YaTeX-search-file-from-top-directory t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode) ("\\.sty$" . yatex-mode)) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-use-AMS-LaTeX t)

(setq YaTeX-template-file "~/.emacs.d/share/yatextemplate.tex")
(setq tex-command "latexmk"
     makeindex-command "mendex -U")

(setq
 YaTeX-math-sign-alist-private
 '(("T" "top" "T")
   ("Q" "mathbb{Q}" "(Q)")
   ("Z" "mathbb{Z}" "ZZ")
   ("R" "mathbb{R}" "R")
   ("C" "mathbb{C}" "R")
   ("Z" "mathbb{N}" "N")
   ("||" "mathrel{\\|}" "||")
   ("st" "text{s.t.}" "s.t.")
   ("op" "^{\\text{op}}" "op")
   ("{/" "notin" "∉")
   ("..." "dots" "...")
   ("()" "concat" "⌢")
   ("|`" "restr" "|`")
   (">->" "rightarrowtail" ">->")
   ("->>" "twoheadrightarrow" "->>")
   ("~>" "leadsto" "~>")
   ("<>" "diamondsuit" "<>")
   ("<|" "lhd" "<|")
   ("|>" "rhd" "|>")
   ("<(" "preccurlyeq" "<(")
   (">(" "succcurlyeq" ">(")
   ("|v" "downarrow" "↓")
   ("|^" "uparrow" "↑")
   ("||v" "Downarrow" "⇓")
   ("||^" "Uparrow" "⇑")
   ("||-" "\Vdash" "||-")
   ("||-*" "mathrel{\\Vdash^*}" "||-*")
   ("~~-" "approxeq" "~~-")
   ("[[" "llbracket" "[|")
   ("[|" "llbracket" "[|")
   ("]]" "rrbracket" "|]")
   ("|]" "rrbracket" "|]")
   )
 )

(setq
 YaTeX-font-list-private
 '(("c"  "mathcal"  "\\mathcal{}")
   ("f"  "mathfrak" "\\mathfrak{}")
   ("d"  "mathds"   "\\mathds{}")
   ("b"  "mathbb"   "\\mathbb{}")
   ("B"  "mathbf"   "\\mathbf{}")
   ("r"  "mathrm"   "\\mathrm{}")
   )
 )

(setq
 YaTeX-math-key-list-private
 '(("@" . YaTeX-font-list-private)
   )
 )

;; synctex forward search for Skim
;; from http://d.hatena.ne.jp/setoryohei/20110102/1294003836
(defun skim-forward-search ()
  (interactive)
  (process-kill-without-query
   (start-process  
    "displayline"
    nil
    "/Applications/Skim.app/Contents/SharedSupport/displayline"
    (number-to-string (save-restriction
                        (widen)
                        (count-lines (point-min) (point))))
    (expand-file-name
     (concat (file-name-sans-extension (or YaTeX-parent-file
                                           (save-excursion
                                             (YaTeX-visit-main t)
                                             buffer-file-name)))
             ".pdf"))
    buffer-file-name)))
 

;; synctex forward search for Skim
;(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-dvi2-command-ext-alist
      '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
(setq dvi2-command "/usr/bin/open -a Skim")
(setq tex-pdfview-command "/usr/bin/open -a Skim")

(provide 'init_yatex)
