;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 2bc8b118fd29 2011/12/03 06:01:32 toy $"
;;;  "f2cl2.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 2bc8b118fd29 2011/12/03 06:01:32 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v fceac530ef0c 2011/11/26 04:02:26 toy $")

;;; Using Lisp SBCL 1.0.55
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "EM-QUADPACK")


(let ((mestab (f2cl-lib:f2cl-init-string (10) (20) nil))
      (nertab (make-array 10 :element-type 'f2cl-lib:integer4))
      (levtab (make-array 10 :element-type 'f2cl-lib:integer4))
      (kount
       (make-array 10 :element-type 'f2cl-lib:integer4 :initial-contents
                   '(0 0 0 0 0 0 0 0 0 0)))
      (kountx 0))
  (declare (type (array (simple-array character (20)) (10)) mestab)
           (type (array f2cl-lib:integer4 (10)) nertab levtab kount)
           (type (f2cl-lib:integer4) kountx))
  (defun xersav (messg nmessg nerr level icount)
    (declare (type (f2cl-lib:integer4) icount level nerr nmessg)
             (type (simple-array character (*)) messg))
    (f2cl-lib:with-multi-array-data
        ((messg character messg-%data% messg-%offset%))
      (prog ((mes
              (make-array '(20) :element-type 'character :initial-element #\ ))
             (lun (make-array 5 :element-type 'f2cl-lib:integer4)) (ii 0) (i 0)
             (iunit 0) (kunit 0) (nunit 0))
        (declare (type (f2cl-lib:integer4) nunit kunit iunit i ii)
                 (type (array f2cl-lib:integer4 (5)) lun)
                 (type (simple-array character (20)) mes))
        (if (> nmessg 0)
            (go label80))
        (if (= (f2cl-lib:fref kount (1) ((1 10))) 0)
            (go end_label))
        (multiple-value-bind (var-0 var-1)
            (xgetua lun nunit)
          (declare (ignore var-0))
          (setf nunit var-1))
        (f2cl-lib:fdo (kunit 1 (f2cl-lib:int-add kunit 1))
                      ((> kunit nunit) nil)
          (tagbody
            (setf iunit (f2cl-lib:fref lun (kunit) ((1 5))))
            (if (= iunit 0)
                (setf iunit (f2cl-lib:i1mach 4)))
            (f2cl-lib:fformat iunit
                              ("0          ERROR MESSAGE SUMMARY" "~%"
                               " MESSAGE START             NERR     LEVEL     COUNT"
                               "~%"))
            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                          ((> i 10) nil)
              (tagbody
                (if (= (f2cl-lib:fref kount (i) ((1 10))) 0)
                    (go label30))
                (f2cl-lib:fformat iunit ("~1@T" 1 (("~20A")) 3 (("~10D")) "~%")
                                  (f2cl-lib:fref mestab (i) ((1 10)))
                                  (f2cl-lib:fref nertab (i) ((1 10)))
                                  (f2cl-lib:fref levtab (i) ((1 10)))
                                  (f2cl-lib:fref kount (i) ((1 10))))
               label20))
           label30
            (if (/= kountx 0)
                (f2cl-lib:fformat iunit
                                  ("0OTHER ERRORS NOT INDIVIDUALLY TABULATED="
                                   1 (("~10D")) "~%")
                                  kountx))
            (f2cl-lib:fformat iunit ("~1@T" "~%"))
           label60))
        (if (< nmessg 0)
            (go end_label))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i 10) nil)
          (tagbody label70 (setf (f2cl-lib:fref kount (i) ((1 10))) 0)))
        (setf kountx 0)
        (go end_label)
       label80
        (f2cl-lib:f2cl-set-string mes messg (string 20))
        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                      ((> i 10) nil)
          (tagbody
            (setf ii i)
            (if (= (f2cl-lib:fref kount (i) ((1 10))) 0)
                (go label110))
            (if (f2cl-lib:fstring-/= mes (f2cl-lib:fref mestab (i) ((1 10))))
                (go label90))
            (if (/= nerr (f2cl-lib:fref nertab (i) ((1 10))))
                (go label90))
            (if (/= level (f2cl-lib:fref levtab (i) ((1 10))))
                (go label90))
            (go label100)
           label90))
        (setf kountx (f2cl-lib:int-add kountx 1))
        (setf icount 1)
        (go end_label)
       label100
        (setf (f2cl-lib:fref kount (ii) ((1 10)))
                (f2cl-lib:int-add (f2cl-lib:fref kount (ii) ((1 10))) 1))
        (setf icount (f2cl-lib:fref kount (ii) ((1 10))))
        (go end_label)
       label110
        (f2cl-lib:f2cl-set-string (f2cl-lib:fref mestab (ii) ((1 10))) mes
                                  (string 20))
        (setf (f2cl-lib:fref nertab (ii) ((1 10))) nerr)
        (setf (f2cl-lib:fref levtab (ii) ((1 10))) level)
        (setf (f2cl-lib:fref kount (ii) ((1 10))) 1)
        (setf icount 1)
        (go end_label)
       end_label
        (return (values nil nil nil nil icount))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::xersav
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo :arg-types
                                            '((simple-array character (*))
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4)
                                              (fortran-to-lisp::integer4))
                                            :return-values
                                            '(nil nil nil nil
                                              fortran-to-lisp::icount)
                                            :calls
                                            '(fortran-to-lisp::i1mach
                                              fortran-to-lisp::xgetua))))

