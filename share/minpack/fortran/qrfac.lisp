;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((one 1.0) (p05 0.05) (zero 0.0))
  (declare (type (double-float) one p05 zero))
  (defun qrfac (m n a lda pivot ipvt lipvt rdiag acnorm wa)
    (declare (type (array f2cl-lib:integer4 (*)) ipvt)
             (type f2cl-lib:logical pivot)
             (type (array double-float (*)) wa acnorm rdiag a)
             (type (f2cl-lib:integer4) lipvt lda n m))
    (f2cl-lib:with-multi-array-data
        ((a double-float a-%data% a-%offset%)
         (rdiag double-float rdiag-%data% rdiag-%offset%)
         (acnorm double-float acnorm-%data% acnorm-%offset%)
         (wa double-float wa-%data% wa-%offset%)
         (ipvt f2cl-lib:integer4 ipvt-%data% ipvt-%offset%))
      (prog ((ajnorm 0.0) (epsmch 0.0) (sum 0.0) (temp 0.0) (i 0) (j 0) (jp1 0)
             (k 0) (kmax 0) (minmn 0))
        (declare (type (f2cl-lib:integer4) minmn kmax k jp1 j i)
                 (type (double-float) temp sum epsmch ajnorm))
        (setf epsmch (dpmpar 1))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref acnorm-%data% (j) ((1 n)) acnorm-%offset%)
                    (enorm m
                     (f2cl-lib:array-slice a-%data% double-float (1 j)
                                           ((1 lda) (1 n)) a-%offset%)))
            (setf (f2cl-lib:fref rdiag-%data% (j) ((1 n)) rdiag-%offset%)
                    (f2cl-lib:fref acnorm-%data% (j) ((1 n)) acnorm-%offset%))
            (setf (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%)
                    (f2cl-lib:fref rdiag-%data% (j) ((1 n)) rdiag-%offset%))
            (if pivot
                (setf (f2cl-lib:fref ipvt-%data% (j) ((1 lipvt)) ipvt-%offset%)
                        j))
           label10))
        (setf minmn (f2cl-lib:min0 m n))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j minmn) nil)
          (tagbody
            (if (not pivot)
                (go label40))
            (setf kmax j)
            (f2cl-lib:fdo (k j (f2cl-lib:int-add k 1))
                          ((> k n) nil)
              (tagbody
                (if (> (f2cl-lib:fref rdiag-%data% (k) ((1 n)) rdiag-%offset%)
                       (f2cl-lib:fref rdiag-%data% (kmax) ((1 n))
                                      rdiag-%offset%))
                    (setf kmax k))
               label20))
            (if (= kmax j)
                (go label40))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf temp
                        (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                       a-%offset%))
                (setf (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n)) a-%offset%)
                        (f2cl-lib:fref a-%data% (i kmax) ((1 lda) (1 n))
                                       a-%offset%))
                (setf (f2cl-lib:fref a-%data% (i kmax) ((1 lda) (1 n))
                                     a-%offset%)
                        temp)
               label30))
            (setf (f2cl-lib:fref rdiag-%data% (kmax) ((1 n)) rdiag-%offset%)
                    (f2cl-lib:fref rdiag-%data% (j) ((1 n)) rdiag-%offset%))
            (setf (f2cl-lib:fref wa-%data% (kmax) ((1 n)) wa-%offset%)
                    (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%))
            (setf k (f2cl-lib:fref ipvt-%data% (j) ((1 lipvt)) ipvt-%offset%))
            (setf (f2cl-lib:fref ipvt-%data% (j) ((1 lipvt)) ipvt-%offset%)
                    (f2cl-lib:fref ipvt-%data% (kmax) ((1 lipvt))
                                   ipvt-%offset%))
            (setf (f2cl-lib:fref ipvt-%data% (kmax) ((1 lipvt)) ipvt-%offset%)
                    k)
           label40
            (setf ajnorm
                    (enorm (f2cl-lib:int-add (f2cl-lib:int-sub m j) 1)
                     (f2cl-lib:array-slice a-%data% double-float (j j)
                                           ((1 lda) (1 n)) a-%offset%)))
            (if (= ajnorm zero)
                (go label100))
            (if (< (f2cl-lib:fref a-%data% (j j) ((1 lda) (1 n)) a-%offset%)
                   zero)
                (setf ajnorm (- ajnorm)))
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n)) a-%offset%)
                        (/
                         (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                        a-%offset%)
                         ajnorm))
               label50))
            (setf (f2cl-lib:fref a-%data% (j j) ((1 lda) (1 n)) a-%offset%)
                    (+
                     (f2cl-lib:fref a-%data% (j j) ((1 lda) (1 n)) a-%offset%)
                     one))
            (setf jp1 (f2cl-lib:int-add j 1))
            (if (< n jp1)
                (go label100))
            (f2cl-lib:fdo (k jp1 (f2cl-lib:int-add k 1))
                          ((> k n) nil)
              (tagbody
                (setf sum zero)
                (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                              ((> i m) nil)
                  (tagbody
                    (setf sum
                            (+ sum
                               (*
                                (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                               a-%offset%)
                                (f2cl-lib:fref a-%data% (i k) ((1 lda) (1 n))
                                               a-%offset%))))
                   label60))
                (setf temp
                        (/ sum
                           (f2cl-lib:fref a-%data% (j j) ((1 lda) (1 n))
                                          a-%offset%)))
                (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                              ((> i m) nil)
                  (tagbody
                    (setf (f2cl-lib:fref a-%data% (i k) ((1 lda) (1 n))
                                         a-%offset%)
                            (-
                             (f2cl-lib:fref a-%data% (i k) ((1 lda) (1 n))
                                            a-%offset%)
                             (* temp
                                (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                               a-%offset%))))
                   label70))
                (if (or (not pivot)
                        (=
                         (f2cl-lib:fref rdiag-%data% (k) ((1 n))
                                        rdiag-%offset%)
                         zero))
                    (go label80))
                (setf temp
                        (/
                         (f2cl-lib:fref a-%data% (j k) ((1 lda) (1 n))
                                        a-%offset%)
                         (f2cl-lib:fref rdiag-%data% (k) ((1 n))
                                        rdiag-%offset%)))
                (setf (f2cl-lib:fref rdiag-%data% (k) ((1 n)) rdiag-%offset%)
                        (*
                         (f2cl-lib:fref rdiag-%data% (k) ((1 n))
                                        rdiag-%offset%)
                         (f2cl-lib:dsqrt
                          (f2cl-lib:dmax1 zero (- one (expt temp 2))))))
                (if (>
                     (* p05
                        (expt
                         (/
                          (f2cl-lib:fref rdiag-%data% (k) ((1 n))
                                         rdiag-%offset%)
                          (f2cl-lib:fref wa-%data% (k) ((1 n)) wa-%offset%))
                         2))
                     epsmch)
                    (go label80))
                (setf (f2cl-lib:fref rdiag-%data% (k) ((1 n)) rdiag-%offset%)
                        (enorm (f2cl-lib:int-sub m j)
                         (f2cl-lib:array-slice a-%data% double-float (jp1 k)
                                               ((1 lda) (1 n)) a-%offset%)))
                (setf (f2cl-lib:fref wa-%data% (k) ((1 n)) wa-%offset%)
                        (f2cl-lib:fref rdiag-%data% (k) ((1 n))
                                       rdiag-%offset%))
               label80
               label90))
           label100
            (setf (f2cl-lib:fref rdiag-%data% (j) ((1 n)) rdiag-%offset%)
                    (- ajnorm))
           label110))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::qrfac fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              fortran-to-lisp::logical
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil nil nil
                                              nil nil)
                                            :calls
                                            '(fortran-to-lisp::enorm
                                              fortran-to-lisp::dpmpar))))

