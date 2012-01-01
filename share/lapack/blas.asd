;;; -*- Mode: lisp -*-

(defpackage blas-system
  (:use #:cl #:asdf))

(in-package #:blas-system)

(defclass blas-fortran-file (cl-source-file)
  ()
  (:default-initargs :type "f"))

;; 
(defun fortran-compile (op c &key
			       (array-slicing t)
			       (array-type :array)
			       (relaxed-array-decls t)
			       (package "BLAS"))
  (let ((file (component-pathname c)))
    (f2cl:f2cl-compile file
		       :output-file (first (output-files op c))
		       :array-slicing array-slicing
		       :array-type array-type
		       :package package
		       :relaxed-array-decls relaxed-array-decls
		       )))

(defmethod perform ((op compile-op) (c blas-fortran-file))
  (fortran-compile op c))

(defmethod perform ((op load-op) (c blas-fortran-file))
  (load (first (input-files op c))))

(defsystem blas
  :description "BLAS (Basic Linear Algebra Subprograms) for double-float matrices."
  :pathname "blas/"
  :depends-on ("blas-package" "blas-real" "blas-complex"))

