;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "COLNEW")


(defun sbblok (bloks integs nbloks ipivot x)
  (declare (type (array f2cl-lib:integer4 (*)) ipivot)
           (type (f2cl-lib:integer4) nbloks)
           (type (array f2cl-lib:integer4 (*)) integs)
           (type (array double-float (*)) x bloks))
  (f2cl-lib:with-multi-array-data
      ((bloks double-float bloks-%data% bloks-%offset%)
       (x double-float x-%data% x-%offset%)
       (integs f2cl-lib:integer4 integs-%data% integs-%offset%)
       (ipivot f2cl-lib:integer4 ipivot-%data% ipivot-%offset%))
    (prog ((i 0) (indexx 0) (j 0) (nbp1 0) (ncol 0) (nrow 0) (last$ 0)
           (index$ 0))
      (declare
       (type (f2cl-lib:integer4) index$ last$ nrow ncol nbp1 j indexx i))
      (setf index$ 1)
      (setf indexx 1)
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i nbloks) nil)
        (tagbody
          (setf nrow
                  (f2cl-lib:fref integs-%data% (1 i) ((1 3) (1 nbloks))
                                 integs-%offset%))
          (setf last$
                  (f2cl-lib:fref integs-%data% (3 i) ((1 3) (1 nbloks))
                                 integs-%offset%))
          (subfor
           (f2cl-lib:array-slice bloks-%data% double-float (index$) ((1 1))
                                 bloks-%offset%)
           (f2cl-lib:array-slice ipivot-%data% f2cl-lib:integer4 (indexx)
                                 ((1 1)) ipivot-%offset%)
           nrow last$
           (f2cl-lib:array-slice x-%data% double-float (indexx) ((1 1))
                                 x-%offset%))
          (setf index$
                  (f2cl-lib:int-add
                   (f2cl-lib:int-mul nrow
                                     (f2cl-lib:fref integs-%data% (2 i)
                                                    ((1 3) (1 nbloks))
                                                    integs-%offset%))
                   index$))
         label10
          (setf indexx (f2cl-lib:int-add indexx last$))))
      (setf nbp1 (f2cl-lib:int-add nbloks 1))
      (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                    ((> j nbloks) nil)
        (tagbody
          (setf i (f2cl-lib:int-sub nbp1 j))
          (setf nrow
                  (f2cl-lib:fref integs-%data% (1 i) ((1 3) (1 nbloks))
                                 integs-%offset%))
          (setf ncol
                  (f2cl-lib:fref integs-%data% (2 i) ((1 3) (1 nbloks))
                                 integs-%offset%))
          (setf last$
                  (f2cl-lib:fref integs-%data% (3 i) ((1 3) (1 nbloks))
                                 integs-%offset%))
          (setf index$ (f2cl-lib:int-sub index$ (f2cl-lib:int-mul nrow ncol)))
          (setf indexx (f2cl-lib:int-sub indexx last$))
         label20
          (subbak
           (f2cl-lib:array-slice bloks-%data% double-float (index$) ((1 1))
                                 bloks-%offset%)
           nrow ncol last$
           (f2cl-lib:array-slice x-%data% double-float (indexx) ((1 1))
                                 x-%offset%))))
      (go end_label)
     end_label
      (return (values nil nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::sbblok
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((array double-float (*))
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil) :calls
                                            '(fortran-to-lisp::subbak
                                              fortran-to-lisp::subfor))))

