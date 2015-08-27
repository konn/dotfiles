(require 'yasnippet)
(setq yas-trigger-key "<C-tab>")

(require 'em-glob)

(setq yas-snippet-dirs
      (list "~/.emacs.d/share/snippets" ;; 作成するスニペットはここに入る
        (car (eshell-extended-glob "~/.emacs.d/elpa/yasnippet-*/snippets/"))))

(yas-global-mode nil)

(custom-set-variables
 '(yas-triggers-in-field t))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(add-to-list 'auto-mode-alist '("/Users/.*/.emacs.d/share/snippets/.*\\'" . snippet-mode))

(eval-after-load "helm"
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (helm-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*helm yas/prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))))


; (require 'abbrev)
; (add-hook 'sgml-mode-hook
; 	  '(lambda ()
; 	     (setq-default abbrev-mode t)
; 	     (snippet-with-abbrev-table 'local-abbrev-table
;   ("xhtml" . "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
; <!DOCTYPE html
;     PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
;     \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
; 
; <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"ja\" lang=\"ja\">
; 
; <head>
;     <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
;     <meta name=\"generator\" content=\"Emacs psgml+snippet-mode\" />
;     <meta name=\"keywords\" content=\"\" />
;     <meta name=\"description\" content=\"\" />
;     <link rev=\"made\" title=\"作成者\" href=\"mailto:konn.jinro_at_gmail.com\" />
;     <link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"design.css\" />
;     <title>$${title}</title>
; </head>
; <body>
; <h1>$${title}</h1>
; <p>$.</p>
; </body>
; </html>"
;    )
;   ("img"  . "<img src=\"$${src}\" alt=\"$${alt}\" />")
;   ("href" . "<a href=\"$${href}\">$.</a>")
;   ("htsect" . "<h2>$${title}</h2>\n<p\n$>>$.</p>")
;   )
; 	     )
; )
(provide 'init_snippet)
