;(require 'hare)
(require 'flycheck)
(require 'intero)
(require 'hlint-refactor)
(autoload 'hare-init "hare" nil t)

(load "haskell-mode-autoloads")
;; (autoload 'ghc-init "ghc" nil t)
;; (autoload 'ghc-debug "ghc" nil t)
(setq auto-mode-alist
      (append '(("\\.cabal$" . haskell-cabal-mode) ("\\.hsig" . haskell-mode)) auto-mode-alist))
;; Indentation
;; (autoload 'hi2 "hi2" nil t)
;(setq ghc-debug 't)
;; (require 'liquid-types)

;; ;; Toggle minor mode on entering Haskell mode.
;; (add-hook 'haskell-mode-hook
;;           '(lambda () (liquid-types-mode)))
;; (add-hook 'literate-haskell-mode-hook
;; 	  '(lambda () (liquid-types-mode)))

(require 'company)
(add-to-list 'company-backends 'company-ghc)
(add-hook 'haskell-mode-hook 'my-haskell-hook)

(custom-set-variables
 '(haskell-process-type 'stack-ghci)
 ;; '(company-ghc-show-info t)
 '(haskell-interactive-prompt  "λ> " t)
 '(haskell-literate-default 'latex)
 '(haskell-notify-p t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-suggest-hoogle-imports t)
 ;; '(haskell-process-path-ghci "~/.local/bin/stack")
 ;; '(haskell-process-args-ghci '("ghci"))
 ;; '(haskell-process-args-cabal-repl '("ghci"))
 ;; '(ghc-interactive-command "~/.local/bin/ghc-modi")
 ;; '(ghc-module-command "~/.local/bin/ghc-modi")
 ;; '(ghc-command "~/.local/bin/ghc-modi")
)

(add-hook 'haskell-cabal-mode-hook 'haskell-cabal-hook)

; Setting up keymaps
(eval-after-load 'haskell-mode
  '(progn
     (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-tag-find)
     
     (define-key haskell-mode-map (kbd "C-c , b") 'hlint-refactor-refactor-buffer)
     (define-key haskell-mode-map (kbd "C-c , r") 'hlint-refactor-refactor-at-point)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     (define-key haskell-mode-map [f5] 'haskell-process-load-file)
     
     (define-key haskell-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     ;; Build the Cabal project.
     (define-key haskell-mode-map (kbd "C-c b") 'haskell-process-cabal-build)
     ;; Interactively choose the Cabal command to run.
     (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file)
     (define-key haskell-mode-map (kbd "C-:") 'company-complete-common)
     ; Overwrite ghc-mod's document browsing by helm
     ; (define-key haskell-mode-map (kbd "C-M-d") 'ghc-browse-document)
     ; Flycheck key map
     (define-key haskell-mode-map (kbd "M-n") 'flycheck-next-error)
     (define-key haskell-mode-map (kbd "M-p") 'flycheck-previous-error)
     (define-key haskell-mode-map (kbd "M-t") 'intero-apply-suggestions)
     (define-key haskell-mode-map (kbd "C-c C-f") 'intero-restart)
  ))

; Enabling HLint
(flycheck-add-next-checker 'intero '(warning . haskell-hlint))

;resolve symlinks
(setq-default find-file-visit-truename t)

; Other initialization tasks
(defun my-haskell-hook ()
  ;; (ghc-init)
  (hare-init)
  (turn-on-haskell-indentation)
  (company-mode)
  (intero-mode)
  (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
  (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
  (setq tab-width 2
        indent-tabs-mode nil)
  (turn-on-haskell-decl-scan)
  )

(setq-default indent-tabs-mode nil)
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
    :submode literate-haskell-mode
    :front  "^```haskell"
    :include-front true
    :back "^```")
    ))

(defun lhs-mmm-mode ()
  (make-local-variable 'mmm-global-mode)
  (setq mmm-global-mode 'true))

(setq mmm-submode-decoration-level 0)

(defun intero-fix-ghci-panic ()
  "Disable deferring of out of scope variable errors, which
  triggers a bug in the interactive Emacs REPL printing a panic
  under certain conditions."

  (interactive)
  (let* ((root (intero-project-root))
         (package-name (intero-package-name))
         (backend-buffer (intero-buffer 'backend))
         (name (format "*intero:%s:%s:repl*"
                       (file-name-nondirectory root)
                       package-name))
         (setting ":set -fno-defer-out-of-scope-variables\n"))
    (when (get-buffer name)
      (with-current-buffer (get-buffer name)
        (goto-char (point-max))
        (let ((process (get-buffer-process (current-buffer))))
          (when process (process-send-string process setting)))))))

;; Brute-force fix: Ensure the setting is injected every time the REPL
;; is selected.
;;
;; Upstream issue: https://github.com/commercialhaskell/intero/issues/569

(advice-add 'intero-repl :after (lambda (&rest r) (intero-fix-ghci-panic))
            '((name . intero-panic-fix)))
(advice-add 'intero-repl-load :after (lambda (&rest r) (intero-fix-ghci-panic))
            '((name . intero-panic-fix)))

(provide 'init_haskell)
