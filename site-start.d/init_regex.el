(cond ((require 'foreign-regexp nil t)
       (custom-set-variables
       '(foreign-regexp/regexp-type 'ruby)
       '(reb-re-syntax 'foreign-regexp))))

(global-set-key "\M-\C-s" 'foreign-regexp/isearch-forward)
(global-set-key "\M-\C-r" 'foreign-regexp/isearch-backward)
(global-set-key (kbd "M-C-;") 'foreign-regexp/query-replace)


(provide 'init_regex)
