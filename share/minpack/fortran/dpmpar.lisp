;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((dmach
       (make-array 3 :element-type 'double-float :initial-contents
                   '(2.22044604926e-16 2.22507385852e-308 1.79769313485e308))))
  (declare (type (array double-float (3)) dmach))
  (defun dpmpar (i)
    (declare (type (f2cl-lib:integer4) i))
    (prog ((maxmag (make-array 4 :element-type 'f2cl-lib:integer4))
           (minmag (make-array 4 :element-type 'f2cl-lib:integer4))
           (mcheps (make-array 4 :element-type 'f2cl-lib:integer4))
           (dpmpar 0.0))
      (declare (type (double-float) dpmpar)
               (type (array f2cl-lib:integer4 (4)) mcheps minmag maxmag))
      (setf dpmpar (f2cl-lib:fref dmach (i) ((1 3))))
      (go end_label)
     end_label
      (return (values dpmpar nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dpmpar
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4))
                                            :return-values '(nil) :calls 'nil)))

