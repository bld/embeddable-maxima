;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "COLNEW")


(defun dmzsol (kd mstar n v z dmz)
  (declare (type (array double-float (*)) z)
           (type (array double-float (*)) dmz v)
           (type (f2cl-lib:integer4) n mstar kd))
  (f2cl-lib:with-multi-array-data
      ((v double-float v-%data% v-%offset%)
       (dmz double-float dmz-%data% dmz-%offset%)
       (z double-float z-%data% z-%offset%))
    (prog ((l 0) (fact 0.0) (j 0) (i 0) (jz 0))
      (declare (type double-float fact)
               (type (f2cl-lib:integer4) jz i j l))
      (setf jz 1)
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i n) nil)
        (tagbody
          (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                        ((> j mstar) nil)
            (tagbody
              (setf fact (f2cl-lib:fref z-%data% (jz) ((1 1)) z-%offset%))
              (f2cl-lib:fdo (l 1 (f2cl-lib:int-add l 1))
                            ((> l kd) nil)
                (tagbody
                  (setf (f2cl-lib:fref dmz-%data% (l i) ((1 kd) (1 1))
                                       dmz-%offset%)
                          (+
                           (f2cl-lib:fref dmz-%data% (l i) ((1 kd) (1 1))
                                          dmz-%offset%)
                           (* fact
                              (f2cl-lib:fref v-%data% (l jz) ((1 kd) (1 1))
                                             v-%offset%))))
                 label10))
              (setf jz (f2cl-lib:int-add jz 1))
             label20))
         label30))
      (go end_label)
     end_label
      (return (values nil nil nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dmzsol
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil) :calls
                                            'nil)))

