(defun YaTeX::mathcal (&optional argp)
  (cond
   ((equal argp 1)
    (read-string "Enter string: "
		 "")
    )
   ))

(defun YaTeX::mathfrak (&optional argp)
  ;(cond
   ;((equal argp 1)
    (read-string "Enter string: "
		 "")
    )
   ;))

(defun YaTeX::mathbf (&optional argp)
  (cond
   ((equal argp 1)
    (read-string "Enter string: "
		 "")
    )
   ))
(defun YaTeX::mathbb (&optional argp)
  ;(cond
   ;((equal argp 1)
    (read-string "Enter string: "
		 "")
    )
   ;))

(defun YaTeX:ruby ()
  (let ((kind (char-to-string (read-char "Enter ruby mode (default g): "))))
    (cond
     ((string= kind "j") "[j]")
     ((string= kind "\r") "")
     ((string= kind "g") "[g]")
     ((string= kind "m") "[mg]")
     (t "[g]")
     )))

(defun YaTeX::ruby (n)
  (cond
   ((= n 1) (read-string "Body: "))
   ((= n 2) (read-string "Kana: "))
   (t nil)
  ))

(defun YaTeX::ruby-region (beg end)
  (let ((kana (concat "{" (read-string "Kana: ") "}")))
    (goto-char end)
    (insert kana)
    (forward-char (length kana))
    ))

(defun YaTeX:jruby ()
  (let ((kind (char-to-string (read-char "Enter jruby mode (default g): "))))
    (cond
     ((string= kind "j") "[j]")
     ((string= kind "\r") "")
     ((string= kind "g") "[g]")
     ((string= kind "m") "[mg]")
     (t "[g]")
     )))

(defun YaTeX::jruby (n)
  (cond
   ((= n 1) (read-string "Body: "))
   ((= n 2) (read-string "Kana: "))
   (t nil)
  ))

(defun YaTeX::jruby-region (beg end)
  (let ((kana (concat "{" (read-string "Kana: ") "}")))
    (goto-char end)
    (insert kana)
    (forward-char (length kana))
    ))

(defun YaTeX:footcite ()
  (let ((postnote (read-string "Postnote: "))
	(prenote (read-string "Prenote: ")))
    (if (string= prenote "")
	(if (string= postnote "")
	    ""
	  (concat "[" postnote "]"))
      (concat "[" postnote "]" "[" prenote "]")
      )))

(defun YaTeX:pbox ()
  (let ((kind (char-to-string (read-char "Enter kumi mode (default y): "))))
    (cond
     ((string= kind "y") "<y>")
     ((string= kind "t") "<t>")
     ((string= kind "z") "<z>")
     (t "<y>")
      )))

(defun YaTeX::mathds (&optional argp)
  ;(cond
   ;((equal argp 1)
    (read-string "Enter string: "
		 "")
    )
   ;))

(defun YaTeX::mathrm (&optional argp)
  (cond
   ((equal argp 1)
    (read-string "Enter string: "
		 "")
    )
   ))
