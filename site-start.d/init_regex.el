(require 'visual-regexp-steroids)
(setq vr/engine 'python)                ;python regexpならばこれ
;; (setq vr/engine 'pcre2el)               ;elispでPCREから変換
(global-set-key (kbd "M-%") 'vr/query-replace)
;; multiple-cursorsを使っているならこれで
(global-set-key (kbd "C-c m") 'vr/mc-mark)
;; 普段の正規表現isearchにも使いたいならこれを
(global-set-key (kbd "C-M-r") 'vr/isearch-backward)
(global-set-key (kbd "C-M-s") 'vr/isearch-forward)


; (cond ((require 'foreign-regexp nil t)
;        (custom-set-variables
;        '(foreign-regexp/regexp-type 'ruby)
;        '(reb-re-syntax 'foreign-regexp))))
;  
; (global-set-key "\M-\C-s" 'foreign-regexp/isearch-forward)
; (global-set-key "\M-\C-r" 'foreign-regexp/isearch-backward)
; (global-set-key (kbd "M-C-;") 'foreign-regexp/query-replace)


(provide 'init_regex)
