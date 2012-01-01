;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(defun zlacpy (uplo m n a lda b ldb$)
  (declare (type (array f2cl-lib:complex16 (*)) b a)
           (type (f2cl-lib:integer4) ldb$ lda n m)
           (type (simple-array character (*)) uplo))
  (f2cl-lib:with-multi-array-data
      ((uplo character uplo-%data% uplo-%offset%)
       (a f2cl-lib:complex16 a-%data% a-%offset%)
       (b f2cl-lib:complex16 b-%data% b-%offset%))
    (prog ((i 0) (j 0))
      (declare (type (f2cl-lib:integer4) j i))
      (cond
       ((lsame uplo "U")
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i
                              (min (the f2cl-lib:integer4 j)
                                   (the f2cl-lib:integer4 m)))
                           nil)
              (tagbody
                (setf (f2cl-lib:fref b-%data% (i j) ((1 ldb$) (1 *))
                                     b-%offset%)
                        (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 *))
                                       a-%offset%))
               label10))
           label20)))
       ((lsame uplo "L")
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref b-%data% (i j) ((1 ldb$) (1 *))
                                     b-%offset%)
                        (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 *))
                                       a-%offset%))
               label30))
           label40)))
       (t
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref b-%data% (i j) ((1 ldb$) (1 *))
                                     b-%offset%)
                        (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 *))
                                       a-%offset%))
               label50))
           label60))))
      (go end_label)
     end_label
      (return (values nil nil nil nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zlacpy
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((simple-array character (*))
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil nil nil nil)
                                            :calls '(fortran-to-lisp::lsame))))

