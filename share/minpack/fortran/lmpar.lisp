;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((p1 0.1) (p001 0.001) (zero 0.0))
  (declare (type (double-float) p1 p001 zero))
  (defun lmpar (n r ldr ipvt diag qtb delta par x sdiag wa1 wa2)
    (declare (type (double-float) par delta)
             (type (array f2cl-lib:integer4 (*)) ipvt)
             (type (array double-float (*)) wa2 wa1 sdiag x qtb diag r)
             (type (f2cl-lib:integer4) ldr n))
    (f2cl-lib:with-multi-array-data
        ((r double-float r-%data% r-%offset%)
         (diag double-float diag-%data% diag-%offset%)
         (qtb double-float qtb-%data% qtb-%offset%)
         (x double-float x-%data% x-%offset%)
         (sdiag double-float sdiag-%data% sdiag-%offset%)
         (wa1 double-float wa1-%data% wa1-%offset%)
         (wa2 double-float wa2-%data% wa2-%offset%)
         (ipvt f2cl-lib:integer4 ipvt-%data% ipvt-%offset%))
      (prog ((dxnorm 0.0) (dwarf 0.0) (fp 0.0) (gnorm 0.0) (parc 0.0)
             (parl 0.0) (paru 0.0) (sum 0.0) (temp 0.0) (i 0) (iter 0) (j 0)
             (jm1 0) (jp1 0) (k 0) (l 0) (nsing 0))
        (declare (type (f2cl-lib:integer4) nsing l k jp1 jm1 j iter i)
                 (type (double-float) temp sum paru parl parc gnorm fp dwarf
                  dxnorm))
        (setf dwarf (dpmpar 2))
        (setf nsing n)
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (f2cl-lib:fref qtb-%data% (j) ((1 n)) qtb-%offset%))
            (if (and
                 (= (f2cl-lib:fref r-%data% (j j) ((1 ldr) (1 n)) r-%offset%)
                    zero)
                 (= nsing n))
                (setf nsing (f2cl-lib:int-sub j 1)))
            (if (< nsing n)
                (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                        zero))
           label10))
        (if (< nsing 1)
            (go label50))
        (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                      ((> k nsing) nil)
          (tagbody
            (setf j (f2cl-lib:int-add (f2cl-lib:int-sub nsing k) 1))
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (/ (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                       (f2cl-lib:fref r-%data% (j j) ((1 ldr) (1 n))
                                      r-%offset%)))
            (setf temp (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%))
            (setf jm1 (f2cl-lib:int-sub j 1))
            (if (< jm1 1)
                (go label30))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i jm1) nil)
              (tagbody
                (setf (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                        (- (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                           (*
                            (f2cl-lib:fref r-%data% (i j) ((1 ldr) (1 n))
                                           r-%offset%)
                            temp)))
               label20))
           label30
           label40))
       label50
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (setf (f2cl-lib:fref x-%data% (l) ((1 n)) x-%offset%)
                    (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%))
           label60))
        (setf iter 0)
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                    (* (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                       (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)))
           label70))
        (setf dxnorm (enorm n wa2))
        (setf fp (- dxnorm delta))
        (if (<= fp (* p1 delta))
            (go label220))
        (setf parl zero)
        (if (< nsing n)
            (go label120))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (* (f2cl-lib:fref diag-%data% (l) ((1 n)) diag-%offset%)
                       (/ (f2cl-lib:fref wa2-%data% (l) ((1 n)) wa2-%offset%)
                          dxnorm)))
           label80))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf sum zero)
            (setf jm1 (f2cl-lib:int-sub j 1))
            (if (< jm1 1)
                (go label100))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i jm1) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (*
                            (f2cl-lib:fref r-%data% (i j) ((1 ldr) (1 n))
                                           r-%offset%)
                            (f2cl-lib:fref wa1-%data% (i) ((1 n))
                                           wa1-%offset%))))
               label90))
           label100
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (/
                     (- (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                        sum)
                     (f2cl-lib:fref r-%data% (j j) ((1 ldr) (1 n))
                                    r-%offset%)))
           label110))
        (setf temp (enorm n wa1))
        (setf parl (/ (/ (/ fp delta) temp) temp))
       label120
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf sum zero)
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i j) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (*
                            (f2cl-lib:fref r-%data% (i j) ((1 ldr) (1 n))
                                           r-%offset%)
                            (f2cl-lib:fref qtb-%data% (i) ((1 n))
                                           qtb-%offset%))))
               label130))
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (/ sum
                       (f2cl-lib:fref diag-%data% (l) ((1 n)) diag-%offset%)))
           label140))
        (setf gnorm (enorm n wa1))
        (setf paru (/ gnorm delta))
        (if (= paru zero)
            (setf paru (/ dwarf (f2cl-lib:dmin1 delta p1))))
        (setf par (f2cl-lib:dmax1 par parl))
        (setf par (f2cl-lib:dmin1 par paru))
        (if (= par zero)
            (setf par (/ gnorm dxnorm)))
       label150
        (setf iter (f2cl-lib:int-add iter 1))
        (if (= par zero)
            (setf par (f2cl-lib:dmax1 dwarf (* p001 paru))))
        (setf temp (f2cl-lib:dsqrt par))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (* temp
                       (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)))
           label160))
        (qrsolv n r ldr ipvt wa1 qtb x sdiag wa2)
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                    (* (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                       (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)))
           label170))
        (setf dxnorm (enorm n wa2))
        (setf temp fp)
        (setf fp (- dxnorm delta))
        (if (or (<= (f2cl-lib:dabs fp) (* p1 delta))
                (and (= parl zero) (<= fp temp) (< temp zero)) (= iter 10))
            (go label220))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (* (f2cl-lib:fref diag-%data% (l) ((1 n)) diag-%offset%)
                       (/ (f2cl-lib:fref wa2-%data% (l) ((1 n)) wa2-%offset%)
                          dxnorm)))
           label180))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (/ (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                       (f2cl-lib:fref sdiag-%data% (j) ((1 n))
                                      sdiag-%offset%)))
            (setf temp (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%))
            (setf jp1 (f2cl-lib:int-add j 1))
            (if (< n jp1)
                (go label200))
            (f2cl-lib:fdo (i jp1 (f2cl-lib:int-add i 1))
                          ((> i n) nil)
              (tagbody
                (setf (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                        (- (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                           (*
                            (f2cl-lib:fref r-%data% (i j) ((1 ldr) (1 n))
                                           r-%offset%)
                            temp)))
               label190))
           label200
           label210))
        (setf temp (enorm n wa1))
        (setf parc (/ (/ (/ fp delta) temp) temp))
        (if (> fp zero)
            (setf parl (f2cl-lib:dmax1 parl par)))
        (if (< fp zero)
            (setf paru (f2cl-lib:dmin1 paru par)))
        (setf par (f2cl-lib:dmax1 parl (+ par parc)))
        (go label150)
       label220
        (if (= iter 0)
            (setf par zero))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil par nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::lmpar fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (double-float) (double-float)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil nil
                                              fortran-to-lisp::par nil nil nil
                                              nil)
                                            :calls
                                            '(fortran-to-lisp::qrsolv
                                              fortran-to-lisp::enorm
                                              fortran-to-lisp::dpmpar))))

