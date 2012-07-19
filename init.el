(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(server-start)
(create-fontset-from-ascii-font "Menlo-16:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'japanese-jisx0208
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                   nil
                  'append)
(set-fontset-font "fontset-menlokakugo"
                  'japanese-jisx0212
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                   nil
                  'append)
(set-fontset-font "fontset-menlokakugo"
		  'unicode
		  (font-spec :family "Cambria Math" :size 16)
                   nil
                  'append)
(create-fontset-from-ascii-font "Ricty-18:weight=normal:slant=normal" nil "rictykakugo")
(set-fontset-font "fontset-rictykakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                   nil
                  'append)
(create-fontset-from-ascii-font "Menlo-16:weight=normal:slant=normal" nil "menlomincho")
(set-fontset-font "fontset-menlomincho"
                  'unicode
                  (font-spec :family "Hiragino Mincho ProN" :size 16)
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
(add-to-load-path "lisp/skk")

;; 終了時バイトコンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p (concat user-emacs-directory "init.el") (concat user-emacs-directory "init.elc"))
                (byte-compile-file (concat user-emacs-directory "init.el")))
            (byte-recompile-directory (concat user-emacs-directory "local-lisp") 0)
            (byte-recompile-directory (concat user-emacs-directory "private") 0)
            (byte-recompile-directory (concat user-emacs-directory "site-start.d") 0)
            ))

(setq browse-url-browser-function 'browse-url-default-macosx-browser)

(setq exec-path
      (append '("/usr/texbin"  "/usr/local/bin" "/Users/hiromi/usr/bin" "/Users/hiromi/Library/Haskell/bin")
	      exec-path))
(setenv "PATH"
    (concat '"/usr/texbin:/usr/local/bin:/Users/hiromi/Library/Haskell/bin:~/usr/bin:~/.cabal/bin:/usr/local/bin:" (getenv "PATH")))

;; Package Repositories
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(require 'init_main)
(require 'alloy-mode)
(require 'auto-complete)
(global-auto-complete-mode t)
