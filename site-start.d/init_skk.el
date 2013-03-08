(load "/Applications/Emacs.app/Contents/Resources/site-lisp/skk/ccc.el")
(ccc-setup)
(require 'skk-setup)
(require 'skk-study)
(global-set-key "\C-x\C-j" 'skk-mode)

;; skk-server AquaSKK
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")


;;ユーザインターフェース

(setq skk-delete-implies-kakutei nil)
(setq skk-special-midashi-char-list '(?> ?<))
(setq skk-egg-like-newline t)
(setq skk-use-numeric-conversion t)
(setq skk-share-private-jisyo t)
(setq skk-kakutei-key "\C-o")

(setq skk-rom-kana-rule-list
      (append '(("." nil skk-period))
	      skk-rom-kana-rule-list))

(defcustom skk-disable-kcode-input nil
  "Non-nil であれば、￥キーによる漢字コード入力を無効にする。筈。"
  :type 'boolean
  :group 'skk-basic)

(setq skk-disable-kcode-input t)
(setq skk-rom-kana-rule-list
      (append '(("\\" nil skk-kcode-input-hook)) skk-rom-kana-rule-list))
(defun skk-kcode-input-hook (&optional arg)
  "skk-disable-kcode-input が nil なら skk-input-by-code-or-menu を呼び、そうでなければ\\を入力する"
  (if skk-disable-kcode-input
      "\\"
    (skk-list-chars arg)
  ))

(defun skk-period (arg)
  (let ((c (char-before (point))))
    (cond ((null c) "．")
	  ((and (<= ?0 c) (>= ?9 c)) ".")
	  ((and (<= ?０ c) (>= ?９ c)) "．")
	  (t "．"))))

(setq skk-rom-kana-rule-list
      (cons '("," nil skk-comma) skk-rom-kana-rule-list))

(defun skk-comma (arg)
  (let ((c (char-before (point))))
    (cond ((null c) "，")
	  ((and (<= ?0 c) (>= ?9 c)) ",")
	  ((and (<= ?０ c) (>= ?９ c)) "，")
	  (t "，"))))
(setq skk-kutouten-type 'en)

;; キー設定
(setq skk-rom-kana-rule-list
      (append skk-rom-kana-rule-list
              '(("@" nil "@")
		("$" nil "$")
		("(" nil "（")
		(")" nil "）")
		("!" nil "！"))))

(provide 'init_skk)
