(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(define-coding-system-alias 'UTF-8 'utf-8)
(server-start)
;; Package Repositories
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa-stable.milkbox.net/packages/")
			 ("melpa-unstable" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ))
(package-initialize)
;;; Return 押すと勝手に Tab も押される（24.4〜）クソ機能をオフに
(setq electric-indent-mode nil)
(setq use-default-font-for-symbols nil)

;;; ほげふが威風堂々ほげピンチョンfoobar𝔹ℕℤ⟶→∫∈
;;; 123456789012345678901234567890123456ℤ
;;;          , <- 本当は0に合っているべき
;;; ASCII: Menlo、日本語：ヒラギノ角ゴ
;;;               123456789012
;;; ユニコード文字：Cambria Math……は何故か動かない……。

;; (create-fontset-from-ascii-font
;;  "Menlo-18:weight=normal:slant=normal:height=140"
;;  nil "menlokakugo")

;; (set-face-attribute
;;   'default nil
;;   :family "Menlo"
;;   :height 180
;;  )

;; (set-fontset-font
;;  t 'unicode (font-spec :family "Cambria Math")
;;  )
;; (set-fontset-font 
;;  t 'symbol (font-spec :family "Cambria Math")
;;  )

;; (mapc
;;  (lambda (cat)
;;    (set-fontset-font
;;     t cat
;;     (font-spec :family "Hiragino Kaku Gothic ProN")))
;;  (list
;;   'katakana-jisx0201 'japanese-jisx0208 'japanese-jisx0212
;;   'japanese-jisx0213-1 'japanese-jisx0213-2))
;; (set-fontset-font t '(#x0080 . #x024F) "Menlo")

;; (add-to-list 'face-font-rescale-alist
;;              '(".*Hiragino Kaku Gothic ProN.*" . 1.275)
;;              ;; '(".*Cambria Math.*" . 1.2)
;;              )

;; (set-fontset-font t '(#x2115 . #x2115) "Cambria Math")
;; (set-fontset-font t '(#x2192 . #x2192) "Cambria Math")

;; ;;; Menlo+角ゴ+その他を使う
;; ;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))


(let* ((size 17) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
       (asciifont "Menlo") ; ASCIIフォント
       (jpfont "Hiragino Kaku Gothic ProN") ; 日本語フォント
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec) ; 半角カナ
  (set-fontset-font nil '(#x0080 . #x024F) fontspec) ; 分音符付きラテン 
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec) ; ギリシャ文字
  )
;;; フォントサイズの比を設定
(dolist (elt '(("^-apple-hiragino.*" . 1.2)
	       (".*osaka-bold.*" . 1.2)
	       (".*osaka-medium.*" . 1.2)
	       (".*courier-bold-.*-mac-roman" . 1.0)
	       (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	       (".*monaco-bold-.*-mac-roman" . 0.9)))
  (add-to-list 'face-font-rescale-alist elt))

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

(add-to-load-path "lisp/stack-mode" "lisp/skk" "lisp" "local-lisp" "private" "site-start.d")
(add-to-load-path "ProofGeneral" "lisp/liquid-types.el")

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
	      '("~/.emacs.d/bin" "~/.local/bin" "~/.rbenv/shims" "/Library/TeX/texbin"  "/usr/local/bin" "~/usr/bin" "~/Library/Haskell/bin"
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
			 ("melpa" . "http://melpa-stable.milkbox.net/packages/")
			 ("melpa-unstable" . "http://melpa.milkbox.net/packages/")
                         ))
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
 '(coq-compile-before-require t)
 '(helm-boring-file-regexp-list
   (quote
    ("_flymake\\.hs$" "~$" "\\.elc$" "\\.hi$" "\\.DS_Store$" "\\.fdb_latexmk$" "\\.o$" "\\.cabal-sandbox$" ".darcs$" "\\.dvdcss$" "\\.haste$" "\\.synctex\\.gz$")))
 '(helm-buffer-max-length 35)
 '(helm-command-prefix-key "C-z")
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-exit-idle-delay 0)
 '(helm-ff-skip-boring-files t)
 '(helm-ls-git-show-abs-or-relative (quote relative))
 '(helm-truncate-lines t t)
 '(safe-local-variable-values
   (quote
    ((eval setq-local exec-path
           (append
            (quote
             ("/Users/hiromi/.stack/programs/x86_64-osx/ghc-7.8.4/bin/"))
            exec-path))
     (haskell-process-path-ghci . "/Users/hiromi/.local/bin/stack")
     (eval setq exec-path
           (append
            (quote
             ("/Users/hiromi/.stack/programs/x86_64-osx/ghc-7.8.4/bin/"))
            exec-path))
     (eval setq exec-path
           (append
            (quote
             ("Users/hiromi/.stack/programs/x86_64-osx/ghc-7.8.4/bin/"))
            exec-path))
     (haskell-process-args-ghci . "ghci")
     (haskell-process-path-ghci . "~/.local/bin/stack")
     (haskell-indent-spaces . 2)
     (eval setenv "HASKELL_PACKAGE_SANDBOX"
           (expand-file-name "~/.stackage/sandboxes/ghc-7.8.3/lts-2.15/x86_64-osx-ghc-7.8.3-packages.conf.d"))
     (eval
      (let
          ((local
            (concat
             (substring
              (shell-command-to-string "stack path --local-install-root")
              0 -2)
             "/bin"))
           (snaps
            (concat
             (substring
              (shell-command-to-string "stack path --snapshot-install-root")
              0 -2)
             "/bin")))
        (append
         (list local snaps)
         exec-path)))
     (eval setenv "PATH"
           (substring
            (shell-command-to-string "stack path --bin-path")
            0 -2))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (substring
                      (shell-command-to-string "stack path --bin-path")
                      0 -2))
             (setq exec-path
                   (append
                    (list local snaps)
                    exec-path))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (setq exec-path
                   (append
                    (list local snaps)
                    exec-path))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (setq load-path
                   (append
                    (list local snaps)
                    load-path))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (setq load-path
                   (append
                    (quote
                     (local snaps))
                    load-path))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (add-to-list
              (quote load-path)
              (expand-file-name local)
              (quote t))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (add-to-list
              (quote load-path)
              (expand-file-name local)
              (expand-file-name snaps))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (add-to-list
              (quote load-path)
              (list
               (expand-file-name local)
               (expand-file-name snaps)))))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             (concat
              (substring
               (shell-command-to-string "stack path --snapshot-install-root")
               0 -2)
              "/bin")))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (add-to-load-path local snaps)))
     (eval let
           ((local
             (concat
              (substring
               (shell-command-to-string "stack path --local-install-root")
               0 -2)
              "/bin"))
            (snaps
             ((concat
               (substring
                (shell-command-to-string "stack path --snapshot-install-root")
                0 -2)
               "/bin"))))
           (progn
             (setenv "PATH"
                     (concat local ":" snaps ":"
                             (getenv "PATH")))
             (add-to-load-path local snaps)))
     (eval add-to-load-path ".stack-work/install/x86_64-osx/lts-2.15/7.8.4/bin/" "~/.local/bin")
     (eval setenv "PATH"
           (concat ".stack-work/install/x86_64-osx/lts-2.15/7.8.4/bin/:"
                   (getenv "PATH")))
     (haskell-process-type . cabal-ghci)
     (haskell-process-type . cabal-repl)
     (haskell-process-type quote cabal-repl)
     (eval setenv "PATH"
           (concat "/Users/hiromi/.local/bin:"
                   (getenv "PATH")))
     (haskell-process-args-ghci "ghci")
     (haskell-process-path-ghci . "/Users/hiromi/Library/Haskell/bin/stack")
     (haskell-process-type . ghci)
     (haskell-process-args-ghci quote
                                ("ghci"))
     (haskell-process-path-ghci . "~/Library/Haskell/bin/stack")
     (haskell-process-type quote ghci)
     (haskell-process-args-ghci
      ("ghci"))
     (haskell-process-type
      (quote ghci))
     (haskell-process-args-ghci
      (quote
       ("ghci")))
     (haskell-process-path-ghci "~/Library/Haskell/bin/stack")
     (ghc-ghc-options quote
                      ("--with-ghc=/Users/hiromi/.stack/programs/x86_64-osx/ghc-7.8.4/bin/ghc"))
     (eval setenv "HASKELL_PACKAGE_SANDBOX" "/Users/hiromi/.stack/snapshots/x86_64-osx/lts-2.15/7.8.4/pkgdb")
     (hamlet/basic-offset . 4)
     (haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)
     (TeX-master . "config.tex")
     (TeX-master . "main.tex")
     (TeX-master . t)
     (TeX-master . "report02.tex"))))
 '(singular-switches-default (quote ("--browser" "mac")))
 '(yas-prompt-functions (quote (my-yas/prompt)))
 '(yas-triggers-in-field t))

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
(global-set-key [(hyper n)] 'make-frame)
(global-set-key [(hyper q)] 'save-buffers-kill-terminal)
(setq shift-select-mode 't)
(define-key global-map (kbd "<S-mouse-1>") 'exchange-point-and-mark)
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-set-mark)
(setq frame-title-format
  '((:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

(require 'init_main)
(put 'downcase-region 'disabled nil)
