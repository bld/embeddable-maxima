;; Package for the quadpack routines.
(defpackage quadpack
  (:use #:cl)
  (:export
   ;; Support
   #:dqwgtf
   #:dqcheb
   #:dqk15w
   #:dqwgts
   #:dqwgtc
   #:dgtsl
   #:xerror
   
   ;; Core integration routines
   #:dqk15
   #:dqk31
   #:dqk41
   #:dqk51
   #:dqk61
   #:dqk21
   #:dqk15i
   #:dqelg
   #:dqpsrt
   #:dqc25s
   #:dqmomo
   #:dqc25c
   #:dqc25f
   ;; Basic integrators
   #:dqage
   #:dqagie
   #:dqagpe
   #:dqagse
   #:dqawfe
   #:dqawoe
   #:dqawse
   #:dqawce
   ;; Simplified interface routines
   #:dqng
   #:dqag
   #:dqags
   #:dqagi
   #:dqagp
   #:dqawf
   #:dqawo
   #:dqaws
   #:dqawc
   #:j4save))