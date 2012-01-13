(in-package #-gcl #:maxima #+GCL "MAXIMA")

;;(pushnew (merge-pathnames "colnew/" *maxima-sharedir*) asdf:*central-registry*)
(pushnew (concatenate 'string  *maxima-sharedir* "/colnew/") asdf:*central-registry*)

(let ((*READ-DEFAULT-FLOAT-FORMAT* 'double-float)) ;; maxima use double-float
  (asdf:load-system :colnew-interface))
