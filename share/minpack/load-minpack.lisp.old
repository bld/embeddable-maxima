(in-package #-gcl #:maxima #+GCL "MAXIMA")

;;(pushnew (merge-pathnames "minpack/" *maxima-sharedir*) asdf:*central-registry*)
(pushnew (concatenate 'string *maxima-sharedir* "/minpack/") asdf:*central-registry*)

(asdf:load-system :minpack-interface)
