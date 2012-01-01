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
  (defun fdjac2 (fcn m n x fvec fjac ldfjac iflag epsfcn wa)
    (declare (type (double-float) epsfcn)
             (type (array double-float (*)) wa fjac fvec x)
             (type (f2cl-lib:integer4) iflag ldfjac n m))
    (f2cl-lib:with-multi-array-data
        ((x double-float x-%data% x-%offset%)
         (fvec double-float fvec-%data% fvec-%offset%)
         (fjac double-float fjac-%data% fjac-%offset%)
         (wa double-float wa-%data% wa-%offset%))
      (prog ((eps 0.0) (epsmch 0.0) (h 0.0) (temp 0.0) (i 0) (j 0))
        (declare (type (f2cl-lib:integer4) j i)
                 (type (double-float) temp h epsmch eps))
        (setf epsmch (dpmpar 1))
        (setf eps (f2cl-lib:dsqrt (f2cl-lib:dmax1 epsfcn epsmch)))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf temp (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%))
            (setf h (* eps (f2cl-lib:dabs temp)))
            (if (= h zero)
                (setf h eps))
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%) (+ temp h))
            (multiple-value-bind (var-0 var-1 var-2 var-3 var-4)
                (funcall fcn m n x wa iflag)
              (declare (ignore var-2 var-3))
              (when var-0 (setf m var-0))
              (when var-1 (setf n var-1))
              (when var-4 (setf iflag var-4)))
            (if (< iflag 0)
                (go label30))
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%) temp)
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                     fjac-%offset%)
                        (/
                         (- (f2cl-lib:fref wa-%data% (i) ((1 m)) wa-%offset%)
                            (f2cl-lib:fref fvec-%data% (i) ((1 m))
                                           fvec-%offset%))
                         h))
               label10))
           label20))
       label30
        (go end_label)
       end_label
        (return (values nil m n nil nil nil nil iflag nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::fdjac2
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (double-float)
                                              (array double-float (*)))
                                            :return-values
                                            '(nil fortran-to-lisp::m
                                              fortran-to-lisp::n nil nil nil
                                              nil fortran-to-lisp::iflag nil
                                              nil)
                                            :calls '(fortran-to-lisp::dpmpar))))

