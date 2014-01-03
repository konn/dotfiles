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
  (defvar user-emacs-directory (expand-file-name "/Users/hiromi/.emacs.d/")))

(setq tab-width 2 indent-tabs-mode nil)  
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-list 'load-path (expand-file-name "/Users/hiromi/install/structured-haskell-mode/elisp/"))

(add-to-load-path "lisp/skk" "lisp" "local-lisp" "private" "site-start.d")
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

(setq browse-url-browser-function 'browse-url-default-macosx-browser)

(setq install-elisp-repository-directory "/Users/hiromi/.emacs.d/lisp")

(setq exec-path
      (append '("/Users/hiromi/.rbenv/shims" "/usr/texbin"  "/usr/local/bin" "/Users/hiromi/usr/bin" "/Users/hiromi/Library/Haskell/bin" "/Users/hiromi/prog/idris/.cabal-sandbox/bin" )
	      exec-path))
(setenv "PATH"
    (concat '"/Users/hiromi/.rbenv/shims:/Users/hiromi/prog/idris/.cabal-sandbox/bin:/usr/texbin:/usr/local/bin:/Users/hiromi/Library/Haskell/bin:/Users/hiromi/usr/bin:/Users/hiromi/.cabal/bin:/usr/local/bin:" (getenv "PATH")))

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
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil))))
 '(shm-current-face ((t (:background "dark gray"))))
 '(shm-quarantine-face ((t (:background "LightPink1")))))
(fset 'yes-or-no-p 'y-or-n-p)

;; 句読点変換(M-x tenmaru / M-x commamaru / M-x commaperiod)
;; http://d.hatena.ne.jp/takehikom/20120713/1342122621
(defun replace-punctuation (a1 a2 b1 b2)
  "Replace periods and commas"
  (save-excursion
    (let ((s1 (if mark-active "選択領域" "バッファ全体"))
	  (s2 (concat a2 b2))
	  (b (if mark-active (region-beginning) (point-min)))
	  (e (if mark-active (region-end) (point-max))))
      (if (y-or-n-p (concat s1 "の句読点を「" s2 "」にしますがよろしいですか?"))
	  (progn
	    (replace-string a1 a2 nil b e)
	    (replace-string b1 b2 nil b e))))))
 
(defun tenmaru ()
  "選択領域またはバッファ全体の句読点を「、。」にします"
  (interactive)
  (replace-punctuation "，" "、" "．" "。"))
 
(defun commamaru ()
  "選択領域またはバッファ全体の句読点を「，。」にします"
  (interactive)
  (replace-punctuation "、" "，" "．" "。"))
 
(defun commaperiod ()
  "選択領域またはバッファ全体の句読点を「，．」にします"
  (interactive)
  (replace-punctuation "、" "，" "。" "．"))

(setq initial-major-mode 'fundamental-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-include-dirs (quote ("/Users/hiromi/.agda/lib/stdlib" ".")))
 '(haskell-interactive-prompt "ghci> ")
 '(haskell-literate-default (quote latex))
 '(haskell-notify-p t)
 '(haskell-process-path-cabal "/Users/hiromi/Library/Haskell/bin/cabal")
 '(haskell-process-type (quote cabal-repl))
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(singular-switches-default (quote ("--browser" "mac")))
 '(turn-on-haskell-ghci nil))
