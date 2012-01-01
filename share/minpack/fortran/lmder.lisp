;;; Compiled by f2cl version:
;;; ("" "" "" "" "" "" "")

;;; Using Lisp SBCL 1.0.54
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls nil)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "MINPACK")


(let ((one 1.0)
      (p1 0.1)
      (p5 0.5)
      (p25 0.25)
      (p75 0.75)
      (p0001 1.e-4)
      (zero 0.0))
  (declare (type (double-float) one p1 p5 p25 p75 p0001 zero))
  (defun lmder
         (fcn m n x fvec fjac ldfjac ftol xtol gtol maxfev diag mode factor
          nprint info nfev njev ipvt qtf wa1 wa2 wa3 wa4)
    (declare (type (array f2cl-lib:integer4 (*)) ipvt)
             (type (double-float) factor gtol xtol ftol)
             (type (array double-float (*)) wa4 wa3 wa2 wa1 qtf diag fjac fvec
              x)
             (type (f2cl-lib:integer4) njev nfev info nprint mode maxfev ldfjac
              n m))
    (f2cl-lib:with-multi-array-data
        ((x double-float x-%data% x-%offset%)
         (fvec double-float fvec-%data% fvec-%offset%)
         (fjac double-float fjac-%data% fjac-%offset%)
         (diag double-float diag-%data% diag-%offset%)
         (qtf double-float qtf-%data% qtf-%offset%)
         (wa1 double-float wa1-%data% wa1-%offset%)
         (wa2 double-float wa2-%data% wa2-%offset%)
         (wa3 double-float wa3-%data% wa3-%offset%)
         (wa4 double-float wa4-%data% wa4-%offset%)
         (ipvt f2cl-lib:integer4 ipvt-%data% ipvt-%offset%))
      (prog ((actred 0.0) (delta 0.0) (dirder 0.0) (epsmch 0.0) (fnorm 0.0)
             (fnorm1 0.0) (gnorm 0.0) (par 0.0) (pnorm 0.0) (prered 0.0)
             (ratio 0.0) (sum 0.0) (temp 0.0) (temp1 0.0) (temp2 0.0)
             (xnorm 0.0) (i 0) (iflag 0) (iter 0) (j 0) (l 0))
        (declare (type (f2cl-lib:integer4) l j iter iflag i)
                 (type (double-float) xnorm temp2 temp1 temp sum ratio prered
                  pnorm par gnorm fnorm1 fnorm epsmch dirder delta actred))
        (setf epsmch (dpmpar 1))
        (setf info 0)
        (setf iflag 0)
        (setf nfev 0)
        (setf njev 0)
        (if (or (<= n 0) (< m n) (< ldfjac m) (< ftol zero) (< xtol zero)
                (< gtol zero) (<= maxfev 0) (<= factor zero))
            (go label300))
        (if (/= mode 2)
            (go label20))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (if (<= (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%) zero)
                (go label300))
           label10))
       label20
        (setf iflag 1)
        (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
            (funcall fcn m n x fvec fjac ldfjac iflag)
          (declare (ignore var-2 var-3 var-4))
          (when var-0 (setf m var-0))
          (when var-1 (setf n var-1))
          (when var-5 (setf ldfjac var-5))
          (when var-6 (setf iflag var-6)))
        (setf nfev 1)
        (if (< iflag 0)
            (go label300))
        (setf fnorm (enorm m fvec))
        (setf par zero)
        (setf iter 1)
       label30
        (setf iflag 2)
        (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
            (funcall fcn m n x fvec fjac ldfjac iflag)
          (declare (ignore var-2 var-3 var-4))
          (when var-0 (setf m var-0))
          (when var-1 (setf n var-1))
          (when var-5 (setf ldfjac var-5))
          (when var-6 (setf iflag var-6)))
        (setf njev (f2cl-lib:int-add njev 1))
        (if (< iflag 0)
            (go label300))
        (if (<= nprint 0)
            (go label40))
        (setf iflag 0)
        (if (= (mod (f2cl-lib:int-sub iter 1) nprint) 0)
            (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
                (funcall fcn m n x fvec fjac ldfjac iflag)
              (declare (ignore var-2 var-3 var-4))
              (when var-0 (setf m var-0))
              (when var-1 (setf n var-1))
              (when var-5 (setf ldfjac var-5))
              (when var-6 (setf iflag var-6))))
        (if (< iflag 0)
            (go label300))
       label40
        (qrfac m n fjac ldfjac f2cl-lib:%true% ipvt n wa1 wa2 wa3)
        (if (/= iter 1)
            (go label80))
        (if (= mode 2)
            (go label60))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                    (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%))
            (if (= (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%) zero)
                (setf (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                        one))
           label50))
       label60
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa3-%data% (j) ((1 n)) wa3-%offset%)
                    (* (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                       (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)))
           label70))
        (setf xnorm (enorm n wa3))
        (setf delta (* factor xnorm))
        (if (= delta zero)
            (setf delta factor))
       label80
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i m) nil)
          (tagbody
            (setf (f2cl-lib:fref wa4-%data% (i) ((1 m)) wa4-%offset%)
                    (f2cl-lib:fref fvec-%data% (i) ((1 m)) fvec-%offset%))
           label90))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (if (=
                 (f2cl-lib:fref fjac-%data% (j j) ((1 ldfjac) (1 n))
                                fjac-%offset%)
                 zero)
                (go label120))
            (setf sum zero)
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (*
                            (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                           fjac-%offset%)
                            (f2cl-lib:fref wa4-%data% (i) ((1 m))
                                           wa4-%offset%))))
               label100))
            (setf temp
                    (/ (- sum)
                       (f2cl-lib:fref fjac-%data% (j j) ((1 ldfjac) (1 n))
                                      fjac-%offset%)))
            (f2cl-lib:fdo (i j (f2cl-lib:int-add i 1))
                          ((> i m) nil)
              (tagbody
                (setf (f2cl-lib:fref wa4-%data% (i) ((1 m)) wa4-%offset%)
                        (+ (f2cl-lib:fref wa4-%data% (i) ((1 m)) wa4-%offset%)
                           (*
                            (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                           fjac-%offset%)
                            temp)))
               label110))
           label120
            (setf (f2cl-lib:fref fjac-%data% (j j) ((1 ldfjac) (1 n))
                                 fjac-%offset%)
                    (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%))
            (setf (f2cl-lib:fref qtf-%data% (j) ((1 n)) qtf-%offset%)
                    (f2cl-lib:fref wa4-%data% (j) ((1 m)) wa4-%offset%))
           label130))
        (setf gnorm zero)
        (if (= fnorm zero)
            (go label170))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (if (= (f2cl-lib:fref wa2-%data% (l) ((1 n)) wa2-%offset%) zero)
                (go label150))
            (setf sum zero)
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i j) nil)
              (tagbody
                (setf sum
                        (+ sum
                           (*
                            (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                           fjac-%offset%)
                            (/
                             (f2cl-lib:fref qtf-%data% (i) ((1 n))
                                            qtf-%offset%)
                             fnorm))))
               label140))
            (setf gnorm
                    (f2cl-lib:dmax1 gnorm
                                    (f2cl-lib:dabs
                                     (/ sum
                                        (f2cl-lib:fref wa2-%data% (l) ((1 n))
                                                       wa2-%offset%)))))
           label150
           label160))
       label170
        (if (<= gnorm gtol)
            (setf info 4))
        (if (/= info 0)
            (go label300))
        (if (= mode 2)
            (go label190))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                    (f2cl-lib:dmax1
                     (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                     (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)))
           label180))
       label190
       label200
        (multiple-value-bind
            (var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8 var-9 var-10
             var-11)
            (lmpar n fjac ldfjac ipvt diag qtf delta par wa1 wa2 wa3 wa4)
          (declare
           (ignore var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-8 var-9 var-10
            var-11))
          (setf par var-7))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)
                    (- (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)))
            (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                    (+ (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                       (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)))
            (setf (f2cl-lib:fref wa3-%data% (j) ((1 n)) wa3-%offset%)
                    (* (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                       (f2cl-lib:fref wa1-%data% (j) ((1 n)) wa1-%offset%)))
           label210))
        (setf pnorm (enorm n wa3))
        (if (= iter 1)
            (setf delta (f2cl-lib:dmin1 delta pnorm)))
        (setf iflag 1)
        (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
            (funcall fcn m n wa2 wa4 fjac ldfjac iflag)
          (declare (ignore var-2 var-3 var-4))
          (when var-0 (setf m var-0))
          (when var-1 (setf n var-1))
          (when var-5 (setf ldfjac var-5))
          (when var-6 (setf iflag var-6)))
        (setf nfev (f2cl-lib:int-add nfev 1))
        (if (< iflag 0)
            (go label300))
        (setf fnorm1 (enorm m wa4))
        (setf actred (- one))
        (if (< (* p1 fnorm1) fnorm)
            (setf actred (- one (expt (/ fnorm1 fnorm) 2))))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref wa3-%data% (j) ((1 n)) wa3-%offset%) zero)
            (setf l (f2cl-lib:fref ipvt-%data% (j) ((1 n)) ipvt-%offset%))
            (setf temp (f2cl-lib:fref wa1-%data% (l) ((1 n)) wa1-%offset%))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i j) nil)
              (tagbody
                (setf (f2cl-lib:fref wa3-%data% (i) ((1 n)) wa3-%offset%)
                        (+ (f2cl-lib:fref wa3-%data% (i) ((1 n)) wa3-%offset%)
                           (*
                            (f2cl-lib:fref fjac-%data% (i j) ((1 ldfjac) (1 n))
                                           fjac-%offset%)
                            temp)))
               label220))
           label230))
        (setf temp1 (/ (enorm n wa3) fnorm))
        (setf temp2 (/ (* (f2cl-lib:dsqrt par) pnorm) fnorm))
        (setf prered (+ (expt temp1 2) (/ (expt temp2 2) p5)))
        (setf dirder (- (+ (expt temp1 2) (expt temp2 2))))
        (setf ratio zero)
        (if (/= prered zero)
            (setf ratio (/ actred prered)))
        (if (> ratio p25)
            (go label240))
        (if (>= actred zero)
            (setf temp p5))
        (if (< actred zero)
            (setf temp (/ (* p5 dirder) (+ dirder (* p5 actred)))))
        (if (or (>= (* p1 fnorm1) fnorm) (< temp p1))
            (setf temp p1))
        (setf delta (* temp (f2cl-lib:dmin1 delta (/ pnorm p1))))
        (setf par (/ par temp))
        (go label260)
       label240
        (if (and (/= par zero) (< ratio p75))
            (go label250))
        (setf delta (/ pnorm p5))
        (setf par (* p5 par))
       label250
       label260
        (if (< ratio p0001)
            (go label290))
        (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                      ((> j n) nil)
          (tagbody
            (setf (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)
                    (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%))
            (setf (f2cl-lib:fref wa2-%data% (j) ((1 n)) wa2-%offset%)
                    (* (f2cl-lib:fref diag-%data% (j) ((1 n)) diag-%offset%)
                       (f2cl-lib:fref x-%data% (j) ((1 n)) x-%offset%)))
           label270))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i m) nil)
          (tagbody
            (setf (f2cl-lib:fref fvec-%data% (i) ((1 m)) fvec-%offset%)
                    (f2cl-lib:fref wa4-%data% (i) ((1 m)) wa4-%offset%))
           label280))
        (setf xnorm (enorm n wa2))
        (setf fnorm fnorm1)
        (setf iter (f2cl-lib:int-add iter 1))
       label290
        (if (and (<= (f2cl-lib:dabs actred) ftol) (<= prered ftol)
                 (<= (* p5 ratio) one))
            (setf info 1))
        (if (<= delta (* xtol xnorm))
            (setf info 2))
        (if (and (<= (f2cl-lib:dabs actred) ftol) (<= prered ftol)
                 (<= (* p5 ratio) one) (= info 2))
            (setf info 3))
        (if (/= info 0)
            (go label300))
        (if (>= nfev maxfev)
            (setf info 5))
        (if (and (<= (f2cl-lib:dabs actred) epsmch) (<= prered epsmch)
                 (<= (* p5 ratio) one))
            (setf info 6))
        (if (<= delta (* epsmch xnorm))
            (setf info 7))
        (if (<= gnorm epsmch)
            (setf info 8))
        (if (/= info 0)
            (go label300))
        (if (< ratio p0001)
            (go label200))
        (go label30)
       label300
        (if (< iflag 0)
            (setf info iflag))
        (setf iflag 0)
        (if (> nprint 0)
            (multiple-value-bind (var-0 var-1 var-2 var-3 var-4 var-5 var-6)
                (funcall fcn m n x fvec fjac ldfjac iflag)
              (declare (ignore var-2 var-3 var-4))
              (when var-0 (setf m var-0))
              (when var-1 (setf n var-1))
              (when var-5 (setf ldfjac var-5))
              (when var-6 (setf iflag var-6))))
        (go end_label)
       end_label
        (return
         (values nil m n nil nil nil ldfjac nil nil nil nil nil nil nil nil
                 info nfev njev nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::lmder fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '(t (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (double-float) (double-float)
                                              (double-float)
                                              (fortran-to-lisp::integer4)
                                              (array double-float (*))
                                              (fortran-to-lisp::integer4)
                                              (double-float)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (array fortran-to-lisp::integer4
                                               (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*))
                                              (array double-float (*)))
                                            :return-values
                                            '(nil fortran-to-lisp::m
                                              fortran-to-lisp::n nil nil nil
                                              fortran-to-lisp::ldfjac nil nil
                                              nil nil nil nil nil nil
                                              fortran-to-lisp::info
                                              fortran-to-lisp::nfev
                                              fortran-to-lisp::njev nil nil nil
                                              nil nil nil)
                                            :calls
                                            '(fortran-to-lisp::lmpar
                                              fortran-to-lisp::qrfac
                                              fortran-to-lisp::enorm
                                              fortran-to-lisp::dpmpar))))

