;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((one 1.0))
  (declare (type (double-float) one))
  (defun r1mpyq (m n a lda v w)
    (declare (type (array double-float (*)) w v a)
             (type (f2cl-lib:integer4) lda n m))
    (f2cl-lib:with-multi-array-data
        ((a double-float a-%data% a-%offset%)
         (v double-float v-%data% v-%offset%)
         (w double-float w-%data% w-%offset%))
      (prog ((cos 0.0) (sin 0.0) (temp 0.0) (i 0) (j 0) (nmj 0) (nm1 0))
        (declare (type (f2cl-lib:integer4) nm1 nmj j i)
                 (type (double-float) temp sin cos))
        (setf nm1 (f2cl-lib:int-sub n 1))
        (if (< nm1 1)
            (go label50))
        (f2cl-lib:fdo (nmj 1 (f2cl-lib:int-add nmj 1))
                      ((> nmj nm1) nil)
          (tagbody
            (setf j (f2cl-lib:int-sub n nmj))
            (if (>
                 (f2cl-lib:dabs
                  (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%))
                 one)
                (setf cos
                        (/ one
                           (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%))))
            (if (>
                 (f2cl-lib:dabs
                  (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%))
                 one)
                (setf sin (f2cl-lib:dsqrt (- one (expt cos 2)))))
            (if (<=
                 (f2cl-lib:dabs
                  (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%))
                 one)
                (setf sin (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%)))
            (if (<=
                 (f2cl-lib:dabs
                  (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%))
                 one)
                (setf cos (f2cl-lib:dsqrt (- one (expt sin 2)))))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf temp
                        (-
                         (* cos
                            (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                           a-%offset%))
                         (* sin
                            (f2cl-lib:fref a-%data% (i n) ((1 lda) (1 n))
                                           a-%offset%))))
                (setf (f2cl-lib:fref a-%data% (i n) ((1 lda) (1 n)) a-%offset%)
                        (+
                         (* sin
                            (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                           a-%offset%))
                         (* cos
                            (f2cl-lib:fref a-%data% (i n) ((1 lda) (1 n))
                                           a-%offset%))))
                (setf (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n)) a-%offset%)
                        temp)
               label10))
           label20))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j nm1) nil)
          (tagbody
            (if (>
                 (f2cl-lib:dabs
                  (f2cl-lib:fref w-%data% (j) ((1 n)) w-%offset%))
                 one)
                (setf cos
                        (/ one
                           (f2cl-lib:fref w-%data% (j) ((1 n)) w-%offset%))))
            (if (>
                 (f2cl-lib:dabs
                  (f2cl-lib:fref w-%data% (j) ((1 n)) w-%offset%))
                 one)
                (setf sin (f2cl-lib:dsqrt (- one (expt cos 2)))))
            (if (<=
                 (f2cl-lib:dabs
                  (f2cl-lib:fref w-%data% (j) ((1 n)) w-%offset%))
                 one)
                (setf sin (f2cl-lib:fref w-%data% (j) ((1 n)) w-%offset%)))
            (if (<=
                 (f2cl-lib:dabs
                  (f2cl-lib:fref w-%data% (j) ((1 n)) w-%offset%))
                 one)
                (setf cos (f2cl-lib:dsqrt (- one (expt sin 2)))))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf temp
                        (+
                         (* cos
                            (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                           a-%offset%))
                         (* sin
                            (f2cl-lib:fref a-%data% (i n) ((1 lda) (1 n))
                                           a-%offset%))))
                (setf (f2cl-lib:fref a-%data% (i n) ((1 lda) (1 n)) a-%offset%)
                        (+
                         (* (- sin)
                            (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n))
                                           a-%offset%))
                         (* cos
                            (f2cl-lib:fref a-%data% (i n) ((1 lda) (1 n))
                                           a-%offset%))))
                (setf (f2cl-lib:fref a-%data% (i j) ((1 lda) (1 n)) a-%offset%)
                        temp)
               label30))
           label40))
       label50
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::r1mpyq
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil) :calls
                                            'nil)))

