(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

(create-fontset-from-ascii-font "Menlo-16:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                   nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

(setq tab-width 4 indent-tabs-mode nil)  
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "lisp" "local-lisp" "private" "site-start.d")
(add-to-load-path "ProofGeneral-4.0pre100817")

;; 終了時バイトコンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p (concat user-emacs-directory "init.el") (concat user-emacs-directory "init.elc"))
                (byte-compile-file (concat user-emacs-directory "init.el")))
            (byte-recompile-directory (concat user-emacs-directory "local-lisp") 0)
            (byte-recompile-directory (concat user-emacs-directory "private") 0)
            (byte-recompile-directory (concat user-emacs-directory "site-start.d") 0)
            ))

(require 'init_main)

(require 'agda2)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "/Users/hiromi/.cabal/bin/agda-mode locate")))

(require 'auto-complete)
(global-auto-complete-mode t)


(load "rrb")

(autoload 'imaxima "imaxima" "Image support for Maxima." t)


(setq exec-path (append '("/opt/local/bin" "/usr/local/bin" "~/usr/bin" "~/.cabal/bin/") exec-path))
(setenv "PATH"
    (concat '"/opt/local/bin:/usr/local/bin:~/usr/bin:~/.cabal/bin:/usr/local/bin:" (getenv "PATH")))


(server-start)