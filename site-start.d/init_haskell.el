(require 'haskell-site-file)

(require 'haskell-mode)
(require 'inf-haskell)
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
		("\\.hers$"   . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)

(setq haskell-literate-default 'latex)
(setq haskell-doc-idle-delay 0)


(autoload 'ghc-init "ghc" nil t)
(defun my/haskell-mode-hook ()
  (progn (setq tab-width 4 indent-tabs-mode nil)))
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'my/haskell-mode-hook)

;; flymake-haskell
 (require 'flymake)
(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))
(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "flycheck_haskell.pl"
	(list source base-dir)))

(push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push
 '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)


(provide 'init_haskell)
