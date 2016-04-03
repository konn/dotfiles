(require 'ispell)
(require 'rw-language-and-country-codes)
(require 'rw-ispell)
(require 'rw-hunspell)

(setenv "LANG" "ja_JP")
(setenv "DICTIONARY" "en_US")
(setq ispell-program-name "/usr/local/bin/hunspell")
(setq ispell-dictionary "en_US")
  
(custom-set-variables
 '(rw-hunspell-dicpath-list (quote ("/Users/hiromi/Library/Spelling")))
 '(rw-hunspell-default-dictionary "en_US")
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
)

(add-to-list 'ispell-dictionary-alist
              '("english-hunspell"
                "[[:alpha:]]"
                "[^[:alpha:]]"
                "[']"
                t
                ("-d" "en_US" "-p" "/Users/hiromi/Library/Spelling")
                nil
                UTF-8))

(require 'langtool)
(setq langtool-language-tool-jar "/usr/local/Cellar/languagetool/3.0/libexec/languagetool-commandline.jar"
      langtool-mother-tongue "ja"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"
                                "CURRENCY"))
 
(provide 'init_spell)
