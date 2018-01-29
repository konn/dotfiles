(add-to-list 'load-path "/Applications/Singular.app/Contents/share/singular/emacs/")
(add-to-list 'exec-path "/Applications/Singular.app/Contents/bin")
(require 'singular)
(custom-set-variables
 '(singular-switches-default '("--browser" "mac"))
 )

(provide 'init_singular)
