;;
;; Lapack maxima interface
;;

(defsystem lapack-interface
  :depends-on (#:lapack #:maxima)
  :components
  (
   (:file "eigensys")
   (:file "dgesv")
   (:file "dgeqrf")
   (:file "dgemm")))
