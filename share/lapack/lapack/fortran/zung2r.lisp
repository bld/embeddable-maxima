;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(let* ((one (f2cl-lib:cmplx 1.0 0.0)) (zero (f2cl-lib:cmplx 0.0 0.0)))
  (declare (type (f2cl-lib:complex16) one)
           (type (f2cl-lib:complex16) zero)
           (ignorable one zero))
  (defun zung2r (m n k a lda tau work info)
    (declare (type (array f2cl-lib:complex16 (*)) work tau a)
             (type (f2cl-lib:integer4) info lda k n m))
    (f2cl-lib:with-multi-array-data
        ((a f2cl-lib:complex16 a-%data% a-%offset%)
         (tau f2cl-lib:complex16 tau-%data% tau-%offset%)
         (work f2cl-lib:complex16 work-%data% work-%offset%))
      (prog ((i 0) (j 0) (l 0))
        (declare (type (f2cl-lib:integer4) i j l))
        (setf info 0)
        (cond ((< m 0) (setf info -1)) ((or (< n 0) (> n m)) (setf info -2))
              ((or (< k 0) (> k n)) (setf info -3))
              ((< lda
                  (max (the f2cl-lib:integer4 1) (the f2cl-lib:integer4 m)))
               (setf info -5)))
        (cond
         ((/= info 0) (xerbla "ZUNG2R" (f2cl-lib:int-sub info))
          (go end_label)))
        (if (<= n 0)
            (go end_label))
        (f2cl-lib:fdo (j (f2cl-lib:int-add k 1) (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (f2cl-lib:fdo (l 1 (f2cl-lib:int-add l 1))
                          ((> l m) nil)
              (tagbody
                (setf (f2cl-lib:fref a-%data% (l j) ((1 lda) (1 *)) a-%offset%)
                        zero)
               label10))
            (setf (f2cl-lib:fref a-%data% (j j) ((1 lda) (1 *)) a-%offset%)
                    one)
           label20))
        (f2cl-lib:fdo (i k (f2cl-lib:int-add i (f2cl-lib:int-sub 1)))
                      ((> i 1) nil)
          (tagbody
            (cond
             ((< i n)
              (setf (f2cl-lib:fref a-%data% (i i) ((1 lda) (1 *)) a-%offset%)
                      one)
              (multiple-value-bind
                  (var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8)
                  (zlarf "Left" (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                   (f2cl-lib:int-sub n i)
                   (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 (i i)
                                         ((1 lda) (1 *)) a-%offset%)
                   1 (f2cl-lib:fref tau-%data% (i) ((1 *)) tau-%offset%)
                   (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)) a-%offset%)
                   lda work)
                (declare
                 (ignore var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-8))
                (setf lda var-7))))
            (if (< i m)
                (zscal (f2cl-lib:int-sub m i)
                 (- (f2cl-lib:fref tau-%data% (i) ((1 *)) tau-%offset%))
                 (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ i 1) i)
                                       ((1 lda) (1 *)) a-%offset%)
                 1))
            (setf (f2cl-lib:fref a-%data% (i i) ((1 lda) (1 *)) a-%offset%)
                    (- one
                       (f2cl-lib:fref tau-%data% (i) ((1 *)) tau-%offset%)))
            (f2cl-lib:fdo (l 1 (f2cl-lib:int-add l 1))
                          ((> l (f2cl-lib:int-add i (f2cl-lib:int-sub 1))) nil)
              (tagbody
                (setf (f2cl-lib:fref a-%data% (l i) ((1 lda) (1 *)) a-%offset%)
                        zero)
               label30))
           label40))
        (go end_label)
       end_label
        (return (values nil nil nil nil lda nil nil info))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zung2r
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil
                                              fortran-to-lisp::lda nil nil
                                              fortran-to-lisp::info)
                                            :calls
                                            '(fortran-to-lisp::zscal
                                              fortran-to-lisp::zlarf
                                              fortran-to-lisp::xerbla))))

