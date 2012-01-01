;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((zero 0.0))
  (declare (type (double-float) zero))
  (defun fdjac1 (fcn n x fvec fjac ldfjac iflag ml mu epsfcn wa1 wa2)
    (declare (type (double-float) epsfcn)
             (type (array double-float (*)) wa2 wa1 fjac fvec x)
             (type (f2cl-lib:integer4) mu ml iflag ldfjac n))
    (f2cl-lib:with-multi-array-data
        ((x double-float x-%data% x-%offset%)
         (fvec double-float fvec-%data% fvec-%offset%)
         (fjac double-float fjac-%data% fjac-%offset%)
         (wa1 double-float wa1-%data% wa1-%offset%)
         (wa2 double-float wa2-%data% wa2-%offset%))
      (prog ((eps 0.0) (epsmch 0.0) (h 0.0) (temp 0.0) (i 0) (j 0) (k 0)
             (msum 0))
        (declare (type (f2cl-lib:integer4) msum k j i)
                 (type (double-float) temp h epsmch eps))
        (setf epsmch (dpmpar 1))
        (setf eps (f2cl-lib:dsqrt (f2cl-lib:dmax1 epsfcn epsmch)))
        (setf msum (f2cl-lib:int-add ml mu 1))
        (if (< msum n)
            (go label40))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf temp (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%))
            (setf h (* eps (f2cl-lib:dabs temp)))
            (if (= h zero)
                (setf h eps))
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%) (+ temp h))
            (multiple-value-bind (var-0 var-1 var-2 var-3)
                (funcall fcn n x wa1 iflag)
              (declare (ignore var-1 var-2))
              (when var-0 (setf n var-0))
              (when var-3 (setf iflag var-3)))
            (if (< iflag 0)
                (go label30))
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%) temp)
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i n) nil)
              (tagbody
                (setf (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                     fjac-%offset%)
                        (/
                         (- (f2cl-lib:fref wa1-%data% (i) ((1 n)) wa1-%offset%)
                            (f2cl-lib:fref fvec-%data% (i) ((1 n))
                                           fvec-%offset%))
                         h))
               label10))
           label20))
       label30
        (go label110)
       label40
        (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                      ((> k msum) nil)
          (tagbody
            (f2cl-lib:fdo (j k (f2cl-lib:int-add j msum))
                          ((> j n) nil)
              (tagbody
                (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                        (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%))
                (setf h
                        (* eps
                           (f2cl-lib:dabs
                            (f2cl-lib:fref wa2-%data% (j) ((1 n))
                                           wa2-%offset%))))
                (if (= h zero)
                    (setf h eps))
                (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                        (+ (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                           h))
               label60))
            (multiple-value-bind (var-0 var-1 var-2 var-3)
                (funcall fcn n x wa1 iflag)
              (declare (ignore var-1 var-2))
              (when var-0 (setf n var-0))
              (when var-3 (setf iflag var-3)))
            (if (< iflag 0)
                (go label100))
            (f2cl-lib:fdo (j k (f2cl-lib:int-add j msum))
                          ((> j n) nil)
              (tagbody
                (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                        (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%))
                (setf h
                        (* eps
                           (f2cl-lib:dabs
                            (f2cl-lib:fref wa2-%data% (j) ((1 n))
                                           wa2-%offset%))))
                (if (= h zero)
                    (setf h eps))
                (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                              ((> i n) nil)
                  (tagbody
                    (setf (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                         fjac-%offset%)
                            zero)
                    (if (and (>= i (f2cl-lib:int-sub j mu))
                             (<= i (f2cl-lib:int-add j ml)))
                        (setf (f2cl-lib:fref fjac-%data% (i j)
                                             ((1 ldfjac) (1 n)) fjac-%offset%)
                                (/
                                 (-
                                  (f2cl-lib:fref wa1-%data% (i) ((1 n))
                                                 wa1-%offset%)
                                  (f2cl-lib:fref fvec-%data% (i) ((1 n))
                                                 fvec-%offset%))
                                 h)))
                   label70))
               label80))
           label90))
       label100
       label110
        (go end_label)
       end_label
        (return (values nil n nil nil nil nil iflag nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::fdjac1
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (double-float)
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil fortran-to-lisp::n nil nil
                                              nil nil fortran-to-lisp::iflag
                                              nil nil nil nil nil)
                                            :calls '(fortran-to-lisp::dpmpar))))

