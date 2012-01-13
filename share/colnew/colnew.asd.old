;;; -*- Mode: lisp; Package: CL-USER -*-

;; Need f2cl to be loaded before we can even read this file.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:load-system :f2cl))

(defpackage :colnew.system
  (:use #:cl #:asdf))

(in-package #:colnew.system)


(defclass colnew-fortran-file (cl-source-file)
  ()
  (:default-initargs :type "f"))

(defun fortran-compile (op c &key (array-slicing t) (array-type :array) (package "COLNEW")
                               declare-common (common-as-array t))
  (let ((file (component-pathname c)))
    (f2cl:f2cl-compile file
		       :keep-lisp-file t
		       :output-file (first (output-files op c))
		       :array-slicing array-slicing
		       :array-type array-type
		       :package package
		       :declare-common declare-common
		       :common-as-array common-as-array
		       )))

(defmethod perform ((op compile-op) (c colnew-fortran-file))
  (fortran-compile op c :package "COLNEW"))

(defmethod perform ((op load-op) (c colnew-fortran-file))
  (load (first (input-files op c))))

;; Defsystem for colnew.
(defsystem colnew
  :description "F2CL conversion of COLNEW: Solution of boundary-value problems for ODEs"
  :components
  ((:module package
    :pathname ""
    :components
    ((:file "colnew-package")))
   (:module fortran
    :depends-on ("package")
    :default-component-class colnew-fortran-file
    :components
    (
     ;; Linpack routines needed by colnew
     (:file "dgesl"
      :depends-on ("daxpy" "ddot"))
     (:file "dgefa"
      :depends-on ("idamax" "dscal" "daxpy"))
     ;; BLAS routines needed by above
     (:file "daxpy")
     (:file "ddot")
     (:file "dscal")
     (:file "idamax")
     ;; Simple compatibility to define all of the needed
     ;; common blocks in one place.
     (:file "compat"
      :perform (compile-op :around (op c)
                           (fortran-compile op c
                                            :declare-common t :common-as-array t)))
     ;; COLNEW itself, broken down into one subroutine per
     ;; file.
     (:file "colnew"
      :depends-on ("compat" "consts" "newmsh" "contrl"))
     (:file "contrl"
      :depends-on ("compat" "lsyslv" "skale" "errchk" "newmsh"))
     (:file "skale"
      :depends-on ("compat"))
     (:file "newmsh"
      :depends-on ("compat" "approx" "horder"))
     (:file "consts"
      :depends-on ("compat" "vmonde" "rkbas"))
     (:file "errchk")
     (:file "lsyslv"
      :depends-on ("compat" "vwblok" "gblock" "gderiv" "fcblok"
                            "sbblok" "dmzsol"))
     (:file "gderiv")
     (:file "vwblok"
      :depends-on ("compat" "dgesl" "dgefa"))
     (:file "gblock"
      :depends-on ("compat" "dgesl"))
     (:file "appsln")
     (:file "approx"
      :depends-on ("compat" "rkbas"))
     (:file "rkbas"
      :depends-on ("compat"))
     (:file "vmonde"
      :depends-on ("compat"))
     (:file "horder")
     (:file "dmzsol"
      :depends-on ("factrb" "shiftb"))
     (:file "fcblok"
      :depends-on ("factrb" "shiftb"))
     (:file "factrb")
     (:file "shiftb")
     (:file "sbblok"
      :depends-on ("subfor" "subbak"))
     (:file "subfor")
     (:file "subbak")))))

(defsystem colnew-ex1
  :depends-on ("colnew")
  :components
  ((:module ex1
    :default-component-class colnew-fortran-file
    :components
    ((:file "prob1"
      :depends-on ("fsub" "dfsub" "gsub" "dgsub" "exact"))
     (:file "fsub")
     (:file "gsub")
     (:file "dfsub")
     (:file "dgsub")
     (:file "exact")))))

(defsystem colnew-ex2
  :depends-on ("colnew")
  :components
  ((:module ex2
    :default-component-class colnew-fortran-file
    :components
    ((:file "prob2"
      :depends-on ("fsub" "dfsub" "gsub" "dgsub" "solutn"))
     (:file "fsub")
     (:file "gsub")
     (:file "dfsub")
     (:file "dgsub")
     (:file "solutn")))))


;; Test problem 3.  This works.  Use (colnew::*main*) to run the test.
(defsystem colnew-ex3
  :depends-on ("colnew")
  :components
  ((:module ex3
    :default-component-class colnew-fortran-file
    :components
    ((:file "prob3"
      :depends-on ("fsub" "dfsub" "gsub" "dgsub" "solutn"))
     (:file "fsub")
     (:file "gsub")
     (:file "dfsub")
     (:file "dgsub")
     (:file "solutn")))))

