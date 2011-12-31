; -*- Lisp -*-
(in-package :maxima)

(defparameter *autoconf-variables-set* "@variables_set@")
(defparameter *autoconf-prefix* (namestring (asdf:component-pathname (asdf:find-system '#:maxima))))
(defparameter *autoconf-exec_prefix* "@expanded_exec_prefix@")
(defparameter *autoconf-package* "maxima")
(defparameter *autoconf-version* (asdf:component-version (asdf:find-system '#:maxima)))
(defparameter *autoconf-libdir* "@expanded_libdir@")
(defparameter *autoconf-libexecdir* "@expanded_libexecdir@")
(defparameter *autoconf-datadir* "@expanded_datadir@")
(defparameter *autoconf-infodir* "@expanded_infodir@")
(defparameter *autoconf-host* "@host@")
(defparameter *autoconf-win32* #+win32"true" #-win32"false")
(defparameter *autoconf-ld-flags* "@LDFLAGS@")
 
(defparameter *maxima-source-root* (namestring (asdf:component-pathname (asdf:find-system '#:maxima))))
(defparameter *maxima-default-layout-autotools* "false")


