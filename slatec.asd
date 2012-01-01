;;; -*- Mode: lisp -*-

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:load-system :f2cl))


(defpackage slatec.system
  (:use #:cl #:asdf))

(in-package #:slatec.system)

(defclass slatec-fortran-file (cl-source-file)
  ()
  (:default-initargs :type "f"))

(defun fortran-compile (op c &key
			       (array-slicing t)
			       (array-type :array)
			       (package "SLATEC")
			       declare-common
			       (common-as-array t))
  (let ((file (component-pathname c)))
    (f2cl:f2cl-compile file
		       :output-file (first (output-files op c))
		       :array-slicing array-slicing
		       :array-type array-type
		       :package package
		       :declare-common declare-common
		       :common-as-array common-as-array
                       :float-format 'double-float
		       )))

(defmethod perform ((op compile-op) (c slatec-fortran-file))
  (fortran-compile op c :array-slicing nil :package "SLATEC"))

(defmethod perform ((op load-op) (c slatec-fortran-file))
  (load (first (input-files op c))))

(defsystem "slatec-package"
  :description "Package definition for SLATEC"
  :pathname "src/numerical/slatec/"
  :components
  ((:file "package")))

(defsystem slatec
  :description "SLATEC Common Mathematical Library"
  :pathname "src/numerical/slatec/"
  :depends-on ("slatec-package" "quadpack")
  :components
  ((:module xermsg
    :default-component-class slatec-fortran-file
    :pathname "fortran"
    :components
    (
     (:file "fdump")
     (:file "j4save")
     (:file "xgetua")
     (:file "xermsg"
      :depends-on ("fdump" "j4save" "xercnt" "xerhlt" "xerprn" "xersve"))
     (:file "xercnt")
     (:file "xerhlt")
     (:file "xerprn"
      :depends-on ("xgetua"))
     (:file "xersve"
      :depends-on ("j4save"))))
   (:module fortran
    :default-component-class slatec-fortran-file
    :pathname "fortran"
    :depends-on ("xermsg")
    :components
    (
     (:file "initds")
     (:file "dcsevl")
     
     ;; Gamma function
     (:file "d9lgmc"
      :depends-on ("dcsevl" "initds"))
     (:file "dgamlm")
     (:file "dgamma"
      :depends-on ("d9lgmc" "dcsevl" "dgamlm" "initds"))
     (:file "dgamln")
     (:file "dlngam"
      :depends-on ("d9lgmc" "dgamma"))
     
     ;; Bessel J functions for real arg and order
     (:file "d9b0mp"
      :depends-on ("dcsevl" "initds"))
     (:file "d9b1mp"
      :depends-on ("dcsevl" "initds"))
     (:file "dbesj0"
      :depends-on ("d9b0mp" "dcsevl" "initds"))
     (:file "dbesj1"
      :depends-on ("d9b1mp" "dcsevl" "initds"))
     (:file "djairy")
     (:file "dasyjy"
;;      :compiler-options (:array-slicing nil
;;                         :array-type :array
;;                         :float-format double-float
;;                         :package :slatec)
            )
     (:file "dbesj"
      :depends-on ("dasyjy" "djairy" "dlngam")
;;      :compiler-options (:array-slicing t
;;                         :array-type :simple-array
;;                         :float-format double-float
;;                         :package :slatec)
            )
     (:file "dbsynu"
      :depends-on ("dgamma"))

     (:file "dyairy")

     
     ;; Bessel J function for complex arg and real order.
     (:file "zabs")
     (:file "zacai"
      :depends-on ("zabs" "zasyi" "zbknu" "zmlri" "zs1s2" "zseri"))
     (:file "zairy"
      :depends-on ("zabs" "zacai" "zbknu" "zexp" "zsqrt"))
     (:file "zasyi"
      :depends-on ("zabs" "zdiv" "zexp" "zmlt" "zsqrt"))
     (:file "zbesj"
      :depends-on ("zabs" "zbinu"))
     (:file "zbinu"
      :depends-on ("zabs" "zasyi" "zbuni" "zmlri" "zseri" "zuoik" "zwrsk"))
     (:file "zbknu"
      :depends-on ("dgamln" "zabs" "zdiv" "zexp" "zkscl"
                            "zlog" "zmlt" "zshch" "zsqrt" "zuchk"))
     (:file "zbuni"
      :depends-on ("zabs" "zuni1" "zuni2"))
     (:file "zdiv")
     (:file "zexp")
     (:file "zkscl"
      :depends-on ("zabs" "zlog" "zuchk"))
     (:file "zlog"
      :depends-on ("zabs"))
     (:file "zmlri"
      :depends-on ("dgamln" "zabs" "zexp" "zlog" "zmlt"))
     (:file "zmlt")
     (:file "zrati"
      :depends-on ("zabs" "zdiv"))
     (:file "zs1s2"
      :depends-on ("zabs" "zexp" "zlog"))
     (:file "zseri"
      :depends-on ("dgamln" "zabs" "zdiv" "zlog" "zmlt" "zuchk"))
     (:file "zshch")
     (:file "zsqrt" :depends-on ("zabs"))
     (:file "zuchk")
     (:file "zunhj"
      :depends-on ("zabs" "zdiv" "zlog" "zsqrt"))
     (:file "zuni1"
      :depends-on ("zabs" "zuchk" "zunik" "zuoik"))
     (:file "zuni2"
      :depends-on ("zabs" "zairy" "zuchk" "zunhj" "zuoik"))
     (:file "zunik"
      :depends-on ("zdiv" "zlog" "zsqrt"))
     (:file "zuoik"
      :depends-on ("zabs" "zlog" "zuchk" "zunhj" "zunik"))
     (:file "zwrsk"
      :depends-on ("zabs" "zbknu" "zrati"))

     ;; Bessel Y functions for real or complex arg and real order
     (:file "dbesy0"
      :depends-on ("d9b0mp" "dbesj0" "dcsevl" "initds"))
     (:file "dbesy1"
      :depends-on ("d9b1mp" "dbesj1" "dcsevl" "initds"))
     (:file "dbesy"
      :depends-on ("dasyjy" "dbesy0" "dbesy1" "dbsynu" "dyairy"))
;;     (:file "dbsynu"
;;      :depends-on ("dgamma"))
;;     (:file "dyairy")
     
     (:file "zbesy"
      :depends-on ("zbesh"))
     (:file "zbesh"
      :depends-on ("zabs" "zacon" "zbknu" "zbunk" "zuoik"))
     (:file "zacon"
      :depends-on ("zabs" "zbinu" "zbknu" "zmlt" "zs1s2"))
     (:file "zbunk"
      :depends-on ("zunk1" "zunk2"))
     (:file "zunk1"
;;      :compiler-options (:array-slicing t
;;                         :float-format double-float
;;                         :package :slatec)
      :depends-on ("zabs" "zs1s2" "zuchk" "zunik"))
     (:file "zunk2"
      :depends-on ("zabs" "zairy" "zs1s2" "zuchk" "zunhj"))

     ;; Bessel I functions for real or complex arg and real order
     (:file "dbsi0e"
      :depends-on ("dcsevl" "initds"))
     (:file "dbsi1e"
      :depends-on ("dcsevl" "initds"))
     (:file "dbesi0"
      :depends-on ("dbsi0e" "dcsevl" "initds"))
     (:file "dbesi1"
      :depends-on ("dbsi1e" "dcsevl" "initds"))
     (:file "dasyik"
;;      :compiler-options (:array-slicing nil
;;                         :array-type :array
;;                         :float-format double-float
;;                         :package :slatec)
            )
     (:file "dbesi"
      :depends-on ("dasyik" "dlngam")
;;      :compiler-options (:array-slicing t
;;                         :array-type :array
;;                         :float-format double-float
;;                         :package :slatec)
            )
     (:file "zbesi"
      :depends-on ("zabs" "zbinu"))

     ;; Bessel K functions
     (:file "dbesk0"
      :depends-on ("dbesi0" "dbsk0e" "dcsevl" "initds"))
     (:file "dbsk0e"
      :depends-on ("dbesi0" "dcsevl" "initds"))
     (:file "dbesk1"
      :depends-on ("dbesi1" "dbsk1e" "dcsevl" "initds"))
     (:file "dbsk1e"
      :depends-on ("dbesi1" "dcsevl" "initds"))
     (:file "dbesk"
      :depends-on ("dasyik" "dbesk0" "dbesk1" "dbsk0e" "dbsk1e" "dbsknu"))
     (:file "dbsknu"
      :depends-on ("dgamma"))
     (:file "zbesk"
      :depends-on ("zabs" "zacon" "zbknu" "zbunk" "zuoik"))
     
     ;; Airy functions
     (:file "d9aimp"
      :depends-on ("dcsevl" "initds"))
     (:file "daie"
      :depends-on ("d9aimp" "dcsevl" "initds"))
     (:file "dai"
      :depends-on ("d9aimp" "daie" "dcsevl" "initds"))
     (:file "dbie"
      :depends-on ("d9aimp" "dcsevl" "initds"))
     (:file "dbi"
      :depends-on ("d9aimp" "dbie" "dcsevl" "initds"))
     (:file "zbiry"
      :depends-on ("zabs" "zbinu" "zdiv" "zsqrt"))

     ;; Error functions
     (:file "derf"
      :depends-on ("dcsevl" "derfc" "initds"))
     (:file "derfc"
      :depends-on ("dcsevl" "initds"))
     
     ;; Exponential integrals
     (:file "de1"
      :depends-on ("dcsevl" "initds"))
     (:file "dei"
      :depends-on ("de1"))
     ;; Spence's function, related to dilogarithm
     (:file "dspenc"
      :depends-on ("d9upak"))
     (:file "d9upak")
     ))))