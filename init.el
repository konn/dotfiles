(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(server-start)

;;; ほげふが威風堂々ほげピンチョンfoobar
;;; 123456789012345678901234567890123456
;;; ASCII: Menlo、日本語：角ゴ、ユニコード文字：Cambria Math
;;;               123456789012
(create-fontset-from-ascii-font "Menlo-16:weight=normal:slant=normal" nil "menlokakugo")
;(set-face-attribute 'default nil
;                     :family "menlo"
;                     :height 140)
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

;;; Return 押すと勝手に Tab も押される（24.4〜）クソ機能をオフに
(setq electric-indent-mode nil)
;;; Menlo+角ゴ+その他を使う
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

(setq tab-width 2 indent-tabs-mode nil)  
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "lisp/skk" "lisp" "local-lisp" "private" "site-start.d")
(add-to-load-path "ProofGeneral")

;; 終了時バイトコンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p (concat user-emacs-directory "init.el") (concat user-emacs-directory "init.elc"))
                (byte-compile-file (concat user-emacs-directory "init.el")))
            (byte-recompile-directory (concat user-emacs-directory "local-lisp") 0)
            (byte-recompile-directory (concat user-emacs-directory "private") 0)
            (byte-recompile-directory (concat user-emacs-directory "site-start.d") 0)
            ))

;(add-hook 'kill-emacs-hook 'my-kill-hook)
;
;(defun my-kill-hook ()
;  (let ((default-directory "~/.emacs.d/"))
;    (call-process "git" nil "*sync*" 't "add" "share")
;    (call-process "git" nil "*sync*" 't "add" "site-start.d")
;    (call-process "git" nil "*sync*" 't "commit" "-a" "-m" "daily commit")
;    (call-process "git" nil "*sync*" 't "push")
;    )
;  )

(setq browse-url-browser-function 'browse-url-default-macosx-browser)

(setq install-elisp-repository-directory "~/.emacs.d/lisp")

(setq my-paths 
      (mapcar 'expand-file-name
	      '("~/.rbenv/shims" "/usr/texbin"  "/usr/local/bin" "~/usr/bin" "~/Library/Haskell/bin"
		"~/prog/idris/.cabal-sandbox/bin"
		;"/usr/local/ghc-7.8/bin"
		)))

(setq exec-path
      (append my-paths exec-path))
(setenv "PATH"
    (concat (mapconcat (lambda (x) x) my-paths ":") '":" (getenv "PATH")))

;; Package Repositories
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;(require 'alloy-mode)
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

(cua-mode t)
(setq cua-enable-cua-keys nil)

(setq initial-major-mode 'fundamental-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda-input-user-translations (\` (("bb" "𝔹"))))
 '(agda2-include-dirs (list (expand-file-name "~/.agda/lib/stdlib") "."))
 '(company-ghc-show-info t)
 '(foreign-regexp/regexp-type (quote ruby))
 '(haskell-interactive-prompt "ghci> " t)
 '(haskell-literate-default (quote latex))
 '(haskell-notify-p t)
 '(haskell-process-args-ghci (quote ("ghci")))
 '(haskell-process-path-ghci "~/Library/Haskell/bin/cab")
 '(haskell-process-type (quote cabal-repl))
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(helm-boring-file-regexp-list
   (quote
    ("_flymake\\.hs$" "~$" "\\.elc$" "\\.hi$" "\\.DS_Store$" "\\.fdb_latexmk$" "\\.o$" "\\.cabal-sandbox$" ".darcs$" "\\.dvdcss$" "\\.haste$" "\\.synctex\\.gz$")))
 '(helm-buffer-max-length 35)
 '(helm-command-prefix-key "C-z")
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-exit-idle-delay 0)
 '(helm-ff-skip-boring-files t)
 '(helm-ls-git-show-abs-or-relative (quote relative))
 '(helm-truncate-lines t)
 '(reb-re-syntax (quote foreign-regexp))
 '(safe-local-variable-values
   (quote
    ((TeX-master . "main.tex")
     (TeX-master . t)
     (TeX-master . "report02.tex"))))
 '(singular-switches-default (quote ("--browser" "mac")))
 '(turn-on-haskell-ghci nil)
 '(yas-prompt-functions (quote (my-yas/prompt))))

(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)

;; Mac switch meta key
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)

(defun myshiftclick (click)
  (interactive "e")
  (mouse-set-mark)
  (mouse-set-point)
  (mouse-set-mark))

(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)] 'delete-frame)
(global-set-key [(hyper x)] 'kill-region)
(global-set-key [(hyper z)] 'undo)
(global-set-key [(hyper k)] 'kill-this-buffer)
(global-set-key [(hyper n)] 'new-frame)
(global-set-key [(hyper q)] 'save-buffers-kill-terminal)
(setq shift-select-mode 't)
(define-key global-map (kbd "<S-mouse-1>") 'exchange-point-and-mark)
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-set-mark)
(setq frame-title-format
  '((:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

(require 'init_main)
