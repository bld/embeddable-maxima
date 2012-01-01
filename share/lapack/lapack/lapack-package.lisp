(defpackage #:lapack
  (:use :f2cl-lib :blas :common-lisp)
  (:export
   ;; Functions that maxima wants to use from LAPACK.
   #:dgeev
   #:dgesvd
   #:dlange
   #:zlange
   #:zgeev
   )
  (:documentation "Package for LAPACK routines"))
