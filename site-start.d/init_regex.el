(cond ((require 'foreign-regexp nil t)
       (custom-set-variables
       '(foreign-regexp/regexp-type 'ruby)
       '(reb-re-syntax 'foreign-regexp))))

(provide 'init_regex)
