;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(defun zrot (n cx incx cy incy c s)
  (declare (type (f2cl-lib:complex16) s)
           (type (double-float) c)
           (type (array f2cl-lib:complex16 (*)) cy cx)
           (type (f2cl-lib:integer4) incy incx n))
  (f2cl-lib:with-multi-array-data
      ((cx f2cl-lib:complex16 cx-%data% cx-%offset%)
       (cy f2cl-lib:complex16 cy-%data% cy-%offset%))
    (prog ((stemp #C(0.0 0.0)) (i 0) (ix 0) (iy 0))
      (declare (type (f2cl-lib:integer4) iy ix i)
               (type (f2cl-lib:complex16) stemp))
      (if (<= n 0)
          (go end_label))
      (if (and (= incx 1) (= incy 1))
          (go label20))
      (setf ix 1)
      (setf iy 1)
      (if (< incx 0)
          (setf ix
                  (f2cl-lib:int-add
                   (f2cl-lib:int-mul (f2cl-lib:int-sub 1 n) incx) 1)))
      (if (< incy 0)
          (setf iy
                  (f2cl-lib:int-add
                   (f2cl-lib:int-mul (f2cl-lib:int-sub 1 n) incy) 1)))
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i n) nil)
        (tagbody
          (setf stemp
                  (+ (* c (f2cl-lib:fref cx-%data% (ix) ((1 *)) cx-%offset%))
                     (* s (f2cl-lib:fref cy-%data% (iy) ((1 *)) cy-%offset%))))
          (setf (f2cl-lib:fref cy-%data% (iy) ((1 *)) cy-%offset%)
                  (- (* c (f2cl-lib:fref cy-%data% (iy) ((1 *)) cy-%offset%))
                     (* (f2cl-lib:dconjg s)
                        (f2cl-lib:fref cx-%data% (ix) ((1 *)) cx-%offset%))))
          (setf (f2cl-lib:fref cx-%data% (ix) ((1 *)) cx-%offset%) stemp)
          (setf ix (f2cl-lib:int-add ix incx))
          (setf iy (f2cl-lib:int-add iy incy))
         label10))
      (go end_label)
     label20
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i n) nil)
        (tagbody
          (setf stemp
                  (+ (* c (f2cl-lib:fref cx-%data% (i) ((1 *)) cx-%offset%))
                     (* s (f2cl-lib:fref cy-%data% (i) ((1 *)) cy-%offset%))))
          (setf (f2cl-lib:fref cy-%data% (i) ((1 *)) cy-%offset%)
                  (- (* c (f2cl-lib:fref cy-%data% (i) ((1 *)) cy-%offset%))
                     (* (f2cl-lib:dconjg s)
                        (f2cl-lib:fref cx-%data% (i) ((1 *)) cx-%offset%))))
          (setf (f2cl-lib:fref cx-%data% (i) ((1 *)) cx-%offset%) stemp)
         label30))
      (go end_label)
     end_label
      (return (values nil nil nil nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zrot fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (double-float)
                                              (fortran-to-lisp::complex16))
                                            :return-values
                                            '(nil nil nil nil nil nil nil)
                                            :calls 'nil)))

