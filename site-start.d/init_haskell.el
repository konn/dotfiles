(load "haskell-site-file")

(setq haskell-program-name "/usr/bin/ghci")
(autoload 'ghc-init "ghc" nil t)
(setq auto-mode-alist
      (append '(("\\.cabal$" . haskell-cabal-mode)) auto-mode-alist))

(custom-set-variables
 '(haskell-interactive-prompt "ghci> ")
 '(haskell-literate-default 'latex)
 '(haskell-notify-p t)
 '(turn-on-haskell-ghci)
 '(haskell-process-type 'ghci)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t))

(add-hook 'haskell-mode-hook 'my-haskell-hook)
(add-hook 'haskell-cabal-mode-hook 'haskell-cabal-hook)
;(defun my-before-save-hook ()
;  (ignore-errors (call-process "cabal2ghci")))

(defun my-haskell-hook ()
  ;(add-hook 'before-save-hook 'my-before-save-hook)
  (turn-on-haskell-indent)
  (turn-on-haskell-decl-scan)
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)

  (define-key haskell-mode-map [?\C-c ?\C-l] 'haskell-process-load-file)
  (define-key haskell-mode-map [f5] 'haskell-process-load-file)

  (define-key haskell-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)

  ;; Build the Cabal project.
  (define-key haskell-mode-map (kbd "C-c b") 'haskell-process-cabal-build)
  ;; Interactively choose the Cabal command to run.
  (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)

  (setq tab-width 2 indent-tabs-mode nil)
  (ghc-init) (flymake-mode))

(defun toggle-ghc-head ()
  (interactive)
  (kill-buffer "*haskell*")
  (if (string= haskell-program-name "/usr/bin/ghci")
      (progn
	(setq haskell-program-name "~/usr/bin/ghci-head")
	(message "changed to GHC HEAD"))
    (progn
      (setq haskell-program-name "/usr/bin/ghci")
      (message "changed to Haskell Platform's ghci."))
    ))

(defun haskell-cabal-hook ()
  (setq indent-tabs-mode nil)
  (define-key haskell-cabal-mode-map (kbd "C-c b") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
  (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
  (define-key haskell-cabal-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch))


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
    :front "^\\\\begin{code}"
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
