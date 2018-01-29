;;==============================================================>
;;    CoCoA5-Emacs CUSTOMIZATION: 
;;==============================================================>
;; probably you do not need to change any of these:

;; PATH of the CoCoA5 directory:
;(setq cocoa5-install-dir "/usr/local/cocoa-5.0/")    ;Unix/Linux
(setq cocoa5-install-dir "/Applications/CoCoA-5.0/") ;Mac
;(setq cocoa5-install-dir "/cocoa-5.0/")              ;Win


;; PATH for the "cocoa5.el" file
(setq load-path (cons (concat cocoa5-install-dir "emacs/") load-path))


;; PATH for the "cocoa5" start-up script file
;; this usually works:
(setq cocoa5-executable (concat cocoa5-install-dir "CoCoAInterpreter"))
(setq cocoa5-packages   (concat cocoa5-install-dir "packages"))
;; if you moved the binaries into another directory, set the complete path:
;(setq cocoa5-executable "/usr/local/bin/cocoa5")

;; PATH for the file containing the function names (to use dabbrev)
(setq cocoa5-wordlist-default-file (concat cocoa5-install-dir "CoCoAManual/wordlist.txt"))

;; PATH of the directory where you usually save your CoCoA files:
(setq cocoa5-dir "~/CoCoA/")

;; DEFAULT PROMPT IN EMACS
(setq  cocoa5-default-prompt "/**/")
;(setq  cocoa5-default-prompt "/* */") ;; Win



;;==============================================================>

;; ------------------------------------------------------------
;; AUTO-LOAD cocoa5.el for running CoCoA5 and cocoa5-mode for files
;; with CoCoA5 extensions
(autoload 'c5           "cocoa5.el" "CoCoA5 running mode" 't)
(autoload 'cpkg5        "cocoa5.el" "CoCoA5 running mode" 't)
(autoload 'cocoa5       "cocoa5.el" "CoCoA5 running mode" 't)
(autoload 'cocoa5server "cocoa5.el" "CoCoA5 running mode" 't)
(autoload 'cocoa5-mode  "cocoa5.el" "CoCoA5 editing mode" 't)

(setq auto-mode-alist  (append auto-mode-alist '(
  ("\\.\\(cpkg5\\|cocoa5\\|cocoa5rc\\|c5\\)\\'" . cocoa5-mode) )))

;; ------------------------------------------------------------
;; AUTO-LOAD wordlist when running CoCoA5 or using cocoa5-mode
(setq cocoa5-auto-load-wordlist 't)

;; ------------------------------------------------------------
;; AUTOMATIC CAPITALIZATION of CoCoA5 keywords:
(add-hook 'cocoa5-mode-hook '(lambda () (abbrev-mode 't)))

;; ------------------------------------------------------------
;; ------ OTHER USEFUL SETTINGS ------
;; ------------------------------------------------------------

;; ------------------------------------------------------------
;; AUTO-LOAD CUA-mode (COPY & PASTE with C-c C-x C-v C-z keys)
;; This is inactive by default! 
;; To activate it uncomment these two lines (remove ";") 
;(require 'cua)
;(CUA-mode 't)

;; ------------------------------------------------------------
;; TAB FOR COMPLETION
;; *customize* with menu "CoCoA5 --> Preferences"
;;     [ same as "<ESC>-x  customize-group <RET> cocoa5"
;;       sets (defvar cocoa-tab-is-completion nil)  ]
;; *or* uncomment the following line
;(defvar cocoa5-tab-is-completion 't)

;; ------------------------------------------------------------
;; OPEN RECENT: 
(require 'recentf)
(recentf-mode 1)

;; ------------------------------------------------------------
;; HIGHLIGHT REGION BETWEEN PARENTHESIS
(require 'paren)
(show-paren-mode 't)
(setq show-paren-style 'expression)

;; ------------------------------------------------------------
;; WORD COMPLETION: 
;; dynamic abbrev expansion (M-/) replace also CASE PATTERN 
(setq dabbrev-case-replace nil)

;; ------------------------------------------------------------
;; COLOURED SYNTAX (font-lock-mode)
(require 'font-lock) 

;(if window-system 
;    (if (string-match "XEmacs" (emacs-version))
;	(font-lock-mode 't)
;      (global-font-lock-mode 't)      )
;  nil)

;; but if you want font-lock-mode ONLY in cocoa5-mode 
;; or if you use XEmacs, you might have to choose these instead:
(if window-system (font-lock-mode 't) nil)
(add-hook 'cocoa5-mode-hook '(lambda () (font-lock-mode 't)))

;; ------------------------------------------------------------
;; ENABLE MOUSE WHEEL
;(setq mouse-wheel-mode 't)

;; ------------------------------------------------------------
;; PREVENT EXTRANEOUS TABS
;(setq indent-tabs-mode 0)

;; ------------------------------------------------------------
;; DISCARD ALL ctrl-m CHARACTERS FROM SHELL OUTPUT
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

;; ------------------------------------------------------------
;; MY PREFERRED SET OF COLOURS ;-)

;; ------------------------------------------------------------
(provide 'init_CoCoA)
