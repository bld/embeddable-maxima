;; -*- Lisp -*-

;; Copyright 2007 by Luigi Panzeri.
;; This file is released under the terms of
;; the GNU General Public License, version 2.

(in-package :asdf)

;; Don't try to optimize so much in ECL.
;; Therefore functions can be redefined (essential for share libraries).
#+ecl (declaim (optimize (debug 2)))

(in-package :cl-user)

(defvar *maxima-build-time* (multiple-value-list (get-decoded-time)))
(export '*maxima-build-time*)

(defpackage :maxima.system
  (:use :common-lisp :asdf))

(in-package :maxima.system)

(defsystem #:maxima
  :description "Maxima is a symbolic computation program." 
  :licence "GPL" 
  :version "5.26.0"
  :serial t
  :depends-on (#:cl-fad #:f2cl #:slatec #:quadpack #:getopt #:trivial-features)
  :components ((:module src
                :serial t
                :components 
                (
                 #+gcl-working-proclaims
                 (:file "sys-proclaim")
                 (:module package
                  :components (#-gcl(:file "maxima-package")
                               #+ecl(:file "ecl-port")))
                (:module info
                 :components ((:file "nregex")
                                     ;; Some versions of CMUCL already
				     ;; have a compatible version of
				     ;; INTL, so skip it if we have
				     ;; it.
                              #+#.(cl:if (cl:and (cl:member :cmu cl:*features*) (cl:find-package '#:intl))  '(or) '(and))
                              (:file "intl")
                              (:file "cl-info" :depends-on ("intl"))))
                (:module declarations
                 :components ((:file "lmdcls"))) 
                (:module destructuring-let
                 :components ((:file "letmac")))
                (:module compatibility-macros1
                 :components ((:file "generr")
                              (:file "clmacs")))
                (:module compatibility-macros
                 :components ((:file "commac"))) 
                (:module prerequisites
                 :components ((:file "mormac") 
                              (:file "compat")))
                (:module command-line
                 :components ((:file "command-line")))
                (:module fundamental-macros
                 :components ((:file "defopt") 
                              (:file "defcal") 
                              (:file "maxmac")))
                (:module utility-macros
                 :components ((:file "mopers") 
                              (:file "mforma")))
                (:module other-macros
                 :components ((:file "mrgmac") 
                              (:file "rzmac")    
                              (:file "strmac") 
                              (:file "displm")))
                (:module rat-macros
                 :components ((:file "ratmac") 
                              (:file "mhayat")))
                ;;#+gcl (:file "optimize")		; jfa check this

                (:module utilities
                 :depends-on (utility-macros)
                 :components ((:file "opers")
                              (:file "utils") 
                              (:file "sumcon") 
                              (:file "sublis") 
                              (:file "merror") 
                              (:file "mformt") 
                              (:file "mutils") 
                              (:file "outmis") 
                              (:file "ar")))

                (:module commands
                 :components ((:file "comm")
                              (:file "comm2")))
                (:module evaluator
                 :components ((:file "mlisp") 
                              (:file "mmacro") 
                              (:file "buildq")))

                (:module numerical
                 :components
                         (
                          (:file "quadpack-interface")
                          )
                         )
                (:module simplification 
                 :components ((:file "simp") 
                              (:file "float") 
                              (:file "csimp") 
                              (:file "csimp2") 
                              (:file "zero")
                              (:file "logarc") 
                              (:file "rpart")))
                (:module numeric-bigfloat 
                 :components ((:file "numeric")))
                (:module server 
                 :components ((:file "server")))
                (:module i-o 
                 :depends-on (compatibility-macros)
                 :components ((:file "macsys") 
                              (:file "mload") 
                              (:file "suprv1")
                              (:file "dskfn")))
                (:module factoring 
                 :components ((:file "lesfac") 
                              (:file "factor") 
                              (:file "algfac") 
                              (:file "nalgfa") 
                              (:file "ufact") 
                              (:file "result")))
                (:module ifactor 
                 :components ((:file "ifactor")))

                (:module rational-functions 
                 :components ((:file "rat3a") 
                              (:file "rat3b") 
                              (:file "rat3d") 
                              (:file "numth") 
                              (:file "rat3c") 
                              (:file "rat3e") 
                              (:file "nrat4") 
                              (:file "ratout")))

                (:module maxima-language-compiler-macros 
                 :components ((:file "transm")))
                (:module maxima-language-compiler 
                 :components ((:file "transl") 
                              (:file "transs") 
                              (:file "trans1") 
                              (:file "trans2") 
                              (:file "trans3") 
                              (:file "trans4") 
                              (:file "trans5") 
                              (:file "transf") 
                              (:file "troper") 
                              (:file "trutil") 
                              (:file "trmode") 
                              (:file "trdata") 
                              (:file "trpred") 
                              (:file "transq") 
                              (:file "acall")
                              (:file "fcall") 
                              (:file "evalw") 
                              (:file "trprop") 
                              (:file "mdefun"))
                 :depends-on (maxima-language-compiler-macros))

                (:module trigonometry 
                 :components ((:file "trigi") 
                              (:file "trigo") 
                              (:file "trgred")))

                (:module numerical-functions 
                 :depends-on (trigonometry)
                 :components ((:file "bessel")
                              (:file "ellipt")
                              (:file "airy"
                               :depends-on ("ellipt"))
                              (:file "plasma")
                              (:file "intpol")))

                (:module reader 
                 :depends-on (compatibility-macros)
                 :components ((:file "nparse")))

                (:module display 
                 :components ((:file "displa") 
                              (:file "nforma") 
                              (:file "ldisp") 
                              (:file "grind")))

                (:module gcd 
                 :components ((:file "spgcd")
                              (:file "ezgcd")))
                (:module documentation 
                 :components ((:file "option")
                              (:file "macdes")))
                (:module algebraic-database 
                 :components ((:file "inmis") 
                              (:file "db") 
                              (:file "compar") 
                              (:file "askp"))) ;does this belong here?
                (:module integration 
                 :components ((:file "sinint") 
                              (:file "sin") 
                              (:file "risch")))
                (:module taylor-series 
                 :depends-on (rat-macros)
                 :components ((:file "hayat")))
                (:module definite-integration 
                 :components ((:file "defint") 
                              (:file "residu")))
                (:module special-functions 
                 :components ((:file "specfn")))
                (:module matrix-algebra 
                 :components ((:file "mat") 
                              (:file "linnew")
                              (:file "matrix")))
                (:module determinants 
                 :components ((:file "sprdet") 
                              (:file "newinv") 
                              (:file "newdet")))
                (:module pattern-matching 
                 :components ((:file "schatc") 
                              (:file "matcom") 
                              (:file "matrun") 
                              (:file "nisimp")))
                (:module limits 
                 :components ((:file "tlimit") 
                              (:file "limit")))
                (:module solve 
                 :components ((:file "solve") 
                              (:file "psolve") 
                              (:file "algsys") 
                              (:file "polyrz") 
                              (:file "cpoly")))
                (:module debugging 
                 :components ((:file "mtrace")
                              (:file "mdebug")))
                (:module miscellaneous 
                 :components ((:file "scs") 
                              (:file "asum") 
                              (:file "fortra") 
                              (:file "optim") 
                              (:file "marray") 
                              (:file "mdot") 
                              (:file "irinte") 
                              (:file "series") 
                              (:file "laplac") 
                              (:file "pade") 
                              (:file "homog") 
                              (:file "combin") 
                              (:file "nset")
                              (:file "rand-mt19937")
                              (:file "maxmin")
                              (:file "nummod")
                              (:file "conjugate")
                              (:file "expintegral")
                              (:file "gamma")
                              (:file "mstuff")))
                (:module poisson-series 
                 :components ((:file "ratpoi")
                              (:file "pois2") 
                              (:file "pois3")))
                (:module translated-packages 
                 :depends-on ("maxima-language-compiler-macros")
                 :components
                         ((:file "desoln")
                          (:file "elim")
                          (:file "invert")
                          (:file "hypgeo")
                          (:file "hyp")
                          (:file "todd-coxeter")
                          (:file "mactex")
                          (:file "plot")))
                (:module graphics-drivers 
                 :components ((:file "gnuplot_def")
                              (:file "xmaxima_def")))

                (:module final 
                 :components ((:file "autol")
                              (:file "max_ext")
                              (:file "init-cl")))))))