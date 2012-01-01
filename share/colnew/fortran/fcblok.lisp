;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "COLNEW")


(defun fcblok (bloks integs nbloks ipivot scrtch info)
  (declare (type (array f2cl-lib:integer4 (*)) ipivot)
           (type (f2cl-lib:integer4) info nbloks)
           (type (array f2cl-lib:integer4 (*)) integs)
           (type (array double-float (*)) scrtch bloks))
  (f2cl-lib:with-multi-array-data
      ((bloks double-float bloks-%data% bloks-%offset%)
       (scrtch double-float scrtch-%data% scrtch-%offset%)
       (integs f2cl-lib:integer4 integs-%data% integs-%offset%)
       (ipivot f2cl-lib:integer4 ipivot-%data% ipivot-%offset%))
    (prog ((i 0) (indexn 0) (ncol 0) (nrow 0) (last$ 0) (index$ 0) (indexx 0))
      (declare
       (type (f2cl-lib:integer4) indexx index$ last$ nrow ncol indexn i))
      (setf info 0)
      (setf indexx 1)
      (setf indexn 1)
      (setf i 1)
     label10
      (setf index$ indexn)
      (setf nrow
              (f2cl-lib:fref integs-%data% (1 i) ((1 3) (1 nbloks))
                             integs-%offset%))
      (setf ncol
              (f2cl-lib:fref integs-%data% (2 i) ((1 3) (1 nbloks))
                             integs-%offset%))
      (setf last$
              (f2cl-lib:fref integs-%data% (3 i) ((1 3) (1 nbloks))
                             integs-%offset%))
      (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
          (factrb
           (f2cl-lib:array-slice bloks-%data% double-float (index$) ((1 1))
                                 bloks-%offset%)
           (f2cl-lib:array-slice ipivot-%data% f2cl-lib:integer4 (indexx)
                                 ((1 1)) ipivot-%offset%)
           scrtch nrow ncol last$ info)
        (declare (ignore var-0 var-1 var-2 var-3 var-4 var-5))
        (setf info var-6))
      (if (/= info 0)
          (go label20))
      (if (= i nbloks)
          (go end_label))
      (setf i (f2cl-lib:int-add i 1))
      (setf indexn (f2cl-lib:int-add (f2cl-lib:int-mul nrow ncol) index$))
      (setf indexx (f2cl-lib:int-add indexx last$))
      (shiftb
       (f2cl-lib:array-slice bloks-%data% double-float (index$) ((1 1))
                             bloks-%offset%)
       nrow ncol last$
       (f2cl-lib:array-slice bloks-%data% double-float (indexn) ((1 1))
                             bloks-%offset%)
       (f2cl-lib:fref integs-%data% (1 i) ((1 3) (1 nbloks)) integs-%offset%)
       (f2cl-lib:fref integs-%data% (2 i) ((1 3) (1 nbloks)) integs-%offset%))
      (go label10)
     label20
      (setf info (f2cl-lib:int-sub (f2cl-lib:int-add info indexx) 1))
      (go end_label)
     end_label
      (return (values nil nil nil nil nil info)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::fcblok
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((array double-float (*))
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil nil
                                              fortran-to-lisp::info)
                                            :calls
                                            '(fortran-to-lisp::shiftb
                                              fortran-to-lisp::factrb))))

