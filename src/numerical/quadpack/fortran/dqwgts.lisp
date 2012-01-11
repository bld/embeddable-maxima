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


(defun dqwgts (x a b alfa beta integr)
  (declare (type (f2cl-lib:integer4) integr)
           (type (double-float) beta alfa b a x))
  (prog ((bmx 0.0) (dlog$ 0.0) (xma 0.0) (dqwgts 0.0))
    (declare (type (double-float) dqwgts xma dlog$ bmx))
    (setf xma (- x a))
    (setf bmx (- b x))
    (setf dqwgts (* (expt xma alfa) (expt bmx beta)))
    (f2cl-lib:computed-goto (label40 label10 label20 label30) integr)
   label10
    (setf dqwgts (* dqwgts (f2cl-lib:dlog xma)))
    (go label40)
   label20
    (setf dqwgts (* dqwgts (f2cl-lib:dlog bmx)))
    (go label40)
   label30
    (setf dqwgts (* dqwgts (f2cl-lib:dlog xma) (f2cl-lib:dlog bmx)))
   label40
    (go end_label)
   end_label
    (return (values dqwgts nil nil nil nil nil nil))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dqwgts
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((double-float) (double-float)
                                              (double-float) (double-float)
                                              (double-float)
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil nil nil) :calls
                                            'nil)))

