;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((one 1.0) (p5 0.5) (p25 0.25) (zero 0.0))
  (declare (type (double-float) one p5 p25 zero))
  (defun r1updt (m n s ls u v w sing)
    (declare (type f2cl-lib:logical sing)
             (type (array double-float (*)) w v u s)
             (type (f2cl-lib:integer4) ls n m))
    (f2cl-lib:with-multi-array-data
        ((s double-float s-%data% s-%offset%)
         (u double-float u-%data% u-%offset%)
         (v double-float v-%data% v-%offset%)
         (w double-float w-%data% w-%offset%))
      (prog ((cos 0.0) (cotan 0.0) (giant 0.0) (sin 0.0) (tan 0.0) (tau 0.0)
             (temp 0.0) (i 0) (j 0) (jj 0) (l 0) (nmj 0) (nm1 0))
        (declare (type (f2cl-lib:integer4) nm1 nmj l jj j i)
                 (type (double-float) temp tau tan sin giant cotan cos))
        (setf giant (dpmpar 3))
        (setf jj
                (-
                 (the f2cl-lib:integer4 (truncate (* n (+ (- (* 2 m) n) 1)) 2))
                 (f2cl-lib:int-sub m n)))
        (setf l jj)
        (f2cl-lib:fdo (i n (f2cl-lib:int-add i 1))
                      ((> i m) nil)
          (tagbody
            (setf (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%)
                    (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%))
            (setf l (f2cl-lib:int-add l 1))
           label10))
        (setf nm1 (f2cl-lib:int-sub n 1))
        (if (< nm1 1)
            (go label70))
        (f2cl-lib:fdo (nmj 1 (f2cl-lib:int-add nmj 1))
                      ((> nmj nm1) nil)
          (tagbody
            (setf j (f2cl-lib:int-sub n nmj))
            (setf jj
                    (f2cl-lib:int-sub jj
                                      (f2cl-lib:int-add (f2cl-lib:int-sub m j)
                                                        1)))
            (setf (f2cl-lib:fref w-%data% (j) ((1 m)) w-%offset%) zero)
            (if (= (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%) zero)
                (go label50))
            (if (>=
                 (f2cl-lib:dabs
                  (f2cl-lib:fref v-%data% (n) ((1 n)) v-%offset%))
                 (f2cl-lib:dabs
                  (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%)))
                (go label20))
            (setf cotan
                    (/ (f2cl-lib:fref v-%data% (n) ((1 n)) v-%offset%)
                       (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%)))
            (setf sin (/ p5 (f2cl-lib:dsqrt (+ p25 (* p25 (expt cotan 2))))))
            (setf cos (* sin cotan))
            (setf tau one)
            (if (> (* (f2cl-lib:dabs cos) giant) one)
                (setf tau (/ one cos)))
            (go label30)
           label20
            (setf tan
                    (/ (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%)
                       (f2cl-lib:fref v-%data% (n) ((1 n)) v-%offset%)))
            (setf cos (/ p5 (f2cl-lib:dsqrt (+ p25 (* p25 (expt tan 2))))))
            (setf sin (* cos tan))
            (setf tau sin)
           label30
            (setf (f2cl-lib:fref v-%data% (n) ((1 n)) v-%offset%)
                    (+ (* sin (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%))
                       (* cos
                          (f2cl-lib:fref v-%data% (n) ((1 n)) v-%offset%))))
            (setf (f2cl-lib:fref v-%data% (j) ((1 n)) v-%offset%) tau)
            (setf l jj)
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf temp
                        (-
                         (* cos
                            (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%))
                         (* sin
                            (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%))))
                (setf (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%)
                        (+
                         (* sin
                            (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%))
                         (* cos
                            (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%))))
                (setf (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%) temp)
                (setf l (f2cl-lib:int-add l 1))
               label40))
           label50
           label60))
       label70
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i m) nil)
          (tagbody
            (setf (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%)
                    (+ (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%)
                       (* (f2cl-lib:fref v-%data% (n) ((1 n)) v-%offset%)
                          (f2cl-lib:fref u-%data% (i) ((1 m)) u-%offset%))))
           label80))
        (setf sing f2cl-lib:%false%)
        (if (< nm1 1)
            (go label140))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j nm1) nil)
          (tagbody
            (if (= (f2cl-lib:fref w-%data% (j) ((1 m)) w-%offset%) zero)
                (go label120))
            (if (>=
                 (f2cl-lib:dabs
                  (f2cl-lib:fref s-%data% (jj) ((1 ls)) s-%offset%))
                 (f2cl-lib:dabs
                  (f2cl-lib:fref w-%data% (j) ((1 m)) w-%offset%)))
                (go label90))
            (setf cotan
                    (/ (f2cl-lib:fref s-%data% (jj) ((1 ls)) s-%offset%)
                       (f2cl-lib:fref w-%data% (j) ((1 m)) w-%offset%)))
            (setf sin (/ p5 (f2cl-lib:dsqrt (+ p25 (* p25 (expt cotan 2))))))
            (setf cos (* sin cotan))
            (setf tau one)
            (if (> (* (f2cl-lib:dabs cos) giant) one)
                (setf tau (/ one cos)))
            (go label100)
           label90
            (setf tan
                    (/ (f2cl-lib:fref w-%data% (j) ((1 m)) w-%offset%)
                       (f2cl-lib:fref s-%data% (jj) ((1 ls)) s-%offset%)))
            (setf cos (/ p5 (f2cl-lib:dsqrt (+ p25 (* p25 (expt tan 2))))))
            (setf sin (* cos tan))
            (setf tau sin)
           label100
            (setf l jj)
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf temp
                        (+
                         (* cos
                            (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%))
                         (* sin
                            (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%))))
                (setf (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%)
                        (+
                         (* (- sin)
                            (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%))
                         (* cos
                            (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%))))
                (setf (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%) temp)
                (setf l (f2cl-lib:int-add l 1))
               label110))
            (setf (f2cl-lib:fref w-%data% (j) ((1 m)) w-%offset%) tau)
           label120
            (if (= (f2cl-lib:fref s-%data% (jj) ((1 ls)) s-%offset%) zero)
                (setf sing f2cl-lib:%true%))
            (setf jj
                    (f2cl-lib:int-add jj
                                      (f2cl-lib:int-add (f2cl-lib:int-sub m j)
                                                        1)))
           label130))
       label140
        (setf l jj)
        (f2cl-lib:fdo (i n (f2cl-lib:int-add i 1))
                      ((> i m) nil)
          (tagbody
            (setf (f2cl-lib:fref s-%data% (l) ((1 ls)) s-%offset%)
                    (f2cl-lib:fref w-%data% (i) ((1 m)) w-%offset%))
            (setf l (f2cl-lib:int-add l 1))
           label150))
        (if (= (f2cl-lib:fref s-%data% (jj) ((1 ls)) s-%offset%) zero)
            (setf sing f2cl-lib:%true%))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil sing))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::r1updt
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              fortran-to-lisp::logical)
                                            :return-values
                                            '(nil nil nil nil nil nil nil
                                              fortran-to-lisp::sing)
                                            :calls '(fortran-to-lisp::dpmpar))))

