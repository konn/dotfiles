(require 'init_spell)
(require 'reftex)
(defun yatex-mode-my-hook ()
  ;; RefTeX
  (turn-on-reftex)
  (define-key reftex-mode-map
    (concat YaTeX-prefix ">") 'YaTeX-comment-region)
  (define-key reftex-mode-map
    (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)
  (define-key reftex-mode-map (concat YaTeX-prefix ")") 'YaTeX-insert-parens-region)
  (setq auto-fill-function nil)
  ;(add-hook 'before-save-hook 'commaperiod nil t)
  (YaTeX-define-begend-key "ba" "align*")
  (YaTeX-define-begend-key "bA" "align")
  (YaTeX-define-begend-key "bl" "lemma")
  (YaTeX-define-begend-key "bp" "proof")
  (YaTeX-define-begend-key "bd" "definition")
  (YaTeX-define-begend-key "bh" "theorem")
  (YaTeX-define-begend-key "bg" "gather*")
  (YaTeX-define-begend-key "bG" "gather")
  (YaTeX-define-begend-key "bC" "corollary")
  ;; forward-search for Skim
  (define-key YaTeX-mode-map [?\s-R] 'skim-forward-search)
  (define-key YaTeX-mode-map (kbd "C-c C-j") 'skim-forward-search)

  ;; Spelling
  (add-to-list 'ispell-dictionary-alist
              '("math-latex-hunspell"
                "[[:alpha:]]"
                "[^[:alpha:]]"
                "[']"
                t
                ("-d" "en_US,en_Math" "-p" "/Users/hiromi/Library/Spelling" "-t")
                nil
                UTF-8))
  (setq ispell-extra-args '("-t"))
  (eval-after-load 'ispell
    (ispell-change-dictionary "math-latex-hunspell"))
  (define-key YaTeX-mode-map (kbd "C-c C-s") 'flyspell-prog-mode)
  (define-key YaTeX-mode-map (kbd "C-c C-k") 'flyspell-mode)
  (define-key YaTeX-mode-map (kbd "C-c C-c") 'ispell-buffer)
  (define-key YaTeX-mode-map (kbd "M-n") 'flyspell-goto-next-error)
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

))

(setq TeX-active-styles "biblatex")
(setq reftex-label-alist 
      '((nil ?e nil "\\eqref{%s}" nil nil)
	("section"   ?s "%S" "~\\ref{%s}" (nil . t)
	 (regexp "parts?" "chapters?" "chap\\." "sections?" "sect?\\."
		 "paragraphs?" "par\\."
		 "\\\\S" "\247" "Teile?" "Kapitel" "Kap\\." "Abschnitte?"
		 "appendi\\(x\\|ces\\)" "App\\."  "Anh\"?ange?" "Anh\\."))

	("enumerate" ?i "item:" "~\\ref{%s}" item
	 (regexp "items?" "Punkte?" "条件"))
	
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
	
	("theorem" ?h "thm:" "~\\ref{%s}" t (regexp "theorems?" "定理"))
	("axiom" ?a "axiom:" "~\\ref{%s}" t (regexp "axioms?" "公理"))
	("prop" ?p "prop:" "~\\ref{%s}" nil (regexp "prop" "propsitions?" "命題"))
	("lemma" ?l "lem:" "~\\ref{%s}" nil (regexp "lemmas?" "lemmata" "補題"))
	("fact" ?l "fac:" "~\\ref{%s}" nil (regexp "facts?" "事実"))
	("claim" ?l "cla:" "~\\ref{%s}" nil (regexp "claims?" "主張"))
	("example" ?l "exa:" "~\\ref{%s}" nil (regexp "examples?" "例"))
	("definition" ?d "def:" "~\\ref{%s}" nil (regexp "definitions?" "定義"))
	("corollary" ?c "cor:" "~\\ref{%s}" nil (regexp "cor" "corollary" "corollaries" "系"))
	("any"       ?\  " "   "~\\ref{%s}" nil)
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
   ("Q" "mathbb{Q}" "ℚ")
   ("Z" "mathbb{Z}" "ℤ")
   ("R" "mathbb{R}" "ℝ")
   ("C" "mathbb{C}" "ℂ")
   ("Z" "mathbb{N}" "ℕ")
   ("||" "compat" "‖")
   ("op" "^{\\text{op}}" "ᵒᵖ")
   ("{/" "notin" "∉")
   ("..." "dots" "...")
   ("()" "concat" "⌢")
   ("|`" "restr" "|`")
   (">->" "rightarrowtail" "↣")
   ("->>" "twoheadrightarrow" "↠")
   ("~>" "leadsto" "↝")
   ("<>" "diamondsuit" "♢")
   ("<|" "lhd" "◁")
   ("U" "bigcup" "∪")
   ("@" "bigcup" "∩")
   ("|>" "rhd" "▷")
   ("/>" "nearrow" "↗︎")
   ("<(-" "preccurlyeq" "≼")
   ("<(" "prec" "≺")
   (")>-" "succcurlyeq" "≽")
   (")>" "succ" "≻")
   ("|v" "downarrow" "↓")
   ("|^" "uparrow" "↑")
   ("||v" "Downarrow" "⇓")
   ("||^" "Uparrow" "⇑")
   ("||-" "\Vdash" "⊩")
   ("||-*" "mathrel{\\Vdash^*}" "⊩*")
   ("~~-" "approxeq" "≊")
   ("[[" "llbracket" "〚")
   ("[|" "llbracket" "〚")
   ("]]" "rrbracket" "〛")
   ("|]" "rrbracket" "〛")
   ("]" "beth" "ℶ")
   ("<." "lessdot" "⋖")
   (".>" "gtrdot" "⋗")
   ("j"  "jmath"  "ȷ")
   ("i"  "imath"  "𝚤")
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
   ("s"  "mathscr"   "\\mathscr{}")
   ("v"  "bm"        "\\bm{}")
   )
 )

(setq YaTeX-greek-key-alist-private
      '(("SS" "boldface{\\Sigma}" "𝚺")
        ("PP" "boldface{\\Pi}"    "𝚷")
        ("DD" "boldface{\\Delta}" "𝚫")
        ("S~" "boldface{\\Sigma}" "𝚺")
        ("P~" "boldface{\\Pi}"    "𝚷")
        ("D~" "boldface{\\Delta}" "𝚫")
        ("ph"  "varphi" "φ-")
        ("ph-" "phi"    "φ")
        ))

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
