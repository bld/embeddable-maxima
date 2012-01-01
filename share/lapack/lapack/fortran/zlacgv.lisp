;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(defun zlacgv (n x incx)
  (declare (type (array f2cl-lib:complex16 (*)) x)
           (type (f2cl-lib:integer4) incx n))
  (f2cl-lib:with-multi-array-data
      ((x f2cl-lib:complex16 x-%data% x-%offset%))
    (prog ((i 0) (ioff 0))
      (declare (type (f2cl-lib:integer4) ioff i))
      (cond
       ((= incx 1)
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i n) nil)
          (tagbody
            (setf (f2cl-lib:fref x-%data% (i) ((1 *)) x-%offset%)
                    (coerce
                     (f2cl-lib:dconjg
                      (f2cl-lib:fref x-%data% (i) ((1 *)) x-%offset%))
                     'f2cl-lib:complex16))
           label10)))
       (t (setf ioff 1)
        (if (< incx 0)
            (setf ioff
                    (f2cl-lib:int-sub 1
                                      (f2cl-lib:int-mul (f2cl-lib:int-sub n 1)
                                                        incx))))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i n) nil)
          (tagbody
            (setf (f2cl-lib:fref x-%data% (ioff) ((1 *)) x-%offset%)
                    (coerce
                     (f2cl-lib:dconjg
                      (f2cl-lib:fref x-%data% (ioff) ((1 *)) x-%offset%))
                     'f2cl-lib:complex16))
            (setf ioff (f2cl-lib:int-add ioff incx))
           label20))))
      (go end_label)
     end_label
      (return (values nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zlacgv
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values '(nil nil nil)
                                            :calls 'nil)))

