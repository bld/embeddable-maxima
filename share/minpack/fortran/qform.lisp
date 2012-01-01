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
  (defun qform (m n q ldq wa)
    (declare (type (array double-float (*)) wa q)
             (type (f2cl-lib:integer4) ldq n m))
    (f2cl-lib:with-multi-array-data
        ((q double-float q-%data% q-%offset%)
         (wa double-float wa-%data% wa-%offset%))
      (prog ((sum 0.0) (temp 0.0) (i 0) (j 0) (jm1 0) (k 0) (l 0) (minmn 0)
             (np1 0))
        (declare (type (f2cl-lib:integer4) np1 minmn l k jm1 j i)
                 (type (double-float) temp sum))
        (setf minmn (f2cl-lib:min0 m n))
        (if (< minmn 2)
            (go label30))
        (f2cl-lib:fdo (j 2 (f2cl-lib:int-add j 1))
                      ((> j minmn) nil)
          (tagbody
            (setf jm1 (f2cl-lib:int-sub j 1))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i jm1) nil)
              (tagbody
                (setf (f2cl-lib:fref q-%data% (i j) ((1 ldq) (1 m)) q-%offset%)
                        zero)
               label10))
           label20))
       label30
        (setf np1 (f2cl-lib:int-add n 1))
        (if (< m np1)
            (go label60))
        (f2cl-lib:fdo (j np1 (f2cl-lib:int-add j 1))
                      ((> j m) nil)
          (tagbody
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref q-%data% (i j) ((1 ldq) (1 m)) q-%offset%)
                        zero)
               label40))
            (setf (f2cl-lib:fref q-%data% (j j) ((1 ldq) (1 m)) q-%offset%)
                    one)
           label50))
       label60
        (f2cl-lib:fdo (l 1 (f2cl-lib:int-add l 1))
                      ((> l minmn) nil)
          (tagbody
            (setf k (f2cl-lib:int-add (f2cl-lib:int-sub minmn l) 1))
            (f2cl-lib:fdo (i k (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref wa-%data% (i) ((1 m)) wa-%offset%)
                        (f2cl-lib:fref q-%data% (i k) ((1 ldq) (1 m))
                                       q-%offset%))
                (setf (f2cl-lib:fref q-%data% (i k) ((1 ldq) (1 m)) q-%offset%)
                        zero)
               label70))
            (setf (f2cl-lib:fref q-%data% (k k) ((1 ldq) (1 m)) q-%offset%)
                    one)
            (if (= (f2cl-lib:fref wa-%data% (k) ((1 m)) wa-%offset%) zero)
                (go label110))
            (f2cl-lib:fdo (j k (f2cl-lib:int-add j 1))
                          ((> j m) nil)
              (tagbody
                (setf sum zero)
                (f2cl-lib:fdo (i k (f2cl-lib:int-add i 1))
                              ((> i m) nil)
                  (tagbody
                    (setf sum
                            (+ sum
                               (*
                                (f2cl-lib:fref q-%data% (i j) ((1 ldq) (1 m))
                                               q-%offset%)
                                (f2cl-lib:fref wa-%data% (i) ((1 m))
                                               wa-%offset%))))
                   label80))
                (setf temp
                        (/ sum
                           (f2cl-lib:fref wa-%data% (k) ((1 m)) wa-%offset%)))
                (f2cl-lib:fdo (i k (f2cl-lib:int-add i 1))
                              ((> i m) nil)
                  (tagbody
                    (setf (f2cl-lib:fref q-%data% (i j) ((1 ldq) (1 m))
                                         q-%offset%)
                            (-
                             (f2cl-lib:fref q-%data% (i j) ((1 ldq) (1 m))
                                            q-%offset%)
                             (* temp
                                (f2cl-lib:fref wa-%data% (i) ((1 m))
                                               wa-%offset%))))
                   label90))
               label100))
           label110
           label120))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::qform fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil) :calls
                                            'nil)))

