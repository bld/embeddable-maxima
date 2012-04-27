;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 2bc8b118fd29 2011/12/03 06:01:32 toy $"
;;;  "f2cl2.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 2bc8b118fd29 2011/12/03 06:01:32 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v fceac530ef0c 2011/11/26 04:02:26 toy $")

;;; Using Lisp SBCL 1.0.56
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing nil) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "EM-SLATEC")


(defun zshch (zr zi cshr cshi cchr cchi)
  (declare (type (double-float) cchi cchr cshi cshr zi zr))
  (prog ((ch 0.0) (cn 0.0) (sh 0.0) (sn 0.0))
    (declare (type (double-float) sn sh cn ch))
    (setf sh (sinh zr))
    (setf ch (cosh zr))
    (setf sn (sin zi))
    (setf cn (cos zi))
    (setf cshr (* sh cn))
    (setf cshi (* ch sn))
    (setf cchr (* ch cn))
    (setf cchi (* sh sn))
    (go end_label)
   end_label
    (return (values nil nil cshr cshi cchr cchi))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zshch fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((double-float) (double-float)
                                              (double-float) (double-float)
                                              (double-float) (double-float))
                                            :return-values
                                            '(nil nil fortran-to-lisp::cshr
                                              fortran-to-lisp::cshi
                                              fortran-to-lisp::cchr
                                              fortran-to-lisp::cchi)
                                            :calls 'nil)))

