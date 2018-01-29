(require 'multiple-cursors)
(require 'mc-extras)

;; Stolen from http://qiita.com/ShingoFukuyama/items/3ad7e24cb2d8f55b4cc5.
;; insert specific serial number
(defvar my/mc/insert-numbers-hist nil)
(defvar my/mc/insert-numbers-inc 1)
(defvar my/mc/insert-numbers-pad "%01d")

(defun my/mc/insert-numbers (start inc pad)
  "Insert increasing numbers for each cursor specifically."
  (interactive
   (list (read-number "Start from: " 0)
         (read-number "Increment by: " 1)
         (read-string "Padding (%01d): " nil my/mc/insert-numbers-hist "%01d")))
  (setq mc--insert-numbers-number start)
  (setq my/mc/insert-numbers-inc inc)
  (setq my/mc/insert-numbers-pad pad)
  (mc/for-each-cursor-ordered
   (mc/execute-command-for-fake-cursor
    'my/mc--insert-number-and-increase
    cursor)))

(defun my/mc--insert-number-and-increase ()
  (interactive)
  (insert (format my/mc/insert-numbers-pad mc--insert-numbers-number))
  (setq mc--insert-numbers-number (+ mc--insert-numbers-number my/mc/insert-numbers-inc)))

(provide 'init_multiple-cursors)
