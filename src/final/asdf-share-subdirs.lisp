;; -*- Mode: lisp -*-
;;
;; Setup the share-subdirs-list.  This is a list of each subdirectory
;; (basically) of share that contains code that can be run by maxima.
(in-package :maxima)

(defun recur-list-directory (dirname)
  (when (fad:directory-pathname-p dirname)
    (let ((current-directory-list (remove-if-not #'fad:directory-pathname-p(fad:list-directory dirname))))
      (remove nil
              (concatenate 'list
                           current-directory-list
                           (apply #'append (mapcar #'recur-list-directory current-directory-list)))))))

;; not so good way to get relative subdirectories paths for maxima "share" directory
(defun share-subdirs-list ()
  (let* ((basepath (namestring (merge-pathnames "share/" (asdf:component-pathname (asdf:find-system '#:maxima)))))
         (basepath-len (length basepath)))
    (mapcar (lambda (path) (subseq (namestring path) basepath-len (- (length (namestring path)) 1))) (recur-list-directory basepath))))
