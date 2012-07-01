(load "haskell-site-file")

(setq haskell-program-name "/usr/bin/ghci")
(autoload 'ghc-init "ghc" nil t)

(custom-set-variables
 '(haskell-literate-default 'latex)
 '(haskell-notify-p t)
 '(haskell-tags-on-save t)
 '(haskell-process-type 'ghci))

(add-hook 'haskell-mode-hook 'my-haskell-hook)

(defun my-haskell-hook ()
  (turn-on-haskell-ghci)
  (turn-on-haskell-indent)
  (turn-on-haskell-decl-scan)
  (setq tab-width 2 indent-tabs-mode nil)
  (ghc-init) (flymake-mode))

;; flymake-haskell

(require 'mmm-mode)
(add-hook 'haskell-mode-hook 'lhs-mmm-mode)
(mmm-add-classes
 '((literate-haskell-bird
    :submode text-mode
    :front  "^[^>]"
    :include-front true
    :back "^>\\|$")
   (literate-haskell-latex
    :submode literate-haskell-mode
    :front "^\\\\\begin{code}"
    :front-offset (end-of-line 1)
    :back "^\\\\end{code}"
    :include-back nil
    :back-offset (beginning-of-line -1))
   (literate-haskell-markdown
    :submode markdown-mode
    :front  "^[^>]"
    :include-front true
    :back "^>\\|$")
    ))

(defun lhs-mmm-mode ()
  (make-local-variable 'mmm-global-mode)
  (setq mmm-global-mode 'true))

(setq mmm-submode-decoration-level 0)

(provide 'init_haskell)
