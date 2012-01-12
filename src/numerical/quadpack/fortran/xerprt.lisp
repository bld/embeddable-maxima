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

(in-package "EM-QUADPACK")


(defun xerprt (messg nmessg)
  (declare (type (f2cl-lib:integer4) nmessg)
           (type (simple-array character (*)) messg))
  (f2cl-lib:with-multi-array-data
      ((messg character messg-%data% messg-%offset%))
    (prog ((lun (make-array 5 :element-type 'f2cl-lib:integer4)) (last$ 0)
           (ichar$ 0) (iunit 0) (kunit 0) (lenmes 0) (nunit 0))
      (declare (type (f2cl-lib:integer4) nunit lenmes kunit iunit ichar$ last$)
               (type (array f2cl-lib:integer4 (5)) lun))
      (multiple-value-bind (var-0 var-1)
          (xgetua lun nunit)
        (declare (ignore var-0))
        (setf nunit var-1))
      (setf lenmes (f2cl-lib:len messg))
      (f2cl-lib:fdo (kunit 1 (f2cl-lib:int-add kunit 1))
                    ((> kunit nunit) nil)
        (tagbody
          (setf iunit (f2cl-lib:fref lun (kunit) ((1 5))))
          (if (= iunit 0)
              (setf iunit (f2cl-lib:i1mach 4)))
          (f2cl-lib:fdo (ichar$ 1 (f2cl-lib:int-add ichar$ 72))
                        ((> ichar$ lenmes) nil)
            (tagbody
              (setf last$ (f2cl-lib:min0 (f2cl-lib:int-add ichar$ 71) lenmes))
              (f2cl-lib:fformat iunit (t ("~1@T" ("~A")) "~%")
                                (f2cl-lib:fref-string messg (ichar$ last$)))
             label10))
         label20))
      (go end_label)
     end_label
      (return (values nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::xerprt
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((simple-array character (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values '(nil nil) :calls
                                            '(fortran-to-lisp::i1mach
                                              fortran-to-lisp::xgetua))))

