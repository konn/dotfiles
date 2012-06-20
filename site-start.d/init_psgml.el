(require 'psgml)

(setq auto-mode-alist
     (append (list (cons "\\.html\\'" 'xml-mode))
              auto-mode-alist))

(setq auto-mode-alist
     (append (list (cons "\\.shtml\\'" 'xml-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append (list (cons "\\.xml\\'" 'xml-mode))
              auto-mode-alist))

(setq sgml-catalog-files '("CATALOG" "~/.emacs.d/share/psgml/CATALOG"))
(setq sgml-ecat-files '("ECAT" "~/.emacs.d/share/psgml/ECAT"))

(setq sgml-custom-dtd
 '(("HTML 4.01 Strict" 
    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
\"http://www.w3.org/TR/html4/strict.dtd\">")
   ("HTML 4.01 Translational" 
    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Translational//EN\"
\"http://www.w3.org/TR/html4/loose.dtd\">")
   ("HTML 4.01 Frameset" 
    "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\"
\"http://www.w3.org/TR/html4/frameset.dtd\">")
   ("XHTML 1.0 Strict" 
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n")
   ("XHTML 1.0 Translational" 
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Translational//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n")
   ("XHTML 1.0 Frameset" 
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\"
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">\n")
   ("XHTML 1.1"
    "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\"
\"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n")
))


(provide 'init_psgml)
