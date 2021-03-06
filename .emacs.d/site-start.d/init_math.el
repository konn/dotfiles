(require 'math-symbol-lists)
(quail-define-package "math" "UTF-8" "Ω" t)
(quail-define-rules ; add whatever extra rules you want to define here...
 ("\\from"    #X2190)
 ("\\to"      #X2192)
 ("\\lhd"     #X22B2)
 ("\\rhd"     #X22B3)
 ("\\unlhd"   #X22B4)
 ("\\unrhd"   #X22B5)
 ("\\bA"       #x1d538)
 ("\\bB"       #x1d539)
 ("\\bC"       #x2102)
 ("\\bD"       #x1d53b)
 ("\\bE"       #x1d53c)
 ("\\bF"       #x1d53d)
 ("\\bG"       #x1d53e)
 ("\\bH"       #x210d)
 ("\\bI"       #x1d540)
 ("\\bJ"       #x1d541)
 ("\\bK"       #x1d542)
 ("\\bL"       #x1d543)
 ("\\bM"       #x1d544)
 ("\\bN"       #x2115) 
 ("\\bO"       #x1d546)
 ("\\bP"       #x2119)
 ("\\bQ"       #x211a)
 ("\\bR"       #x211d)
 ("\\bS"       #x1d54a)
 ("\\bT"       #x1d54b)
 ("\\bU"       #x1d54c)
 ("\\bV"       #x1d54d)
 ("\\bW"       #x1d54e)
 ("\\bX"       #x1d54f)
 ("\\bY"       #x1d550)
 ("\\bZ"       #x2124)
 ("\\[["      #X27E6)
 ("\\]]"      #X27E7)
 ("\\BB"      #X1D539)
 ("\\PP"      #x2119)
 ("\\QQ"      #x211A)
 ("\\::"      #x2237)
 ("\\:a"      #x3b1)
 ("\\:b"      #x3b2)
 ("\\:g"      #x3b3)
 ("\\:d"      #x3b4)
 ("\\:e"      #x3b5)
 ("\\:z"      #x3b6)
 ("\\:et"     #x3b7)
 ("\\:th"     #x3b8)
 ("\\:th-"    #x3d1)
 ("\\:i"      #x3b9)
 ("\\:k"      #x3ba)
 ("\\:l"      #x3bb)
 ("\\:m"      #x3bc)
 ("\\:n"      #x3bd)
 ("\\:x"      #x3be)
 ("\\:o"      #x3bf)
 ("\\:p"      #x3c0)
 ("\\:r"      #x3c1)
 ("\\:s"      #x3c3)
 ("\\:s-"     #x3c2)
 ("\\:t"      #x3c4)
 ("\\:u"      #x3c5)
 ("\\:ph"     #x3c6)
 ("\\:ph-"    #x3d5)
 ("\\:ch"     #x3c7)
 ("\\:ps"     #x3c8)
 ("\\:om"     #x3c9)
 ("\\GA"      #x391)
 ("\\GB"      #x392)
 ("\\GG"      #x393)
 ("\\GD"      #x394)
 ("\\GE"      #x395)
 ("\\GZ"      #x396)
 ("\\GEt"     #x397)
 ("\\GTh"     #x398)
 ("\\GI"      #x399)
 ("\\GK"      #x39a)
 ("\\GL"      #x39b)
 ("\\GM"      #x39c)
 ("\\GN"      #x39d)
 ("\\GX"      #x39e)
 ("\\GO"      #x39f)
 ("\\GP"      #x3a0)
 ("\\GR"      #x3a1)
 ("\\GS"      #x3a3)
 ("\\GT"      #x3a4)
 ("\\GU"      #x3a5)
 ("\\GPh"     #x3a6)
 ("\\GCh"     #x3a7)
 ("\\GPs"     #x3a8)
 ("\\GOm"     #x3a9)
 ("\\Ga"      #x3b1)
 ("\\Gb"      #x3b2)
 ("\\Gg"      #x3b3)
 ("\\Gd"      #x3b4)
 ("\\Ge"      #x3b5)
 ("\\Gz"      #x3b6)
 ("\\Get"     #x3b7)
 ("\\Gth"     #x3b8)
 ("\\Gth-"    #x3d1)
 ("\\Gi"      #x3b9)
 ("\\Gk"      #x3ba)
 ("\\Gl"      #x3bb)
 ("\\Gm"      #x3bc)
 ("\\Gn"      #x3bd)
 ("\\Gx"      #x3be)
 ("\\Go"      #x3bf)
 ("\\Gp"      #x3c0)
 ("\\Gr"      #x3c1)
 ("\\Gs"      #x3c3)
 ("\\Gs-"     #x3c2)
 ("\\Gt"      #x3c4)
 ("\\Gu"      #x3c5)
 ("\\Gph"     #x3c6)
 ("\\Gph-"    #x3d5)
 ("\\Gch"     #x3c7)
 ("\\Gps"     #x3c8)
 ("\\Gom"     #x3c9)
 ("\\->"      #X2192)
 ("\\-->"     #x27f6)
 ("\\==>"     #x27f9)
 ("\\=>"      #x21d2)
 ("\\."       #x22c5)
 ("\\|\\|"    #x2135)
 ("\\{"       #x2208)
 ("\\{/"      #x2209)
 ("\\()"      #x2322)
 ("\\|`"      #x21be)
 ("\\>->"     #x21a3)
 ("\\->>"     #x21a0)
 ("\\<>"      #x2662)
 ("\\<|"      #x22b2)
 ("\\|>"      #x22b3)
 ("\\;U"       #x22c3)
 ("\\/>"      #x2197)
 ("\\<(-"     #x227c)
 ("\\<("      #x227a)
 ("\\)>"      #x227b)
 ("\\)>-"     #x227d)
 ("\\|v"      #x2193)
 ("\\|^"      #x2191)
 ("\\^i"      #x2071)
 ("\\^0"      #x2070)
 ("\\^1"      #x00b9)
 ("\\^2"      #x00b2)
 ("\\^3"      #x00b3)
 ("\\^4"      #x2074)
 ("\\^5"      #x2075)
 ("\\^6"      #x2076)
 ("\\^7"      #x2077)
 ("\\^8"      #x2078)
 ("\\^9"      #x2079)
 ("\\^+"      #x207a)
 ("\\^-"      #x207b)
 ("\\^="      #x207c)
 ("\\^("      #x207d)
 ("\\^)"      #x207e)
 ("\\^n"      #x207f)
 ("\\||v"     #x21d3)
 ("\\||^"     #x21d1)
 ("\\||-"     #x22a9)
 ("\\~~-"     #x224a)
 ("\\]"       #x2136)
 ("\\<."      #x22d6)
 ("\\.>"      #x22d7)
 ("\\>."      #x22d7)
 ("\\;i"       #x1d6a4)
 ("\\;j"       #x1d6a5)
 ("\\;A"       #x2200)
 ("\\;E"       #x2203)
 ("\\!"       #xac)
 ("\\;oo"      #x221e)
 ("\\+-"      #xb1)
 ("\\-+"      #x2213)
 ("\\;x"       #xd7)
 ("\\/"       #xf7)
 ("\\#"       #x2605)
 ("\\*"       #x2217)
 ("\\;o"       #x2218)
 ("\\;u+"      #x228e)
 ("\\|~|"     #x2293)
 ("\\|_|"     #x2294)
 ("\\;v"       #x2228)
 ("\\^"       #x2227)
 ("\\;\\"     #x29f5)
 ("\\\\"      #x5c)
 ("\\)("      #x2240)
 ("\\/\\-"    #x25b3)
 ("\\-\\/"    #x25bd)
 ("\\|>-"     #x22b5)
 ("\\<|-"     #x22b4)
 ("\\;o+"      #x2295)
 ("\\;O+"      #x2a01)
 ("\\;o-"      #x2296)
 ("\\;ox"      #x2297)
 ("\\;Ox"      #x2a02)
 ("\\;o/"      #x2298)
 ("\\;t"       #x2020)
 ("\\;tt"      #x2021)
 ("\\;II"      #x2a3f)
 ("\\<"       #x2264)
 ("\\=<"      #x2266)
 ("\\>"       #x2265)
 ("\\=>"      #x2267)
 ("\\=:"      #x2252)
 ("\\:="      #x2254)
 ("\\=="      #x2261)
 ("\\=-"      #x2261)
 ("\\-="      #x2261)
 ("\\---"     #x2261)
 ("\\("       #x2282)
 ("\\(-"      #x2286)
 ("\\)"       #x2283)
 ("\\)-"      #x2287)
 ("\\["       #x228f)
 ("\\]"       #x2290)
 ("\\[-"      #x2291)
 ("\\]-"      #x2292)
 ("\\}"       #x220b)
 ("\\}/"      #x220c)
 ("\\-|"      #x22a3)
 ("\\|-"      #x22a2)
 ("\\|="      #x22a7)
 ("\\~"       #x223c)
 ("\\~-"      #x2243)
 ("\\~~"      #x2248)
 ("\\~="      #x2245)
 ("\\=/"      #x2260)
 ("\\.="      #x2250)
 ("\\;o<"     #x221d)
 ("\\_|_"     #x27c2)
 ("\\|"       #x2223)
 ("\\||"      #x2225)
 ("|><|"      #x22c8)
 ("\\\\_/"    #x2323)
 ("\\/~\\"    #x2322)
 ("\\<<"      #x226a)
 ("\\>>"      #x226b)
 ("\\<<<"     #x22d8)
 ("\\>>>"     #x22d9)
 ("\\<-"      #x2190)
 ("\\<--"     #x27f5)
 ("\\<="      #x21d0)
 ("\\<=="     #x27f8)
 ("\\iff"     #x27fa)
 ("\\<=>"     #x21d4)
 ("\\<==>"    #x27fa)
 ("\\<->"     #x2194)
 ("\\<-->"    #x27f7)
 ("\\|->"     #x21a6)
 ("\\<-)"     #x21a9)
 ("\\(->"     #x21aa)
 ("\\/-"      #x21bc)
 ("\\\\-"     #x21bd)
 ("\\-/"      #x21c1)
 ("\\-\\"     #x21c0)
 ("\\~>"      #x21dd)
 ("\\/_"      #x2220)
 ("\\h-"      #x210f)
 ("\\l"       #x2113)
 ("\\'"       #x2032)
 ("\\0"       #x2205)
 ("\\;b"      #x266d)
 ("\\;LT"     #x266e)
 ("\\6"       #x2202)
 ("\\[]"      #x25a1)
 ("\\.'."     #x2234)
 ("\\'.'"     #x2235)
 ("\\_0"      #x2080)
 ("\\_1"      #x2081)
 ("\\_2"      #x2082)
 ("\\_3"      #x2083)
 ("\\_4"      #x2084)
 ("\\_5"      #x2085)
 ("\\_6"      #x2086)
 ("\\_7"      #x2087)
 ("\\_8"      #x2088)
 ("\\_9"      #x2089)
 ("\\_i"      #x1d62)
 ("\\_r"      #x1d63)
 ("\\_u"      #x1d64)
 ("\\_v"      #x1d65)
 ("\\_:b"     #x1d66)
 ("\\_:g"     #x1d67)
 ("\\_:r"     #x1d68)
 ("\\_:ph"    #x1d69)
 ("\\_:ch"    #x1d6a)
 ("\\_+"      #x208a)
 ("\\_-"      #x208b)
 ("\\_="      #x208c)
 ("\\_("      #x208d)
 ("\\_)"      #x208e)
 ("\\_a"      #x2090)
 ("\\_e"      #x2091)
 ("\\_o"      #x2092)
 ("\\_x"      #x2093)
 ("\\_j"      #x2c7c)
 ("\\_h"      #x2095)
 ("\\_k"      #x2096)
 ("\\_l"      #x2097)
 ("\\_m"      #x2098)
 ("\\_n"      #x2099)
 ("\\_p"      #x209a)
 ("\\_s"      #x209b)
 ("\\_t"      #x209c)
)

(require 'cl)
(mapc (lambda (x)
        (if (cddr x)
            (quail-defrule (cadr x) (car (cddr x)))))
      (append math-symbol-list-basic math-symbol-list-extended))

(provide 'init_math)
