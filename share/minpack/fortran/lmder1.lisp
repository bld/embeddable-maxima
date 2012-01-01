;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((factor 100.0) (zero 0.0))
  (declare (type (double-float) factor zero))
  (defun lmder1 (fcn m n x fvec fjac ldfjac tol info ipvt wa lwa)
    (declare (type (array f2cl-lib:integer4 (*)) ipvt)
             (type (double-float) tol)
             (type (array double-float (*)) wa fjac fvec x)
             (type (f2cl-lib:integer4) lwa info ldfjac n m))
    (f2cl-lib:with-multi-array-data
        ((x double-float x-%data% x-%offset%)
         (fvec double-float fvec-%data% fvec-%offset%)
         (fjac double-float fjac-%data% fjac-%offset%)
         (wa double-float wa-%data% wa-%offset%)
         (ipvt f2cl-lib:integer4 ipvt-%data% ipvt-%offset%))
      (prog ((ftol 0.0) (gtol 0.0) (xtol 0.0) (maxfev 0) (mode 0) (nfev 0)
             (njev 0) (nprint 0))
        (declare (type (f2cl-lib:integer4) nprint njev nfev mode maxfev)
                 (type (double-float) xtol gtol ftol))
        (setf info 0)
        (if (or (<= n 0) (< m n) (< ldfjac m) (< tol zero)
                (< lwa (f2cl-lib:int-add (f2cl-lib:int-mul 5 n) m)))
            (go label10))
        (setf maxfev (f2cl-lib:int-mul 100 (f2cl-lib:int-add n 1)))
        (setf ftol tol)
        (setf xtol tol)
        (setf gtol zero)
        (setf mode 1)
        (setf nprint 0)
        (multiple-value-bind
            (var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8 var-9 var-10
             var-11 var-12 var-13 var-14 var-15 var-16 var-17 var-18 var-19
             var-20 var-21 var-22 var-23)
            (lmder fcn m n x fvec fjac ldfjac ftol xtol gtol maxfev
             (f2cl-lib:array-slice wa-%data% double-float (1) ((1 lwa))
                                   wa-%offset%)
             mode factor nprint info nfev njev ipvt
             (f2cl-lib:array-slice wa-%data% double-float ((+ n 1)) ((1 lwa))
                                   wa-%offset%)
             (f2cl-lib:array-slice wa-%data% double-float
                                   ((+ (f2cl-lib:int-mul 2 n) 1)) ((1 lwa))
                                   wa-%offset%)
             (f2cl-lib:array-slice wa-%data% double-float
                                   ((+ (f2cl-lib:int-mul 3 n) 1)) ((1 lwa))
                                   wa-%offset%)
             (f2cl-lib:array-slice wa-%data% double-float
                                   ((+ (f2cl-lib:int-mul 4 n) 1)) ((1 lwa))
                                   wa-%offset%)
             (f2cl-lib:array-slice wa-%data% double-float
                                   ((+ (f2cl-lib:int-mul 5 n) 1)) ((1 lwa))
                                   wa-%offset%))
          (declare
           (ignore var-0 var-3 var-4 var-5 var-7 var-8 var-9 var-10 var-11
            var-12 var-13 var-14 var-18 var-19 var-20 var-21 var-22 var-23))
          (setf m var-1)
          (setf n var-2)
          (setf ldfjac var-6)
          (setf info var-15)
          (setf nfev var-16)
          (setf njev var-17))
        (if (= info 8)
            (setf info 4))
       label10
        (go end_label)
       end_label
        (return (values nil m n nil nil nil ldfjac nil info nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::lmder1
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (double-float)
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil fortran-to-lisp::m
                                              fortran-to-lisp::n nil nil nil
                                              fortran-to-lisp::ldfjac nil
                                              fortran-to-lisp::info nil nil
                                              nil)
                                            :calls '(fortran-to-lisp::lmder))))

