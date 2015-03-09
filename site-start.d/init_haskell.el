(load "haskell-mode-autoloads")
;(require 'hare)
;(autoload 'hare-init "hare" nil t)

(setq haskell-program-name "/usr/bin/ghci")
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(setq auto-mode-alist
      (append '(("\\.cabal$" . haskell-cabal-mode)) auto-mode-alist))

(require 'company)
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))
(add-hook 'haskell-mode-hook 'company-mode)

(custom-set-variables
 '(haskell-process-type 'cabal-repl)
 '(haskell-interactive-prompt "ghci> ")
 '(haskell-literate-default 'latex)
 '(haskell-notify-p t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(haskell-process-path-ghci "~/Library/Haskell/bin/cab")
 '(haskell-process-args-ghci '("ghci"))
)

(add-hook 'haskell-mode-hook 'my-haskell-hook)
(add-hook 'haskell-cabal-mode-hook 'haskell-cabal-hook)
;(defun my-before-save-hook ()
;  (ignore-errors (call-process "cabal2ghci")))

(defun my-haskell-hook ()
  ;(add-hook 'before-save-hook 'my-before-save-hook)
  (setq tab-width 2
	indent-tabs-mode nil)
  (turn-on-haskell-decl-scan)
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)

  (define-key haskell-mode-map [?\C-c ?\C-l] 'haskell-process-load-file)
  (define-key haskell-mode-map [f5] 'haskell-process-load-file)

  (define-key haskell-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
  (define-key haskell-mode-map [(hyper s)] 'ghc-save-buffer)
  ;; Build the Cabal project.
  (define-key haskell-mode-map (kbd "C-c b") 'haskell-process-cabal-build)
  ;; Interactively choose the Cabal command to run.
  (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file)
  (define-key haskell-mode-map (kbd "C-:") 'company-complete-common)

  (ghc-init) ;(hare-init)

  ; Overwrite ghc-mod's document browsing by helm
  ;(define-key haskell-mode-map (kbd "C-M-d") 'helm-ghc-browse-document)
  )

;; Indentation
(autoload 'hi2 "hi2" nil t)
(add-hook 'haskell-mode-hook 'turn-on-hi2)

;(custom-set-faces
; '(shm-current-face ((t (:background "dark gray")))))
;(require 'shm)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
(setq-default indent-tabs-mode nil)
(defun haskell-cabal-hook ()
  (setq indent-tabs-mode nil)
  (define-key haskell-cabal-mode-map (kbd "C-c b") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
  (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
  (define-key haskell-cabal-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch))

(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)))

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
    :submode literate-haskell-mode
    :front  "^```haskell"
    :include-front true
    :back "^```")
    ))

(defun lhs-mmm-mode ()
  (make-local-variable 'mmm-global-mode)
  (setq mmm-global-mode 'true))

(setq mmm-submode-decoration-level 0)

(provide 'init_haskell)

