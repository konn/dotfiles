(load "~/.emacs.d/lisp/skk/ccc.el")
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
      (cons '("." nil skk-period) skk-rom-kana-rule-list))

(defun skk-period (arg)
  (let ((c (char-before (point))))
    (cond ((null c) "。")
	  ((and (<= ?0 c) (>= ?9 c)) ".")
	  ((and (<= ?０ c) (>= ?９ c)) "．")
	  (t "。"))))

(setq skk-rom-kana-rule-list
      (cons '("," nil skk-comma) skk-rom-kana-rule-list))

(defun skk-comma (arg)
  (let ((c (char-before (point))))
    (cond ((null c) "、")
	  ((and (<= ?0 c) (>= ?9 c)) ",")
	  ((and (<= ?０ c) (>= ?９ c)) "，")
	  (t "、"))))

(provide 'init_skk)