;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((one 1.0) (zero 0.0))
  (declare (type (double-float) one zero))
  (defun dogleg (n r lr diag qtb delta x wa1 wa2)
    (declare (type (double-float) delta)
             (type (array double-float (*)) wa2 wa1 x qtb diag r)
             (type (f2cl-lib:integer4) lr n))
    (f2cl-lib:with-multi-array-data
        ((r double-float r-%data% r-%offset%)
         (diag double-float diag-%data% diag-%offset%)
         (qtb double-float qtb-%data% qtb-%offset%)
         (x double-float x-%data% x-%offset%)
         (wa1 double-float wa1-%data% wa1-%offset%)
         (wa2 double-float wa2-%data% wa2-%offset%))
      (prog ((alpha 0.0) (bnorm 0.0) (epsmch 0.0) (gnorm 0.0) (qnorm 0.0)
             (sgnorm 0.0) (sum 0.0) (temp 0.0) (i 0) (j 0) (jj 0) (jp1 0) (k 0)
             (l 0))
        (declare (type (f2cl-lib:integer4) l k jp1 jj j i)
                 (type (double-float) temp sum sgnorm qnorm gnorm epsmch bnorm
                  alpha))
        (setf epsmch (dpmpar 1))
        (setf jj (+ (the f2cl-lib:integer4 (truncate (* n (+ n 1)) 2)) 1))
        (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                      ((> k n) nil)
          (tagbody
            (setf j (f2cl-lib:int-add (f2cl-lib:int-sub n k) 1))
            (setf jp1 (f2cl-lib:int-add j 1))
            (setf jj (f2cl-lib:int-sub jj k))
            (setf l (f2cl-lib:int-add jj 1))
            (setf sum zero)
            (if (< n jp1)
                (go label20))
            (f2cl-lib:fdo (i jp1 (f2cl-lib:int-add i 1))
                          ((> i n) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (* (f2cl-lib:fref r-%data% (l) ((1 lr)) r-%offset%)
                              (f2cl-lib:fref x-%data% (i) ((1 n))
                                             x-%offset%))))
                (setf l (f2cl-lib:int-add l 1))
               label10))
           label20
            (setf temp (f2cl-lib:fref r-%data% (jj) ((1 lr)) r-%offset%))
            (if (/= temp zero)
                (go label40))
            (setf l j)
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i j) nil)
              (tagbody
                (setf temp
                        (f2cl-lib:dmax1 temp
                                        (f2cl-lib:dabs
                                         (f2cl-lib:fref r-%data% (l) ((1 lr))
                                                        r-%offset%))))
                (setf l (f2cl-lib:int-sub (f2cl-lib:int-add l n) i))
               label30))
            (setf temp (* epsmch temp))
            (if (= temp zero)
                (setf temp epsmch))
           label40
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                    (/
                     (- (f2cl-lib:fref qtb-%data% (j) ((1 n)) qtb-%offset%)
                        sum)
                     temp))
           label50))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%) zero)
            (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                    (* (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                       (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)))
           label60))
        (setf qnorm (enorm n wa2))
        (if (<= qnorm delta)
            (go label140))
        (setf l 1)
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf temp (f2cl-lib:fref qtb-%data% (j) ((1 n)) qtb-%offset%))
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i n) nil)
              (tagbody
                (setf (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                        (+ (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                           (* (f2cl-lib:fref r-%data% (l) ((1 lr)) r-%offset%)
                              temp)))
                (setf l (f2cl-lib:int-add l 1))
               label70))
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (/ (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                       (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)))
           label80))
        (setf gnorm (enorm n wa1))
        (setf sgnorm zero)
        (setf alpha (/ delta qnorm))
        (if (= gnorm zero)
            (go label120))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (/
                     (/ (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                        gnorm)
                     (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)))
           label90))
        (setf l 1)
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf sum zero)
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i n) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (* (f2cl-lib:fref r-%data% (l) ((1 lr)) r-%offset%)
                              (f2cl-lib:fref wa1-%data% (i) ((1 n))
                                             wa1-%offset%))))
                (setf l (f2cl-lib:int-add l 1))
               label100))
            (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%) sum)
           label110))
        (setf temp (enorm n wa2))
        (setf sgnorm (/ (/ gnorm temp) temp))
        (setf alpha zero)
        (if (>= sgnorm delta)
            (go label120))
        (setf bnorm (enorm n qtb))
        (setf temp (* (/ bnorm gnorm) (/ bnorm qnorm) (/ sgnorm delta)))
        (setf temp
                (+ (- temp (* (/ delta qnorm) (expt (/ sgnorm delta) 2)))
                   (f2cl-lib:dsqrt
                    (+ (expt (- temp (/ delta qnorm)) 2)
                       (* (- one (expt (/ delta qnorm) 2))
                          (- one (expt (/ sgnorm delta) 2)))))))
        (setf alpha
                (/ (* (/ delta qnorm) (- one (expt (/ sgnorm delta) 2))) temp))
       label120
        (setf temp (* (- one alpha) (f2cl-lib:dmin1 sgnorm delta)))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                    (+
                     (* temp
                        (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%))
                     (* alpha
                        (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%))))
           label130))
       label140
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dogleg
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (double-float)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil nil nil
                                              nil)
                                            :calls
                                            '(fortran-to-lisp::enorm
                                              fortran-to-lisp::dpmpar))))

