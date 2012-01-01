;;; -*- Mode: lisp -*-
;;;
;;; This is a simple defsystem for converting QUADPACK Fortran
;;; routines to Lisp and compiling the result.
;;;
;;; $Id$

;; Need f2cl to be loaded before we can even read this file.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:load-system :f2cl))

;; Package to use for this file.
(defpackage #:quadpack.system
  (:use #:cl #:asdf))

(in-package #:quadpack.system)

;; Defsystem for d1mach and i1mach
(defsystem mach-par
  :pathname "src/numerical/quadpack/"
  :components
  ((:file "d1mach")
   (:file "i1mach")))

(defclass quadpack-fortran-file (cl-source-file)
  ()
  (:default-initargs :type "f"))

(defun fortran-compile (op c &key (array-slicing t) (array-type :array) (package "QUADPACK"))
  (let ((file (component-pathname c)))
    (f2cl:f2cl-compile file
		       :keep-lisp-file t
		       :output-file (first (output-files op c))
		       :array-slicing array-slicing
		       :array-type array-type
		       :package package
                       :float-format 'double-float)))

(defmethod perform ((op compile-op) (c quadpack-fortran-file))
  (fortran-compile op c :package "QUADPACK"))

(defmethod perform ((op load-op) (c quadpack-fortran-file))
  (load (first (input-files op c))))

(defsystem "quadpack-package"
  :description "Package definition for QUADPACK"
  :pathname "src/numerical/quadpack/"
  :components
  ((:file "package")))

;; Defsystem for quadpack.  This converts the Fortran code to Lisp and
;; then compiles the result.
(defsystem quadpack
  :description "F2CL conversion of QUADPACK: Adaptive numerical integration"
  :depends-on ("mach-par" "quadpack-package")
  :pathname "src/numerical/quadpack/"
  :components
  ((:module fortran
    :default-component-class quadpack-fortran-file
    :components
    (
     ;; Support
     (:file "dqwgtf")
     (:file "dqcheb")
     (:file "dqk15w")
     (:file "dqwgts")
     (:file "dqwgtc")
     (:file "dgtsl")
     (:file "xerror"
      :depends-on ("xerrwv" "j4save" "xerprt" "xersav"
                            "xerctl" "xgetua" "xersav"))

     ;; Support routines for xerror
     (:file "xerrwv"
      :depends-on ("xerabt"))
     (:file "xersav")
     (:file "xgetua"
      :depends-on ("j4save"))
     (:file "fdump")
     (:file "j4save")
     (:file "xerabt")
     (:file "xerprt")
     (:file "xerctl")
     
     ;; Core integration routines
     (:file "dqk15")
     (:file "dqk31")
     (:file "dqk41")
     (:file "dqk51")
     (:file "dqk61")
     (:file "dqk21")
     (:file "dqk15i")
     (:file "dqelg")
     (:file "dqpsrt")
     (:file "dqc25s"
      :depends-on ("dqcheb" "dqk15w"))
     (:file "dqmomo")
     (:file "dqc25c"
      :depends-on ("dqcheb"
                   "dqk15w"))
     (:file "dqc25f"
      :depends-on ("dgtsl"
                   "dqcheb"
                   "dqk15w"
                   "dqwgtf"))
     ;; Basic integrators
     (:file "dqage"
      :depends-on ("dqk15"
                   "dqk31"
                   "dqk41"
                   "dqk51"
                   "dqk61"
                   "dqk21"
                   "dqpsrt"))
     (:file "dqagie"
      :depends-on ("dqelg"
                   "dqk15i"
                   "dqpsrt"))
     (:file "dqagp"
      :depends-on ("dqagpe"))
     (:file "dqagpe"
      :depends-on ("dqelg"
                   "dqpsrt"
                   "dqk21"
                   ))
     (:file "dqagse"
      :depends-on ("dqk21"
                   "dqelg"
                   "dqpsrt"))
     (:file "dqawfe"
      :depends-on ("dqagie"
                   "dqawoe"
                   "dqelg")
      :perform (compile-op :around (op c)
                           (fortran-compile op c :array-slicing nil :array-type :array)))
     (:file "dqawoe"
      :depends-on ("dqc25f"
                   "dqpsrt"
                   "dqelg"))
     (:file "dqawse"
      :depends-on ("dqc25s"
                   "dqmomo"
                   "dqpsrt"))
     (:file "dqawce"
      :depends-on ("dqc25c"
                   "dqpsrt"))
     ;; Simplified interface routines
     (:file "dqng"
      :depends-on ("xerror"))
     (:file "dqag"
      :depends-on ("dqage"
                   "xerror"))
     (:file "dqags"
      :depends-on ("dqagse"
                   "xerror"))
     (:file "dqagi"
      :depends-on ("dqagie"
                   "xerror"))
     (:file "dqawf"
      :depends-on ("dqawfe"
                   "xerror"))
     (:file "dqawo"
      :depends-on ("dqawoe"
                   "xerror"))
     (:file "dqaws"
      :depends-on ("dqawse"
                   "xerror"))
     (:file "dqawc"
      :depends-on ("dqawce"
                   "xerror"))))))


(defmethod perform ((op test-op) (c (eql (find-system :quadpack))))
  (oos 'test-op "quadpack-tests"))

(defpackage quadpack-tests
  (:use #:cl))

(defsystem quadpack-tests
  :depends-on ("quadpack" "rt")
  :in-order-to ((compile-op (load-op :quadpack :rt))
                (test-op (load-op :quadpack :rt)))
  :pathname "src/numerical/"
  :components
  ((:module quadpack
    :components
    ((:file "test-1")
     (:file "test-2")
     ;;(:file "test-3")
     (:file "test-4-qng")
     (:file "test-4-qags")))))

(defmethod perform ((op test-op) (c (eql (find-system "quadpack-tests"))))
  (or (funcall (intern "DO-TESTS" (find-package '#:rt)))
      (error "TEST-OP filed for quadpack-tests")))
