;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(defun zladiv (x y)
  (declare (type (f2cl-lib:complex16) y x))
  (prog ((zi 0.0) (zr 0.0) (zladiv #C(0.0 0.0)) (dble$ 0.0f0) (dimag$ 0.0f0))
    (declare (type (single-float) dimag$ dble$)
             (type (f2cl-lib:complex16) zladiv)
             (type (double-float) zr zi))
    (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5)
        (dladiv (f2cl-lib:dble x) (f2cl-lib:dimag x) (f2cl-lib:dble y)
         (f2cl-lib:dimag y) zr zi)
      (declare (ignore var-0 var-1 var-2 var-3))
      (setf zr var-4)
      (setf zi var-5))
    (setf zladiv (f2cl-lib:dcmplx zr zi))
    (go end_label)
   end_label
    (return (values zladiv nil nil))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zladiv
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::complex16)
                                              (fortran-to-lisp::complex16))
                                            :return-values '(nil nil) :calls
                                            '(fortran-to-lisp::dladiv))))

