;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(defun dlaisnan (din1 din2)
  (declare (type (double-float) din2 din1))
  (prog ((dlaisnan nil))
    (declare (type f2cl-lib:logical dlaisnan))
    (setf dlaisnan (coerce (/= din1 din2) 'f2cl-lib:logical))
    (go end_label)
   end_label
    (return (values dlaisnan nil nil))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dlaisnan
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((double-float) (double-float))
                                            :return-values '(nil nil) :calls
                                            'nil)))

