;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((one 1.0) (zero 0.0) (rdwarf 3.834e-20) (rgiant 1.304e19))
  (declare (type (double-float) one zero rdwarf rgiant))
  (defun enorm (n x)
    (declare (type (array double-float (*)) x)
             (type (f2cl-lib:integer4) n))
    (f2cl-lib:with-multi-array-data
        ((x double-float x-%data% x-%offset%))
      (prog ((agiant 0.0) (floatn 0.0) (s1 0.0) (s2 0.0) (s3 0.0) (xabs 0.0)
             (x1max 0.0) (x3max 0.0) (i 0) (enorm 0.0))
        (declare (type (f2cl-lib:integer4) i)
                 (type (double-float) enorm x3max x1max xabs s3 s2 s1 floatn
                  agiant))
        (setf s1 zero)
        (setf s2 zero)
        (setf s3 zero)
        (setf x1max zero)
        (setf x3max zero)
        (setf floatn (coerce (the f2cl-lib:integer4 n) 'double-float))
        (setf agiant (/ rgiant floatn))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i n) nil)
          (tagbody
            (setf xabs
                    (f2cl-lib:dabs
                     (f2cl-lib:fref x-%data% (i) ((1 n)) x-%offset%)))
            (if (and (> xabs rdwarf) (< xabs agiant))
                (go label70))
            (if (<= xabs rdwarf)
                (go label30))
            (if (<= xabs x1max)
                (go label10))
            (setf s1 (+ one (* s1 (expt (/ x1max xabs) 2))))
            (setf x1max xabs)
            (go label20)
           label10
            (setf s1 (+ s1 (expt (/ xabs x1max) 2)))
           label20
            (go label60)
           label30
            (if (<= xabs x3max)
                (go label40))
            (setf s3 (+ one (* s3 (expt (/ x3max xabs) 2))))
            (setf x3max xabs)
            (go label50)
           label40
            (if (/= xabs zero)
                (setf s3 (+ s3 (expt (/ xabs x3max) 2))))
           label50
           label60
            (go label80)
           label70
            (setf s2 (+ s2 (expt xabs 2)))
           label80
           label90))
        (if (= s1 zero)
            (go label100))
        (setf enorm (* x1max (f2cl-lib:dsqrt (+ s1 (/ (/ s2 x1max) x1max)))))
        (go label130)
       label100
        (if (= s2 zero)
            (go label110))
        (if (>= s2 x3max)
            (setf enorm
                    (f2cl-lib:dsqrt
                     (* s2 (+ one (* (/ x3max s2) (* x3max s3)))))))
        (if (< s2 x3max)
            (setf enorm
                    (f2cl-lib:dsqrt (* x3max (+ (/ s2 x3max) (* x3max s3))))))
        (go label120)
       label110
        (setf enorm (* x3max (f2cl-lib:dsqrt s3)))
       label120
       label130
        (go end_label)
       end_label
        (return (values enorm nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::enorm fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array double-float (*)))
                                            :return-values '(nil nil) :calls
                                            'nil)))

