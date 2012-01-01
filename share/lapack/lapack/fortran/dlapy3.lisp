;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(let* ((zero 0.0))
  (declare (type (double-float 0.0 0.0) zero)
           (ignorable zero))
  (defun dlapy3 (x y z)
    (declare (type (double-float) z y x))
    (prog ((w 0.0) (xabs 0.0) (yabs 0.0) (zabs 0.0) (dlapy3 0.0))
      (declare (type (double-float) w xabs yabs zabs dlapy3))
      (setf xabs (abs x))
      (setf yabs (abs y))
      (setf zabs (abs z))
      (setf w (max xabs yabs zabs))
      (cond ((= w zero) (setf dlapy3 (+ xabs yabs zabs)))
            (t
             (setf dlapy3
                     (* w
                        (f2cl-lib:fsqrt
                         (+ (expt (/ xabs w) 2) (expt (/ yabs w) 2)
                            (expt (/ zabs w) 2)))))))
      (go end_label)
     end_label
      (return (values dlapy3 nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dlapy3
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((double-float) (double-float)
                                              (double-float))
                                            :return-values '(nil nil nil)
                                            :calls 'nil)))

