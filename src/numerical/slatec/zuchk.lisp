;;; Compiled by f2cl version 2.0 beta on 2002/04/25 at 13:19:30
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':simple-array)
;;;           (:array-slicing nil) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "SLATEC")


(defun zuchk (yr yi nz ascle tol)
  (declare (type f2cl-lib:integer4 nz) (type double-float tol ascle yi yr))
  (prog ((ss 0.0) (st 0.0) (wr 0.0) (wi 0.0))
    (declare (type double-float wi wr st ss))
    (setf nz 0)
    (setf wr (coerce (abs yr) 'double-float))
    (setf wi (coerce (abs yi) 'double-float))
    (setf st (min wr wi))
    (if (> st ascle) (go end_label))
    (setf ss (max wr wi))
    (setf st (/ st tol))
    (if (< ss st) (setf nz 1))
    (go end_label)
   end_label
    (return (values nil nil nz nil nil))))

