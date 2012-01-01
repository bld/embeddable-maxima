;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(let* ((zero (f2cl-lib:cmplx 0.0 0.0)) (rzero 0.0))
  (declare (type (f2cl-lib:complex16) zero)
           (type (double-float 0.0 0.0) rzero)
           (ignorable zero rzero))
  (defun zlaqr1 (n h ldh s1 s2 v)
    (declare (type (f2cl-lib:complex16) s2 s1)
             (type (array f2cl-lib:complex16 (*)) v h)
             (type (f2cl-lib:integer4) ldh n))
    (f2cl-lib:with-multi-array-data
        ((h f2cl-lib:complex16 h-%data% h-%offset%)
         (v f2cl-lib:complex16 v-%data% v-%offset%))
      (labels ((cabs1 (cdum)
                 (+ (abs (f2cl-lib:dble cdum)) (abs (f2cl-lib:dimag cdum)))))
        (declare
         (ftype (function (f2cl-lib:complex16) (values double-float &rest t))
          cabs1))
        (prog ((s 0.0) (cdum #C(0.0 0.0)) (h21s #C(0.0 0.0))
               (h31s #C(0.0 0.0)))
          (declare (type (double-float) s)
                   (type (f2cl-lib:complex16) cdum h21s h31s))
          (cond
           ((= n 2)
            (setf s
                    (+
                     (cabs1
                      (-
                       (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                      h-%offset%)
                       s2))
                     (cabs1
                      (f2cl-lib:fref h-%data% (2 1) ((1 ldh) (1 *))
                                     h-%offset%))))
            (cond
             ((= s rzero)
              (setf (f2cl-lib:fref v-%data% (1) ((1 *)) v-%offset%) zero)
              (setf (f2cl-lib:fref v-%data% (2) ((1 *)) v-%offset%) zero))
             (t
              (setf h21s
                      (/
                       (f2cl-lib:fref h-%data% (2 1) ((1 ldh) (1 *))
                                      h-%offset%)
                       s))
              (setf (f2cl-lib:fref v-%data% (1) ((1 *)) v-%offset%)
                      (+
                       (* h21s
                          (f2cl-lib:fref h-%data% (1 2) ((1 ldh) (1 *))
                                         h-%offset%))
                       (*
                        (-
                         (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                        h-%offset%)
                         s1)
                        (/
                         (-
                          (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                         h-%offset%)
                          s2)
                         s))))
              (setf (f2cl-lib:fref v-%data% (2) ((1 *)) v-%offset%)
                      (* h21s
                         (-
                          (+
                           (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                          h-%offset%)
                           (f2cl-lib:fref h-%data% (2 2) ((1 ldh) (1 *))
                                          h-%offset%))
                          s1 s2))))))
           (t
            (setf s
                    (+
                     (cabs1
                      (-
                       (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                      h-%offset%)
                       s2))
                     (cabs1
                      (f2cl-lib:fref h-%data% (2 1) ((1 ldh) (1 *))
                                     h-%offset%))
                     (cabs1
                      (f2cl-lib:fref h-%data% (3 1) ((1 ldh) (1 *))
                                     h-%offset%))))
            (cond
             ((= s zero)
              (setf (f2cl-lib:fref v-%data% (1) ((1 *)) v-%offset%) zero)
              (setf (f2cl-lib:fref v-%data% (2) ((1 *)) v-%offset%) zero)
              (setf (f2cl-lib:fref v-%data% (3) ((1 *)) v-%offset%) zero))
             (t
              (setf h21s
                      (/
                       (f2cl-lib:fref h-%data% (2 1) ((1 ldh) (1 *))
                                      h-%offset%)
                       s))
              (setf h31s
                      (/
                       (f2cl-lib:fref h-%data% (3 1) ((1 ldh) (1 *))
                                      h-%offset%)
                       s))
              (setf (f2cl-lib:fref v-%data% (1) ((1 *)) v-%offset%)
                      (+
                       (*
                        (-
                         (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                        h-%offset%)
                         s1)
                        (/
                         (-
                          (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                         h-%offset%)
                          s2)
                         s))
                       (*
                        (f2cl-lib:fref h-%data% (1 2) ((1 ldh) (1 *))
                                       h-%offset%)
                        h21s)
                       (*
                        (f2cl-lib:fref h-%data% (1 3) ((1 ldh) (1 *))
                                       h-%offset%)
                        h31s)))
              (setf (f2cl-lib:fref v-%data% (2) ((1 *)) v-%offset%)
                      (+
                       (* h21s
                          (-
                           (+
                            (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                           h-%offset%)
                            (f2cl-lib:fref h-%data% (2 2) ((1 ldh) (1 *))
                                           h-%offset%))
                           s1 s2))
                       (*
                        (f2cl-lib:fref h-%data% (2 3) ((1 ldh) (1 *))
                                       h-%offset%)
                        h31s)))
              (setf (f2cl-lib:fref v-%data% (3) ((1 *)) v-%offset%)
                      (+
                       (* h31s
                          (-
                           (+
                            (f2cl-lib:fref h-%data% (1 1) ((1 ldh) (1 *))
                                           h-%offset%)
                            (f2cl-lib:fref h-%data% (3 3) ((1 ldh) (1 *))
                                           h-%offset%))
                           s1 s2))
                       (* h21s
                          (f2cl-lib:fref h-%data% (3 2) ((1 ldh) (1 *))
                                         h-%offset%))))))))
         end_label
          (return (values nil nil nil nil nil nil)))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zlaqr1
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::complex16
                                               (*))
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::complex16)
                                              (fortran-to-lisp::complex16)
                                              (array fortran-to-lisp::complex16
                                               (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil) :calls
                                            'nil)))

