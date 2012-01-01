;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "COLNEW")


(defun vmonde (rho coef k)
  (declare (type (f2cl-lib:integer4) k)
           (type (array double-float (*)) coef rho))
  (f2cl-lib:with-multi-array-data
      ((rho double-float rho-%data% rho-%offset%)
       (coef double-float coef-%data% coef-%offset%))
    (prog ((i 0) (ifac 0) (j 0) (km1 0) (kmi 0))
      (declare (type (f2cl-lib:integer4) kmi km1 j ifac i))
      (if (= k 1)
          (go end_label))
      (setf km1 (f2cl-lib:int-sub k 1))
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i km1) nil)
        (tagbody
          (setf kmi (f2cl-lib:int-sub k i))
          (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                        ((> j kmi) nil)
            (tagbody
              (setf (f2cl-lib:fref coef-%data% (j) ((1 k)) coef-%offset%)
                      (/
                       (-
                        (f2cl-lib:fref coef-%data% ((f2cl-lib:int-add j 1))
                                       ((1 k)) coef-%offset%)
                        (f2cl-lib:fref coef-%data% (j) ((1 k)) coef-%offset%))
                       (-
                        (f2cl-lib:fref rho-%data% ((f2cl-lib:int-add j i))
                                       ((1 k)) rho-%offset%)
                        (f2cl-lib:fref rho-%data% (j) ((1 k)) rho-%offset%))))
             label10))))
     label10
      (setf ifac 1)
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i km1) nil)
        (tagbody
          (setf kmi (f2cl-lib:int-sub (f2cl-lib:int-add k 1) i))
          (f2cl-lib:fdo (j 2 (f2cl-lib:int-add j 1))
                        ((> j kmi) nil)
            (tagbody
             label30
              (setf (f2cl-lib:fref coef-%data% (j) ((1 k)) coef-%offset%)
                      (- (f2cl-lib:fref coef-%data% (j) ((1 k)) coef-%offset%)
                         (*
                          (f2cl-lib:fref rho-%data%
                                         ((f2cl-lib:int-sub
                                           (f2cl-lib:int-add j i) 1))
                                         ((1 k)) rho-%offset%)
                          (f2cl-lib:fref coef-%data% ((f2cl-lib:int-sub j 1))
                                         ((1 k)) coef-%offset%))))))
          (setf (f2cl-lib:fref coef-%data% (kmi) ((1 k)) coef-%offset%)
                  (* (f2cl-lib:dfloat ifac)
                     (f2cl-lib:fref coef-%data% (kmi) ((1 k)) coef-%offset%)))
          (setf ifac (f2cl-lib:int-mul ifac i))
         label40))
      (setf (f2cl-lib:fref coef-%data% (1) ((1 k)) coef-%offset%)
              (* (f2cl-lib:dfloat ifac)
                 (f2cl-lib:fref coef-%data% (1) ((1 k)) coef-%offset%)))
      (go end_label)
     end_label
      (return (values nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::vmonde
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((array double-float (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4))
                                            :return-values '(nil nil nil)
                                            :calls 'nil)))

