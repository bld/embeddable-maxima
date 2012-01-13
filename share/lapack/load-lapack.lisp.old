(in-package #-gcl #:maxima #+GCL "MAXIMA")

;;(pushnew (merge-pathnames "lapack/" *maxima-sharedir*) asdf:*central-registry*)

(pushnew (concatenate 'string  *maxima-sharedir* "/lapack/") asdf:*central-registry*)

(let ((*READ-DEFAULT-FLOAT-FORMAT* 'double-float)) ;; maxima use double-float
  (asdf:load-system :lapack-interface))
