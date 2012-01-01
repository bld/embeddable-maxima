;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "COLNEW")


(defun skale (n mstar kd z xi scale dscale)
  (declare (type (array double-float (*)) xi)
           (type (array double-float (*)) dscale scale z)
           (type (f2cl-lib:integer4) kd mstar n))
  (let ((colord-m
         (make-array 20 :element-type 'f2cl-lib:integer4 :displaced-to
                     (colord-part-0 *colord-common-block*)
                     :displaced-index-offset 5)))
    (symbol-macrolet ((ncomp (aref (colord-part-0 *colord-common-block*) 1))
                      (mmax (aref (colord-part-0 *colord-common-block*) 4))
                      (m colord-m))
      (f2cl-lib:with-multi-array-data
          ((z double-float z-%data% z-%offset%)
           (scale double-float scale-%data% scale-%offset%)
           (dscale double-float dscale-%data% dscale-%offset%)
           (xi double-float xi-%data% xi-%offset%))
        (prog ((np1 0) (idmz 0) (mj 0) (scal 0.0) (icomp 0) (l 0) (h 0.0)
               (iz 0) (j 0) (basm (make-array 5 :element-type 'double-float)))
          (declare (type (array double-float (5)) basm)
                   (type double-float h scal)
                   (type (f2cl-lib:integer4) j iz l icomp mj idmz np1))
          (setf (f2cl-lib:fref basm (1) ((1 5))) 1.0)
          (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                        ((> j n) nil)
            (tagbody
              (setf iz 1)
              (setf h
                      (-
                       (f2cl-lib:fref xi-%data% ((f2cl-lib:int-add j 1))
                                      ((1 1)) xi-%offset%)
                       (f2cl-lib:fref xi-%data% (j) ((1 1)) xi-%offset%)))
              (f2cl-lib:fdo (l 1 (f2cl-lib:int-add l 1))
                            ((> l mmax) nil)
                (tagbody
                  (setf (f2cl-lib:fref basm ((f2cl-lib:int-add l 1)) ((1 5)))
                          (/ (* (f2cl-lib:fref basm (l) ((1 5))) h)
                             (f2cl-lib:dfloat l)))
                 label10))
              (f2cl-lib:fdo (icomp 1 (f2cl-lib:int-add icomp 1))
                            ((> icomp ncomp) nil)
                (tagbody
                  (setf scal
                          (+
                           (*
                            (+
                             (f2cl-lib:dabs
                              (f2cl-lib:fref z-%data% (iz j) ((1 mstar) (1 1))
                                             z-%offset%))
                             (f2cl-lib:dabs
                              (f2cl-lib:fref z-%data%
                                             (iz (f2cl-lib:int-add j 1))
                                             ((1 mstar) (1 1)) z-%offset%)))
                            0.5)
                           1.0))
                  (setf mj (f2cl-lib:fref m (icomp) ((1 20))))
                  (f2cl-lib:fdo (l 1 (f2cl-lib:int-add l 1))
                                ((> l mj) nil)
                    (tagbody
                      (setf (f2cl-lib:fref scale-%data% (iz j)
                                           ((1 mstar) (1 1)) scale-%offset%)
                              (/ (f2cl-lib:fref basm (l) ((1 5))) scal))
                      (setf iz (f2cl-lib:int-add iz 1))
                     label20))
                  (setf scal
                          (/
                           (f2cl-lib:fref basm ((f2cl-lib:int-add mj 1))
                                          ((1 5)))
                           scal))
                  (f2cl-lib:fdo (idmz icomp (f2cl-lib:int-add idmz ncomp))
                                ((> idmz kd) nil)
                    (tagbody
                      (setf (f2cl-lib:fref dscale-%data% (idmz j)
                                           ((1 kd) (1 1)) dscale-%offset%)
                              scal)
                     label30))
                 label40))
             label50))
          (setf np1 (f2cl-lib:int-add n 1))
          (f2cl-lib:fdo (iz 1 (f2cl-lib:int-add iz 1))
                        ((> iz mstar) nil)
            (tagbody
              (setf (f2cl-lib:fref scale-%data% (iz np1) ((1 mstar) (1 1))
                                   scale-%offset%)
                      (f2cl-lib:fref scale-%data% (iz n) ((1 mstar) (1 1))
                                     scale-%offset%))
             label60))
          (go end_label)
         end_label
          (return (values nil nil nil nil nil nil nil)))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::skale fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil nil nil nil nil nil nil)
                                            :calls 'nil)))

