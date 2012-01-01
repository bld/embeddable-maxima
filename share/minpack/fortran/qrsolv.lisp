;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((p5 0.5) (p25 0.25) (zero 0.0))
  (declare (type (double-float) p5 p25 zero))
  (defun qrsolv (n r ldr ipvt diag qtb x sdiag wa)
    (declare (type (array f2cl-lib:integer4 (*)) ipvt)
             (type (array double-float (*)) wa sdiag x qtb diag r)
             (type (f2cl-lib:integer4) ldr n))
    (f2cl-lib:with-multi-array-data
        ((r double-float r-%data% r-%offset%)
         (diag double-float diag-%data% diag-%offset%)
         (qtb double-float qtb-%data% qtb-%offset%)
         (x double-float x-%data% x-%offset%)
         (sdiag double-float sdiag-%data% sdiag-%offset%)
         (wa double-float wa-%data% wa-%offset%)
         (ipvt f2cl-lib:integer4 ipvt-%data% ipvt-%offset%))
      (prog ((cos 0.0) (cotan 0.0) (qtbpj 0.0) (sin 0.0) (sum 0.0) (tan 0.0)
             (temp 0.0) (i 0) (j 0) (jp1 0) (k 0) (kp1 0) (l 0) (nsing 0))
        (declare (type (f2cl-lib:integer4) nsing l kp1 k jp1 j i)
                 (type (double-float) temp tan sum sin qtbpj cotan cos))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i n) nil)
              (tagbody
                (setf (f2cl-lib:fref r-%data% (i j) ((1 ldr) (1 n)) r-%offset%)
                        (f2cl-lib:fref r-%data% (j i) ((1 ldr) (1 n))
                                       r-%offset%))
               label10))
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                    (f2cl-lib:fref r-%data% (j j) ((1 ldr) (1 n)) r-%offset%))
            (setf (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%)
                    (f2cl-lib:fref qtb-%data% (j) ((1 n)) qtb-%offset%))
           label20))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (if (= (f2cl-lib:fref diag-%data% (l) ((1 n)) diag-%offset%) zero)
                (go label90))
            (f2cl-lib:fdo (k j (f2cl-lib:int-add k 1))
                          ((> k n) nil)
              (tagbody
                (setf (f2cl-lib:fref sdiag-%data% (k) ((1 n)) sdiag-%offset%)
                        zero)
               label30))
            (setf (f2cl-lib:fref sdiag-%data% (j) ((1 n)) sdiag-%offset%)
                    (f2cl-lib:fref diag-%data% (l) ((1 n)) diag-%offset%))
            (setf qtbpj zero)
            (f2cl-lib:fdo (k j (f2cl-lib:int-add k 1))
                          ((> k n) nil)
              (tagbody
                (if (= (f2cl-lib:fref sdiag-%data% (k) ((1 n)) sdiag-%offset%)
                       zero)
                    (go label70))
                (if (>=
                     (f2cl-lib:dabs
                      (f2cl-lib:fref r-%data% (k k) ((1 ldr) (1 n))
                                     r-%offset%))
                     (f2cl-lib:dabs
                      (f2cl-lib:fref sdiag-%data% (k) ((1 n)) sdiag-%offset%)))
                    (go label40))
                (setf cotan
                        (/
                         (f2cl-lib:fref r-%data% (k k) ((1 ldr) (1 n))
                                        r-%offset%)
                         (f2cl-lib:fref sdiag-%data% (k) ((1 n))
                                        sdiag-%offset%)))
                (setf sin
                        (/ p5 (f2cl-lib:dsqrt (+ p25 (* p25 (expt cotan 2))))))
                (setf cos (* sin cotan))
                (go label50)
               label40
                (setf tan
                        (/
                         (f2cl-lib:fref sdiag-%data% (k) ((1 n))
                                        sdiag-%offset%)
                         (f2cl-lib:fref r-%data% (k k) ((1 ldr) (1 n))
                                        r-%offset%)))
                (setf cos (/ p5 (f2cl-lib:dsqrt (+ p25 (* p25 (expt tan 2))))))
                (setf sin (* cos tan))
               label50
                (setf (f2cl-lib:fref r-%data% (k k) ((1 ldr) (1 n)) r-%offset%)
                        (+
                         (* cos
                            (f2cl-lib:fref r-%data% (k k) ((1 ldr) (1 n))
                                           r-%offset%))
                         (* sin
                            (f2cl-lib:fref sdiag-%data% (k) ((1 n))
                                           sdiag-%offset%))))
                (setf temp
                        (+
                         (* cos
                            (f2cl-lib:fref wa-%data% (k) ((1 n)) wa-%offset%))
                         (* sin qtbpj)))
                (setf qtbpj
                        (+
                         (* (- sin)
                            (f2cl-lib:fref wa-%data% (k) ((1 n)) wa-%offset%))
                         (* cos qtbpj)))
                (setf (f2cl-lib:fref wa-%data% (k) ((1 n)) wa-%offset%) temp)
                (setf kp1 (f2cl-lib:int-add k 1))
                (if (< n kp1)
                    (go label70))
                (f2cl-lib:fdo (i kp1 (f2cl-lib:int-add i 1))
                              ((> i n) nil)
                  (tagbody
                    (setf temp
                            (+
                             (* cos
                                (f2cl-lib:fref r-%data% (i k) ((1 ldr) (1 n))
                                               r-%offset%))
                             (* sin
                                (f2cl-lib:fref sdiag-%data% (i) ((1 n))
                                               sdiag-%offset%))))
                    (setf (f2cl-lib:fref sdiag-%data% (i) ((1 n))
                                         sdiag-%offset%)
                            (+
                             (* (- sin)
                                (f2cl-lib:fref r-%data% (i k) ((1 ldr) (1 n))
                                               r-%offset%))
                             (* cos
                                (f2cl-lib:fref sdiag-%data% (i) ((1 n))
                                               sdiag-%offset%))))
                    (setf (f2cl-lib:fref r-%data% (i k) ((1 ldr) (1 n))
                                         r-%offset%)
                            temp)
                   label60))
               label70
               label80))
           label90
            (setf (f2cl-lib:fref sdiag-%data% (j) ((1 n)) sdiag-%offset%)
                    (f2cl-lib:fref r-%data% (j j) ((1 ldr) (1 n)) r-%offset%))
            (setf (f2cl-lib:fref r-%data% (j j) ((1 ldr) (1 n)) r-%offset%)
                    (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%))
           label100))
        (setf nsing n)
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (if (and
                 (= (f2cl-lib:fref sdiag-%data% (j) ((1 n)) sdiag-%offset%)
                    zero)
                 (= nsing n))
                (setf nsing (f2cl-lib:int-sub j 1)))
            (if (< nsing n)
                (setf (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%) zero))
           label110))
        (if (< nsing 1)
            (go label150))
        (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                      ((> k nsing) nil)
          (tagbody
            (setf j (f2cl-lib:int-add (f2cl-lib:int-sub nsing k) 1))
            (setf sum zero)
            (setf jp1 (f2cl-lib:int-add j 1))
            (if (< nsing jp1)
                (go label130))
            (f2cl-lib:fdo (i jp1 (f2cl-lib:int-add i 1))
                          ((> i nsing) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (*
                            (f2cl-lib:fref r-%data% (i j) ((1 ldr) (1 n))
                                           r-%offset%)
                            (f2cl-lib:fref wa-%data% (i) ((1 n))
                                           wa-%offset%))))
               label120))
           label130
            (setf (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%)
                    (/
                     (- (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%) sum)
                     (f2cl-lib:fref sdiag-%data% (j) ((1 n)) sdiag-%offset%)))
           label140))
       label150
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (setf (f2cl-lib:fref x-%data% (l) ((1 n)) x-%offset%)
                    (f2cl-lib:fref wa-%data% (j) ((1 n)) wa-%offset%))
           label160))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::qrsolv
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil nil nil
                                              nil)
                                            :calls 'nil)))

