;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "QUADPACK")


(defun xerabt (messg nmessg)
  (declare (type (f2cl-lib:integer4) nmessg)
           (type (simple-array character (*)) messg))
  (f2cl-lib:with-multi-array-data
      ((messg character messg-%data% messg-%offset%))
    (prog () (declare) (f2cl-lib::stop) end_label (return (values nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::xerabt
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((simple-array character (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values '(nil nil) :calls
                                            'nil)))

