(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/share/ac-dict")
; (global-auto-complete-mode t)

(setq-default ac-sources (append '(ac-source-yasnippet
                ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers) ac-sources))

; (add-to-list 'ac-sources 'ac-source-yasnippet)
;  
; (setf (symbol-function 'yas-active-keys)
;       (lambda ()
;         (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))
(provide 'init_auto-complete)
