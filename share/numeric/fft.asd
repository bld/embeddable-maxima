

(defpackage #:fft.system
  (:use #:cl #:asdf))

(in-package #:fft.system)

(defsystem fft
  :components
  ((:file "fft-core")))

