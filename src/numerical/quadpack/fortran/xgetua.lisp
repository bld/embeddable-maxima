;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 2bc8b118fd29 2011/12/02 22:01:32 toy $"
;;;  "f2cl2.l,v 96616d88fb7e 2008/02/22 17:19:34 rtoy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 17:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 17:19:34 rtoy $"
;;;  "f2cl5.l,v 2bc8b118fd29 2011/12/02 22:01:32 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/23 20:56:27 rtoy $"
;;;  "macros.l,v fceac530ef0c 2011/11/25 20:02:26 toy $")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "QUADPACK")


(defun xgetua (iunita n)
  (declare (type (f2cl-lib:integer4) n)
           (type (array f2cl-lib:integer4 (*)) iunita))
  (f2cl-lib:with-multi-array-data
      ((iunita f2cl-lib:integer4 iunita-%data% iunita-%offset%))
    (prog ((index$ 0) (i 0))
      (declare (type (f2cl-lib:integer4) i index$))
      (setf n (j4save 5 0 f2cl-lib:%false%))
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i n) nil)
        (tagbody
          (setf index$ (f2cl-lib:int-add i 4))
          (if (= i 1)
              (setf index$ 3))
          (setf (f2cl-lib:fref iunita-%data% (i) ((1 5)) iunita-%offset%)
                  (j4save index$ 0 f2cl-lib:%false%))
         label30))
      (go end_label)
     end_label
      (return (values nil n)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::xgetua
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((array fortran-to-lisp::integer4
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil fortran-to-lisp::n) :calls
                                            '(fortran-to-lisp::j4save))))

