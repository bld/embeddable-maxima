;;; Compiled by f2cl version 2.0 beta on 2002/04/25 at 13:19:24
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':simple-array)
;;;           (:array-slicing nil) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "SLATEC")


(let ((zeror 0.0) (zeroi 0.0))
  (declare (type double-float zeroi zeror))
  (defun zkscl (zrr zri fnu n yr yi nz rzr rzi ascle tol elim)
    (declare (type (simple-array double-float (*)) yr yi)
             (type f2cl-lib:integer4 n nz)
             (type double-float zrr zri fnu rzr rzi ascle tol elim))
    (f2cl-lib:with-array-data (yi-%data% yi-%offset% yi)
      (declare (type f2cl-lib:integer4 yi-%offset%)
               (type (simple-array double-float (*)) yi-%data%)
               (ignorable yi-%offset% yi-%data%))
      (f2cl-lib:with-array-data (yr-%data% yr-%offset% yr)
        (declare (type f2cl-lib:integer4 yr-%offset%)
                 (type (simple-array double-float (*)) yr-%data%)
                 (ignorable yr-%offset% yr-%data%))
        (prog ((cyr (make-array 2 :element-type 'double-float))
               (cyi (make-array 2 :element-type 'double-float)) (i 0) (ic 0)
               (idum 0) (kk 0) (nn 0) (nw 0) (acs 0.0) (as 0.0) (cki 0.0)
               (ckr 0.0) (csi 0.0) (csr 0.0) (fn 0.0) (str 0.0) (s1i 0.0)
               (s1r 0.0) (s2i 0.0) (s2r 0.0) (zdr 0.0) (zdi 0.0) (celmr 0.0)
               (elm 0.0) (helim 0.0) (alas 0.0))
          (declare (type (simple-array double-float (2)) cyr cyi)
                   (type double-float alas helim elm celmr zdi zdr s2r s2i s1r
                    s1i str fn csr csi ckr cki as acs)
                   (type f2cl-lib:integer4 nw nn kk idum ic i))
          (setf nz 0)
          (setf ic 0)
          (setf nn (min (the f2cl-lib:integer4 2) (the f2cl-lib:integer4 n)))
          (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                        ((> i nn) nil)
            (tagbody
              (setf s1r (f2cl-lib:fref yr-%data% (i) ((1 n)) yr-%offset%))
              (setf s1i (f2cl-lib:fref yi-%data% (i) ((1 n)) yi-%offset%))
              (f2cl-lib:fset (f2cl-lib:fref cyr (i) ((1 2))) s1r)
              (f2cl-lib:fset (f2cl-lib:fref cyi (i) ((1 2))) s1i)
              (setf as
                      (multiple-value-bind
                          (ret-val var-0 var-1)
                          (zabs s1r s1i)
                        (declare (ignore))
                        (when var-0 (setf s1r var-0))
                        (when var-1 (setf s1i var-1))
                        ret-val))
              (setf acs (- (f2cl-lib:flog as) zrr))
              (setf nz (f2cl-lib:int-add nz 1))
              (f2cl-lib:fset (f2cl-lib:fref yr-%data% (i) ((1 n)) yr-%offset%)
                             zeror)
              (f2cl-lib:fset (f2cl-lib:fref yi-%data% (i) ((1 n)) yi-%offset%)
                             zeroi)
              (if (< acs (- elim)) (go label10))
              (multiple-value-bind
                  (var-0 var-1 var-2 var-3 var-4)
                  (zlog s1r s1i csr csi idum)
                (declare (ignore))
                (when var-0 (setf s1r var-0))
                (when var-1 (setf s1i var-1))
                (when var-2 (setf csr var-2))
                (when var-3 (setf csi var-3))
                (when var-4 (setf idum var-4)))
              (setf csr (- csr zrr))
              (setf csi (- csi zri))
              (setf str (/ (exp csr) tol))
              (setf csr (* str (cos csi)))
              (setf csi (* str (sin csi)))
              (multiple-value-bind
                  (var-0 var-1 var-2 var-3 var-4)
                  (zuchk csr csi nw ascle tol)
                (declare (ignore))
                (when var-0 (setf csr var-0))
                (when var-1 (setf csi var-1))
                (when var-2 (setf nw var-2))
                (when var-3 (setf ascle var-3))
                (when var-4 (setf tol var-4)))
              (if (/= nw 0) (go label10))
              (f2cl-lib:fset (f2cl-lib:fref yr-%data% (i) ((1 n)) yr-%offset%)
                             csr)
              (f2cl-lib:fset (f2cl-lib:fref yi-%data% (i) ((1 n)) yi-%offset%)
                             csi)
              (setf ic i)
              (setf nz (f2cl-lib:int-sub nz 1))
             label10))
          (if (= n 1) (go end_label))
          (if (> ic 1) (go label20))
          (f2cl-lib:fset (f2cl-lib:fref yr-%data% (1) ((1 n)) yr-%offset%)
                         zeror)
          (f2cl-lib:fset (f2cl-lib:fref yi-%data% (1) ((1 n)) yi-%offset%)
                         zeroi)
          (setf nz 2)
         label20
          (if (= n 2) (go end_label))
          (if (= nz 0) (go end_label))
          (setf fn (+ fnu 1.0))
          (setf ckr (* fn rzr))
          (setf cki (* fn rzi))
          (setf s1r (f2cl-lib:fref cyr (1) ((1 2))))
          (setf s1i (f2cl-lib:fref cyi (1) ((1 2))))
          (setf s2r (f2cl-lib:fref cyr (2) ((1 2))))
          (setf s2i (f2cl-lib:fref cyi (2) ((1 2))))
          (setf helim (* 0.5 elim))
          (setf elm (exp (- elim)))
          (setf celmr elm)
          (setf zdr zrr)
          (setf zdi zri)
          (f2cl-lib:fdo (i 3 (f2cl-lib:int-add i 1))
                        ((> i n) nil)
            (tagbody
              (setf kk i)
              (setf csr s2r)
              (setf csi s2i)
              (setf s2r (+ (- (* ckr csr) (* cki csi)) s1r))
              (setf s2i (+ (* cki csr) (* ckr csi) s1i))
              (setf s1r csr)
              (setf s1i csi)
              (setf ckr (+ ckr rzr))
              (setf cki (+ cki rzi))
              (setf as
                      (multiple-value-bind
                          (ret-val var-0 var-1)
                          (zabs s2r s2i)
                        (declare (ignore))
                        (when var-0 (setf s2r var-0))
                        (when var-1 (setf s2i var-1))
                        ret-val))
              (setf alas (f2cl-lib:flog as))
              (setf acs (- alas zdr))
              (setf nz (f2cl-lib:int-add nz 1))
              (f2cl-lib:fset (f2cl-lib:fref yr-%data% (i) ((1 n)) yr-%offset%)
                             zeror)
              (f2cl-lib:fset (f2cl-lib:fref yi-%data% (i) ((1 n)) yi-%offset%)
                             zeroi)
              (if (< acs (- elim)) (go label25))
              (multiple-value-bind
                  (var-0 var-1 var-2 var-3 var-4)
                  (zlog s2r s2i csr csi idum)
                (declare (ignore))
                (when var-0 (setf s2r var-0))
                (when var-1 (setf s2i var-1))
                (when var-2 (setf csr var-2))
                (when var-3 (setf csi var-3))
                (when var-4 (setf idum var-4)))
              (setf csr (- csr zdr))
              (setf csi (- csi zdi))
              (setf str (/ (exp csr) tol))
              (setf csr (* str (cos csi)))
              (setf csi (* str (sin csi)))
              (multiple-value-bind
                  (var-0 var-1 var-2 var-3 var-4)
                  (zuchk csr csi nw ascle tol)
                (declare (ignore))
                (when var-0 (setf csr var-0))
                (when var-1 (setf csi var-1))
                (when var-2 (setf nw var-2))
                (when var-3 (setf ascle var-3))
                (when var-4 (setf tol var-4)))
              (if (/= nw 0) (go label25))
              (f2cl-lib:fset (f2cl-lib:fref yr-%data% (i) ((1 n)) yr-%offset%)
                             csr)
              (f2cl-lib:fset (f2cl-lib:fref yi-%data% (i) ((1 n)) yi-%offset%)
                             csi)
              (setf nz (f2cl-lib:int-sub nz 1))
              (if (= ic (f2cl-lib:int-sub kk 1)) (go label40))
              (setf ic kk)
              (go label30)
             label25
              (if (< alas helim) (go label30))
              (setf zdr (- zdr elim))
              (setf s1r (* s1r celmr))
              (setf s1i (* s1i celmr))
              (setf s2r (* s2r celmr))
              (setf s2i (* s2i celmr))
             label30))
          (setf nz n)
          (if (= ic n) (setf nz (f2cl-lib:int-sub n 1)))
          (go label45)
         label40
          (setf nz (f2cl-lib:int-sub kk 2))
         label45
          (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                        ((> i nz) nil)
            (tagbody
              (f2cl-lib:fset (f2cl-lib:fref yr-%data% (i) ((1 n)) yr-%offset%)
                             zeror)
              (f2cl-lib:fset (f2cl-lib:fref yi-%data% (i) ((1 n)) yi-%offset%)
                             zeroi)
             label50))
          (go end_label)
         end_label
          (return
           (values nil nil nil nil nil nil nz nil nil ascle tol nil)))))))

