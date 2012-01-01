;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(let* ((zero (f2cl-lib:cmplx 0.0 0.0)) (one (f2cl-lib:cmplx 1.0 0.0)))
  (declare (type (f2cl-lib:complex16) zero)
           (type (f2cl-lib:complex16) one)
           (ignorable zero one))
  (defun zlahr2 (n k nb a lda tau t$ ldt y ldy)
    (declare (type (array f2cl-lib:complex16 (*)) y t$ tau a)
             (type (f2cl-lib:integer4) ldy ldt lda nb k n))
    (f2cl-lib:with-multi-array-data
        ((a f2cl-lib:complex16 a-%data% a-%offset%)
         (tau f2cl-lib:complex16 tau-%data% tau-%offset%)
         (t$ f2cl-lib:complex16 t$-%data% t$-%offset%)
         (y f2cl-lib:complex16 y-%data% y-%offset%))
      (prog ((ei #C(0.0 0.0)) (i 0))
        (declare (type (f2cl-lib:complex16) ei)
                 (type (f2cl-lib:integer4) i))
        (if (<= n 1)
            (go end_label))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i nb) nil)
          (tagbody
            (cond
             ((> i 1)
              (multiple-value-bind (var-0 var-1 var-2)
                  (zlacgv (f2cl-lib:int-sub i 1)
                   (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                         ((+ k i (f2cl-lib:int-sub 1)) 1)
                                         ((1 lda) (1 *)) a-%offset%)
                   lda)
                (declare (ignore var-0 var-1))
                (when var-2 (setf lda var-2)))
              (zgemv "NO TRANSPOSE" (f2cl-lib:int-sub n k)
               (f2cl-lib:int-sub i 1) (- one)
               (f2cl-lib:array-slice y-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                     ((1 ldy) (1 nb)) y-%offset%)
               ldy
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                     ((+ k i (f2cl-lib:int-sub 1)) 1)
                                     ((1 lda) (1 *)) a-%offset%)
               lda one
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1) i)
                                     ((1 lda) (1 *)) a-%offset%)
               1)
              (multiple-value-bind (var-0 var-1 var-2)
                  (zlacgv (f2cl-lib:int-sub i 1)
                   (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                         ((+ k i (f2cl-lib:int-sub 1)) 1)
                                         ((1 lda) (1 *)) a-%offset%)
                   lda)
                (declare (ignore var-0 var-1))
                (when var-2 (setf lda var-2)))
              (zcopy (f2cl-lib:int-sub i 1)
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1) i)
                                     ((1 lda) (1 *)) a-%offset%)
               1
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1)
              (ztrmv "Lower" "Conjugate transpose" "UNIT"
               (f2cl-lib:int-sub i 1)
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                     ((1 lda) (1 *)) a-%offset%)
               lda
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1)
              (zgemv "Conjugate transpose"
               (f2cl-lib:int-add (f2cl-lib:int-sub n k i) 1)
               (f2cl-lib:int-sub i 1) one
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) 1)
                                     ((1 lda) (1 *)) a-%offset%)
               lda
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) i)
                                     ((1 lda) (1 *)) a-%offset%)
               1 one
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1)
              (ztrmv "Upper" "Conjugate transpose" "NON-UNIT"
               (f2cl-lib:int-sub i 1) t$ ldt
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1)
              (zgemv "NO TRANSPOSE"
               (f2cl-lib:int-add (f2cl-lib:int-sub n k i) 1)
               (f2cl-lib:int-sub i 1) (- one)
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) 1)
                                     ((1 lda) (1 *)) a-%offset%)
               lda
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1 one
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) i)
                                     ((1 lda) (1 *)) a-%offset%)
               1)
              (ztrmv "Lower" "NO TRANSPOSE" "UNIT" (f2cl-lib:int-sub i 1)
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                     ((1 lda) (1 *)) a-%offset%)
               lda
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1)
              (zaxpy (f2cl-lib:int-sub i 1) (- one)
               (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 nb)
                                     ((1 ldt) (1 nb)) t$-%offset%)
               1
               (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1) i)
                                     ((1 lda) (1 *)) a-%offset%)
               1)
              (setf (f2cl-lib:fref a-%data%
                                   ((f2cl-lib:int-sub (f2cl-lib:int-add k i) 1)
                                    (f2cl-lib:int-sub i 1))
                                   ((1 lda) (1 *)) a-%offset%)
                      ei)))
            (multiple-value-bind (var-0 var-1 var-2 var-3 var-4)
                (zlarfg (f2cl-lib:int-add (f2cl-lib:int-sub n k i) 1)
                 (f2cl-lib:fref a-%data% ((f2cl-lib:int-add k i) i)
                                ((1 lda) (1 *)) a-%offset%)
                 (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                       ((min (f2cl-lib:int-add k i 1) n) i)
                                       ((1 lda) (1 *)) a-%offset%)
                 1 (f2cl-lib:fref tau-%data% (i) ((1 nb)) tau-%offset%))
              (declare (ignore var-0 var-2 var-3))
              (setf (f2cl-lib:fref a-%data% ((f2cl-lib:int-add k i) i)
                                   ((1 lda) (1 *)) a-%offset%)
                      var-1)
              (setf (f2cl-lib:fref tau-%data% (i) ((1 nb)) tau-%offset%)
                      var-4))
            (setf ei
                    (f2cl-lib:fref a-%data% ((f2cl-lib:int-add k i) i)
                                   ((1 lda) (1 *)) a-%offset%))
            (setf (f2cl-lib:fref a-%data% ((f2cl-lib:int-add k i) i)
                                 ((1 lda) (1 *)) a-%offset%)
                    one)
            (zgemv "NO TRANSPOSE" (f2cl-lib:int-sub n k)
             (f2cl-lib:int-add (f2cl-lib:int-sub n k i) 1) one
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                   ((+ k 1) (f2cl-lib:int-add i 1))
                                   ((1 lda) (1 *)) a-%offset%)
             lda
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) i)
                                   ((1 lda) (1 *)) a-%offset%)
             1 zero
             (f2cl-lib:array-slice y-%data% f2cl-lib:complex16 ((+ k 1) i)
                                   ((1 ldy) (1 nb)) y-%offset%)
             1)
            (zgemv "Conjugate transpose"
             (f2cl-lib:int-add (f2cl-lib:int-sub n k i) 1)
             (f2cl-lib:int-sub i 1) one
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) 1)
                                   ((1 lda) (1 *)) a-%offset%)
             lda
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k i) i)
                                   ((1 lda) (1 *)) a-%offset%)
             1 zero
             (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 i)
                                   ((1 ldt) (1 nb)) t$-%offset%)
             1)
            (zgemv "NO TRANSPOSE" (f2cl-lib:int-sub n k) (f2cl-lib:int-sub i 1)
             (- one)
             (f2cl-lib:array-slice y-%data% f2cl-lib:complex16 ((+ k 1) 1)
                                   ((1 ldy) (1 nb)) y-%offset%)
             ldy
             (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 i)
                                   ((1 ldt) (1 nb)) t$-%offset%)
             1 one
             (f2cl-lib:array-slice y-%data% f2cl-lib:complex16 ((+ k 1) i)
                                   ((1 ldy) (1 nb)) y-%offset%)
             1)
            (zscal (f2cl-lib:int-sub n k)
             (f2cl-lib:fref tau-%data% (i) ((1 nb)) tau-%offset%)
             (f2cl-lib:array-slice y-%data% f2cl-lib:complex16 ((+ k 1) i)
                                   ((1 ldy) (1 nb)) y-%offset%)
             1)
            (zscal (f2cl-lib:int-sub i 1)
             (- (f2cl-lib:fref tau-%data% (i) ((1 nb)) tau-%offset%))
             (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 i)
                                   ((1 ldt) (1 nb)) t$-%offset%)
             1)
            (ztrmv "Upper" "No Transpose" "NON-UNIT" (f2cl-lib:int-sub i 1) t$
             ldt
             (f2cl-lib:array-slice t$-%data% f2cl-lib:complex16 (1 i)
                                   ((1 ldt) (1 nb)) t$-%offset%)
             1)
            (setf (f2cl-lib:fref t$-%data% (i i) ((1 ldt) (1 nb)) t$-%offset%)
                    (f2cl-lib:fref tau-%data% (i) ((1 nb)) tau-%offset%))
           label10))
        (setf (f2cl-lib:fref a-%data% ((f2cl-lib:int-add k nb) nb)
                             ((1 lda) (1 *)) a-%offset%)
                ei)
        (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
            (zlacpy "ALL" k nb
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 (1 2)
                                   ((1 lda) (1 *)) a-%offset%)
             lda y ldy)
          (declare (ignore var-0 var-3 var-5))
          (when var-1 (setf k var-1))
          (when var-2 (setf nb var-2))
          (when var-4 (setf lda var-4))
          (when var-6 (setf ldy var-6)))
        (ztrmm "RIGHT" "Lower" "NO TRANSPOSE" "UNIT" k nb one
         (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1) 1)
                               ((1 lda) (1 *)) a-%offset%)
         lda y ldy)
        (if (> n (f2cl-lib:int-add k nb))
            (zgemm "NO TRANSPOSE" "NO TRANSPOSE" k nb (f2cl-lib:int-sub n k nb)
             one
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16
                                   (1 (f2cl-lib:int-add 2 nb)) ((1 lda) (1 *))
                                   a-%offset%)
             lda
             (f2cl-lib:array-slice a-%data% f2cl-lib:complex16 ((+ k 1 nb) 1)
                                   ((1 lda) (1 *)) a-%offset%)
             lda one y ldy))
        (ztrmm "RIGHT" "Upper" "NO TRANSPOSE" "NON-UNIT" k nb one t$ ldt y ldy)
        (go end_label)
       end_label
        (return (values nil k nb nil lda nil nil nil nil ldy))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zlahr2
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
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil fortran-to-lisp::k
                                              fortran-to-lisp::nb nil
                                              fortran-to-lisp::lda nil nil nil
                                              nil fortran-to-lisp::ldy)
                                            :calls
                                            '(fortran-to-lisp::zgemm
                                              fortran-to-lisp::ztrmm
                                              fortran-to-lisp::zscal
                                              fortran-to-lisp::zlarfg
                                              fortran-to-lisp::zaxpy
                                              fortran-to-lisp::ztrmv
                                              fortran-to-lisp::zcopy
                                              fortran-to-lisp::zgemv))))

