(require 'ispell)
(require 'rw-language-and-country-codes)
(require 'rw-ispell)
(require 'rw-hunspell)

(setenv "LANG" "ja_JP")
(setenv "DICTIONARY" "en_GB-ise")
(setq ispell-program-name "/usr/local/bin/hunspell")
(setq ispell-really-hunspell t)                            ;hunspellの拡張を使う
(setq ispell-dictionary "en_GB-ise")
(setq ispell-hunspell-dict-paths-alist
      '((nil       "/Users/hiromi/Library/Spelling/en_GB-ise.aff")
        ("en_Math" "/Users/hiromi/Library/Spelling/en_Math.aff")
        ("en_GB"   "/Users/hiromi/Library/Spelling/en_GB-ise.aff")
        ("en_GB-ise"   "/Users/hiromi/Library/Spelling/en_GB-ise.aff")
        ))

(custom-set-variables
 '(rw-hunspell-dicpath-list (quote ("/Users/hiromi/Library/Spelling")))
 '(rw-hunspell-default-dictionary "en_GB-ise")
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
)


(add-to-list 'ispell-dictionary-alist
              '("en_GB-ise"
                "[[:alpha:]]"
                "[^[:alpha:]]"
                "[']"
                t
                ("-d" "en_GB-ise" "-p" "/Users/hiromi/Library/Spelling")
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
