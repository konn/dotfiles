(require 'helm)
(require 'helm-config)
(global-unset-key (kbd "C-z"))


(helm-mode 1)
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-C-t") 'helm-etags-select)
(global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(custom-set-variables
   '(helm-truncate-lines t)
   '(helm-buffer-max-length 35)
   '(helm-delete-minibuffer-contents-from-point t)
   '(helm-ff-skip-boring-files t)
   '(helm-boring-file-regexp-list '("_flymake\\.hs$" "~$" "\\.elc$" "\\.hi$" "\\.DS_Store$" "\\.fdb_latexmk$" "\\.o$" "\\.cabal-sandbox$" "\.darcs$" "\\.dvdcss$" "\\.haste$" "\\.synctex\\.gz$"))
   '(helm-ls-git-show-abs-or-relative 'relative)
   '(helm-command-prefix-key "C-z")
   '(helm-exit-idle-delay 0)
   )

(defvar helm-c-source-ghc-mod
  '((name . "GHC Browse Documennt")
    (init . helm-c-source-ghc-mod)
    (candidates-in-buffer)
    (candidate-number-limit . 9999)
    (action . helm-c-source-ghc-mod-action)))

(defun helm-c-source-ghc-mod ()
  (with-current-buffer (helm-candidate-buffer 'global)
    (unless (call-process-shell-command "ghc-mod list" nil t t)
      (error "Failed 'ghc-mod list'"))))

(defun helm-c-source-ghc-mod-action (candidate)
  (let ((pkg (ghc-resolve-document-path candidate)))
    (if (and pkg candidate)
        (ghc-display-document pkg candidate nil)
      (error (format "Not found %s(Package %s)" candidate pkg)))))
 
(defun helm-ghc-browse-document ()
  (interactive)
  (helm :sources '(helm-c-source-ghc-mod)
        :buffer (get-buffer-create "*helm-ghc-document*")))

(define-key helm-command-map (kbd "g") 'helm-ag)
(define-key helm-command-map (kbd "o") 'helm-occur)
(define-key helm-command-map (kbd "y") 'yas/insert-snippet)
(define-key helm-command-map (kbd "M-/") 'helm-dabbrev)
(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

(provide 'init_helm)
