;;********************************************************
;; file:        init-cl.lisp
;; description: Initialize Maxima
;; date:        Wed Jan 13 1999 - 20:27
;; author:      Liam Healy <Liam.Healy@nrl.navy.mil>
;;********************************************************
(in-package :maxima)

;;; An ANSI-CL portable initializer to replace init_max1.lisp

#+ecl (defvar cl-user::*maxima-build-time* '#.(multiple-value-list (get-decoded-time)))

(defvar *maxima-prefix*)
(defvar *maxima-imagesdir*)
(defvar *maxima-sharedir*)
(defvar *maxima-srcdir*)
(defvar *maxima-docdir*)
(defvar *maxima-infodir*)
(defvar *maxima-htmldir*)
(defvar *maxima-userdir*)
(defvar *maxima-initmac* "maxima-init.mac")
(defvar *maxima-initlisp* "maxima-init.lisp")
(defvar *maxima-tempdir*)
(defvar *maxima-lang-subdir* nil)
(defvar *maxima-demodir*)

(eval-when (:load-toplevel :compile-toplevel :execute)
  (defmacro def-lisp-shadow (root-name)
    "Create a maxima variable $root_name that is an alias for the lisp name *root-name*.
When one changes, the other does too."
    (let ((maxima-name (intern (concatenate 'string "$"
					    (substitute #\_ #\- (string root-name)))))
	  (lisp-name (intern (concatenate 'string "*" (string root-name) "*"))))
      `(progn
	 (defmvar ,maxima-name)
	 (putprop ',maxima-name 'shadow-string-assignment 'assign)
	 (putprop ',maxima-name ',lisp-name 'lisp-shadow)))))

(def-lisp-shadow maxima-tempdir)
(def-lisp-shadow maxima-userdir)

(defun shadow-string-assignment (var value)
  (cond
    ((stringp value)
     (set (get var 'lisp-shadow) value)
     value)
    (t
     (merror (intl:gettext "assignment: must assign a string to ~:M; found: ~M") var value))))

(defun print-directories ()
  (format t "maxima-prefix=~a~%" *maxima-prefix*)
  (format t "maxima-sharedir=~a~%" *maxima-sharedir*)
  (format t "maxima-srcdir=~a~%" *maxima-srcdir*)
  (format t "maxima-demodir=~a~%" *maxima-demodir*)
  (format t "maxima-testsdir=~a~%" *maxima-testsdir*)
  (format t "maxima-docdir=~a~%" *maxima-docdir*)
  (format t "maxima-infodir=~a~%" *maxima-infodir*)
  (format t "maxima-htmldir=~a~%" *maxima-htmldir*)
  (format t "maxima-plotdir=~a~%" *maxima-plotdir*)
  (format t "maxima-userdir=~a~%" *maxima-userdir*)
  (format t "maxima-tempdir=~a~%" *maxima-tempdir*)
  (format t "maxima-lang-subdir=~a~%" *maxima-lang-subdir*))

(defvar *maxima-lispname*
  #+clisp "clisp"
  #+cmu "cmucl"
  #+scl "scl"
  #+sbcl "sbcl"
  #+gcl "gcl"
  #+allegro "acl"
  #+openmcl "openmcl"
  #+abcl "abcl"
  #+lispworks "lispworks"
  #+ecl "ecl"
  #-(or clisp cmu scl sbcl gcl allegro openmcl abcl lispworks ecl) "unknownlisp")

(defvar $file_search_lisp nil
  "Directories to search for Lisp source code.")

(defvar $file_search_maxima nil
  "Directories to search for Maxima source code.")

(defvar $file_search_demo nil
  "Directories to search for demos.")

(defvar $file_search_usage nil)

(defvar $file_search_tests nil
  "Directories to search for maxima test suite")

(defun combine-path (base-path &rest list)
  (if (car list)
      (apply #'combine-path (merge-pathnames (car list) base-path) (cdr list))
      (namestring base-path)))

(defun default-tempdir ()
  (let ((home-env (user-homedir-pathname)))
    (merge-pathnames "tmp/" home-env)))

(defun set-locale-subdir ()
  (let (language territory codeset)
    ;; Determine *maxima-lang-subdir*
    ;;   1. from MAXIMA_LANG_SUBDIR environment variable
    ;;   2. from INTL::*LOCALE* if (1) fails
    (unless  (setq *maxima-lang-subdir* (maxima-getenv-path "MAXIMA_LANG_SUBDIR"))
      (cond ((or (null intl::*locale*) (equal intl::*locale* ""))
	     (setq *maxima-lang-subdir* nil))
            ((member intl::*locale* '("C" "POSIX" "c" "posix") :test #'equal)
             (setq *maxima-lang-subdir* nil))
            (t  (when (eql (position #\. intl::*locale*) 5)
                  (setq codeset (string-downcase (subseq intl::*locale* 6))))
                (when (eql (position #\_ intl::*locale*) 2)
                  (setq territory (string-downcase (subseq intl::*locale* 3 5))))
                (setq language (string-downcase (subseq intl::*locale* 0 2)))
                ;; Set *maxima-lang-subdir* only for known languages.
                ;; Extend procedure below as soon as new translation
                ;; is available.
                (cond ((equal language "en") ;; English
                       (setq *maxima-lang-subdir* nil))
                      ;; Latin-1 aka iso-8859-1 languages
                      ((member language '("es" "pt" "fr" "de" "it") :test #'equal)
                       (if (and (string= language "pt") (string= territory "br"))
                           (setq *maxima-lang-subdir* (concatenate 'string language "_BR"))
                           (setq *maxima-lang-subdir* language))
                       (if (member codeset '("utf-8" "utf8") :test #'equal)
                           (setq *maxima-lang-subdir* (concatenate 'string *maxima-lang-subdir* ".utf8"))))
                      ;; Russian. Default codepage cp1251
                      ((string= language "ru")
                       (setq *maxima-lang-subdir* language)
                       (cond ((member codeset '("utf-8" "utf8") :test #'equal)
                              (setq *maxima-lang-subdir* (concatenate 'string *maxima-lang-subdir* ".utf8")))
                             ((member codeset '("koi8-r" "koi8r") :test #'equal)
                              (setq *maxima-lang-subdir* (concatenate 'string *maxima-lang-subdir* ".koi8r")))))
                      (t  (setq *maxima-lang-subdir* nil))))))))

(defun recur-list-directory (dirname)
  (when (fad:directory-pathname-p dirname)
    (let ((current-directory-list (remove-if-not #'fad:directory-pathname-p(fad:list-directory dirname))))
      (remove nil
              (concatenate 'list
                           current-directory-list
                           (apply #'append (mapcar #'recur-list-directory current-directory-list)))))))

;; not so good way to get relative subdirectories paths for maxima "share" directory
(defun share-subdirs-list ()
  (let* ((basepath (namestring (merge-pathnames "share/" (asdf:component-pathname (asdf:find-system '#:embeddable-maxima)))))
         (basepath-len (length basepath)))
    (mapcar (lambda (path) (subseq (namestring path) basepath-len (- (length (namestring path)) 1))) (recur-list-directory basepath))))

(defun maxima-getenv-path (name)
  (let ((value (maxima-getenv name)))
    (when value (pathname value))))

(defun set-pathnames ()
  (setf *maxima-prefix* (or (maxima-getenv-path "MAXIMA_PREFIX")
                            (asdf:component-pathname (asdf:find-system '#:embeddable-maxima))))
  (setf *maxima-userdir* (or ;;(maxima-getenv "HOME") ;; cl must do it in user-home-dir-pathname
                          (maxima-getenv-path"MAXIMA_HOME") (user-homedir-pathname)))
  (setf *maxima-tempdir* (or (maxima-getenv-path "MAXIMA_TEMPDIR") (maxima-getenv-path "TEMP") (default-tempdir)))
  (setf *maxima-sharedir* (or (maxima-getenv-path "MAXIMA_SHAREDIR") (merge-pathnames "share/" *maxima-prefix*)))
  (setf *maxima-srcdir* (or (maxima-getenv-path "MAXIMA_SRCDIR") (merge-pathnames "src/" *maxima-prefix*)))
  (setf *maxima-demodir* (or (maxima-getenv-path "MAXIMA_DEMODIR") (merge-pathnames "demo/" *maxima-prefix*)))
  (setf *maxima-testsdir* (or (maxima-getenv-path "MAXIMA_TESTSDIR") (merge-pathnames "tests/" *maxima-prefix*)))
  (setf *maxima-docdir* (or (maxima-getenv-path "MAXIMA_DOCDIR") (merge-pathnames "doc/" *maxima-prefix*)))
  (setf *maxima-infodir* (or (maxima-getenv-path "MAXIMA_INFODIR") (merge-pathnames "doc/info/" *maxima-prefix*)))
  (setf *maxima-htmldir* (or (maxima-getenv-path "MAXIMA_HTMLDIR") (merge-pathnames "doc/html/" *maxima-prefix*)))
  (setf *maxima-plotdir* (or (maxima-getenv-path "MAXIMA_PLOTDIR") (merge-pathnames "plotting/" *maxima-prefix*)))
  ;; Assign initial values for Maxima shadow variables
  (setf $maxima_userdir *maxima-userdir*)
  (setf (gethash '$maxima_userdir *variable-initial-values*) *maxima-userdir*)
  (setf $maxima_tempdir *maxima-tempdir*)
  (setf (gethash '$maxima_tempdir *variable-initial-values*) *maxima-tempdir*)
  ;; On Windows Vista gcc requires explicit include
  #+(and gcl windows)
  (let ((mingw-gccver (maxima-getenv-path "mingw_gccver")))
    (when mingw-gccver
      (setq compiler::*cc*
            (concatenate 'string compiler::*cc* " -I\"" 
                         (namestring *maxima-prefix*)
                         "\\include\""
                         " -I\"" 
                         (namestring *maxima-prefix*)
                         "\\lib\\gcc-lib\\mingw32\\"
                         mingw-gccver "\\include\" "))))
  (let* ((ext #+gcl "o"
	      #+(or cmu scl) (c::backend-fasl-file-type c::*target-backend*)
	      #+sbcl "fasl"
	      #+clisp "fas"
	      #+allegro "fasl"
	      #+openmcl (pathname-type ccl::*.fasl-pathname*)
	      #+lispworks (pathname-type (compile-file-pathname "foo.lisp"))
	      #+ecl "fas"
	      #-(or gcl cmu scl sbcl clisp allegro openmcl lispworks ecl)
	      "")
	 (lisp-patterns (concatenate 'string "$$$.{" ext ",lisp,lsp}"))
	 (maxima-patterns "$$$.{mac,mc}")
	 (demo-patterns "$$$.{dem,dm1,dm2,dm3,dmt}")
	 (usage-patterns "$$.{usg,texi}")
	 (share-subdirs-list (share-subdirs-list))
	 ;; Smash the list of share subdirs into a string of the form
	 ;; "{affine,algebra,...,vector}" .
	 (share-subdirs (format nil "{~{~A~^,~}}/" share-subdirs-list)))
    (setq $file_search_lisp
	  (list '(mlist)
		;; actually, this entry is not correct.
		;; there should be a separate directory for compiled
		;; lisp code. jfa 04/11/02
		(combine-path *maxima-userdir* lisp-patterns)
		(combine-path *maxima-sharedir* lisp-patterns)
		(combine-path *maxima-sharedir* share-subdirs lisp-patterns)
		(combine-path *maxima-srcdir* lisp-patterns)))
    (setq $file_search_maxima
	  (list '(mlist)
		(combine-path *maxima-userdir* maxima-patterns)
		(combine-path *maxima-sharedir* maxima-patterns)
		(combine-path *maxima-sharedir* share-subdirs maxima-patterns)))
    (setq $file_search_demo
	  (list '(mlist)
		(combine-path *maxima-sharedir* demo-patterns)
		(combine-path *maxima-sharedir* share-subdirs demo-patterns)
		(combine-path *maxima-demodir* demo-patterns)))
    (setq $file_search_usage
	  (list '(mlist)
		(combine-path *maxima-sharedir* usage-patterns)
		(combine-path *maxima-sharedir* share-subdirs usage-patterns)
		(combine-path *maxima-docdir* usage-patterns)))
    (setq $file_search_tests
	  `((mlist) ,(combine-path *maxima-testsdir* maxima-patterns)))
    ;; If *maxima-lang-subdir* is not nil test whether corresponding info directory
    ;; with some data really exists.  If not this probably means that required
    ;; language pack wasn't installed and we reset *maxima-lang-subdir* to nil.
    (when (and *maxima-lang-subdir*
	       (not (probe-file (combine-path *maxima-infodir* *maxima-lang-subdir* "maxima-index.lisp"))))
      (setq *maxima-lang-subdir* nil))
    ;; Autoload for Maxima documantation index file
    (let ((subdir-bit (if (null *maxima-lang-subdir*) "." *maxima-lang-subdir*)))
      ;; Assign AUTOLOAD property instead of binding a function (the result of AUTOF).
      (setf (get 'cl-info::cause-maxima-index-to-load 'autoload)
	    (combine-path *maxima-infodir* subdir-bit "maxima-index.lisp")))))

(set-pathnames)

(defun process-maxima-args (input-stream batch-flag)
  ;;    (format t "processing maxima args = ")
  ;;    (mapc #'(lambda (x) (format t "\"~a\"~%" x)) (get-application-args))
  ;;    (terpri)
  (let ((maxima-options nil))
    ;; Note: The current option parsing code expects every short
    ;; option to have an equivalent long option.  No check is made for
    ;; this, so please make sure this holds.  Or change the code in
    ;; process-args in command-line.lisp.
    (setf maxima-options
	  (list
	   (make-cl-option :names '("-b" "--batch")
			   :argument "<file>"
			   :action #'(lambda (file)
				       (setf input-stream
					     (make-string-input-stream
					      (format nil "batch(\"~a\");"
						      file)))
				       (setf batch-flag :batch))
			   :help-string
			   "Process maxima file <file> in batch mode.")
	   (make-cl-option :names '("--batch-lisp")
			   :argument "<file>"
			   :action #'(lambda (file)
				       (setf input-stream
					     (make-string-input-stream
					      #-sbcl (format nil ":lisp (load \"~a\");" file)
					      #+sbcl (format nil ":lisp (with-compilation-unit nil (load \"~a\"));" file)))
				       (setf batch-flag :batch))
			   :help-string
			   "Process lisp file <file> in batch mode.")
	   (make-cl-option :names '("--batch-string")
			   :argument "<string>"
			   :action #'(lambda (string)
				       (setf input-stream
					     (make-string-input-stream string))
				       (setf batch-flag :batch))
			   :help-string
			   "Process maxima command(s) <string> in batch mode.")
	   (make-cl-option :names '("-d" "--directories")
			   :action #'(lambda () (print-directories) ($quit))
			   :help-string
			   "Display maxima internal directory information.")
	   (make-cl-option :names '("--disable-readline")
			   :action #'(lambda ()
				       #+gcl
				       (if (find :readline *features*)
					   (si::readline-off)))
			   :help-string "Disable readline support.")
	   (make-cl-option :names '("-g" "--enable-lisp-debugger")
			   :action #'(lambda ()
				       (setf *debugger-hook* nil))
			   :help-string
			   "Enable underlying lisp debugger.")
	   (make-cl-option :names '("-h" "--help")
			   :action #'(lambda ()
				       (format t "usage: maxima [options]~%")
				       (list-cl-options maxima-options)
				       (bye))
			   :help-string "Display this usage message.")
	   (make-cl-option :names '("--userdir")
			   :argument "<directory>"
			   :action nil
			   :help-string "Use  <directory> for user directory (default is $HOME/maxima for Windows, and $HOME/.maxima for others)")
 	   (make-cl-option :names '("--init")
			   :argument "<file>"
			   :action #'(lambda (file)
				       (setf *maxima-initmac* (concatenate 'string file ".mac"))
				       (setf *maxima-initlisp* (concatenate 'string file ".lisp")))
			   :help-string (format nil "Set the name of the Maxima & Lisp initialization files to <file>.mac & <file>.lisp (default is ~a)" (subseq *maxima-initmac* 0 (- (length *maxima-initmac*) 4))))
 	   (make-cl-option :names '("--init-mac")
			   :argument "<file>"
			   :action #'(lambda (file)
				       (setf *maxima-initmac* file))
			   :help-string (format nil "Set the name of the Maxima initialization file (default is ~a)" *maxima-initmac*))
 	   (make-cl-option :names '("--init-lisp")
			   :argument "<file>"
			   :action #'(lambda (file)
				       (setf *maxima-initlisp* file))
			   :help-string (format nil "Set the name of the Lisp initialization file (default is ~a)" *maxima-initlisp*))
	   (make-cl-option :names '("-l" "--lisp")
			   :argument "<lisp>"
			   :action nil
			   :help-string "Use lisp implementation <lisp>.")
	   (make-cl-option :names '("--list-avail")
			   :action 'list-avail-action
			   :help-string
			   "List the installed version/lisp combinations.")
	   (make-cl-option :names '("-p" "--preload-lisp")
			   :argument "<lisp-file>"
			   :action #'(lambda (file)
				       #-sbcl (load file) #+sbcl (with-compilation-unit nil (load file)))
			   :help-string "Preload <lisp-file>.")
	   (make-cl-option :names '("-q" "--quiet")
			   :action #'(lambda () (declare (special *maxima-quiet*)) (setq *maxima-quiet* t))
			   :help-string "Suppress Maxima start-up message.")
	   (make-cl-option :names '("-r" "--run-string")
			   :argument "<string>"
			   :action #'(lambda (string)
				       (setf input-stream
					     (make-string-input-stream string))
				       (setf batch-flag nil))
			   :help-string
			   "Process maxima command(s) <string> in interactive mode.")
	   (make-cl-option :names '("-s" "--server")
			   :argument "<port>"
			   :action #'(lambda (port-string)
				       (start-client (parse-integer
						      port-string)))
			   :help-string "Connect Maxima to server on <port>.")
	   (make-cl-option :names '("-u" "--use-version")
			   :argument "<version>"
			   :action nil
			   :help-string "Use maxima version <version>.")
	   (make-cl-option :names '("-v" "--verbose")
			   :action nil
			   :help-string
			   "Display lisp invocation in maxima wrapper script.")
	   (make-cl-option :names '("--version")
			   :action #'(lambda ()
				       (format t "Maxima ~a~%"
					       (asdf:component-version (asdf:find-system '#:embeddable-maxima)))
				       ($quit))
			   :help-string
			   "Display the default installed version.")
	   (make-cl-option :names '("--very-quiet")
			   :action #'(lambda () (declare (special *maxima-quiet* *display-labels-p*))
                                       (setq *maxima-quiet* t *display-labels-p* nil))
			   :help-string "Suppress expression labels and Maxima start-up message.")
	   (make-cl-option :names '("-X" "--lisp-options")
			   :argument "<Lisp options>"
			   :action #'(lambda (&rest opts)
				       (format t "Lisp options: ~A" opts))
			   :help-string "Options to be given to the underlying Lisp")
           ))
    (process-args (get-application-args) maxima-options))
  (values input-stream batch-flag))

(defun cl-user::run ()
  "Run Maxima in its own package."
  (let ((*package* (find-package 'maxima)))
    (setf *load-verbose* nil)
    (setf *debugger-hook* #'maxima-lisp-debugger)
    ;; See discussion on the maxima list
    ;; http://www.math.utexas.edu/pipermail/maxima/2011/024014.html.
    ;; Set *print-length* and *print-level* to some reasonable values so
    ;; that normal Lisp structure is shown, but prevent typical circular
    ;; structures from hanging Lisp.
    ;;
    ;; (We do we set these instead of binding them?)
    (setf *print-circle* nil)
    (setf *print-length* 100)
    (setf *print-level* 15)
    
    ;; GCL: print special floats, which are generated whether or not this flag is enabled
    #+gcl (setf si:*print-nans* t)
    #+ccl
    (progn
      (setf ccl::*invoke-debugger-hook-on-interrupt* t)
      ;; CCL 1.5 makes *read-default-float-format* a thread-local
      ;; variable.  Hence we need to set it here to get our desired
      ;; behavior.
      (setf *read-default-float-format* 'double-float))
    (let ((input-stream *standard-input*)
          (batch-flag nil))
      #+allegro
      (progn
        (set-readtable-for-macsyma)
        (setf *read-default-float-format* 'lisp::double-float))

      (catch 'to-lisp
        (initialize-real-and-run-time)
        (intl::setlocale)
        (set-locale-subdir)
        (adjust-character-encoding)
        (set-pathnames)
        (when (boundp '*maxima-prefix*)
          (push (merge-pathnames "locale/" *maxima-prefix*) intl::*locale-directories*))
        (setf (values input-stream batch-flag)
              (process-maxima-args input-stream batch-flag))
        (loop
          (with-simple-restart (macsyma-quit "Maxima top-level")
            (macsyma-top-level input-stream batch-flag)))))))

(defun adjust-character-encoding ()
  (ignore-errors
   #+clisp (progn (setf custom:*default-file-encoding*
                        (ext:make-encoding :input-error-action #\?))
                  (setf custom:*terminal-encoding*
                        custom:*default-file-encoding*))))

(import 'cl-user::run)

(defun $to_lisp ()
  (format t "~&Type (to-maxima) to restart, ($quit) to quit Maxima.~%")
  (let ((old-debugger-hook *debugger-hook*))
    (catch 'to-maxima
      (unwind-protect
	   (maxima-read-eval-print-loop)
	(setf *debugger-hook* old-debugger-hook)
	(format t "Returning to Maxima~%")))))

(defun to-maxima ()
  (throw 'to-maxima t))

(defun maxima-read-eval-print-loop ()
  (setf *debugger-hook* #'maxima-lisp-debugger-repl)
  (loop
    (catch 'to-maxima-repl
      (format t "~a~%~a> ~a" *prompt-prefix* (package-name *package*) *prompt-suffix*)
      (finish-output)
      (format t "~{~&~S~}" (multiple-value-list (eval (read)))))))

(defun maxima-lisp-debugger-repl (condition me-or-my-encapsulation)
  (declare (ignore me-or-my-encapsulation))
  (format t "~&Maxima encountered a Lisp error:~%~% ~A" condition)
  (format t "~&~%Automatically continuing.~%To reenable the Lisp debugger set *debugger-hook* to nil.~%")
  (throw 'to-maxima-repl t))

(defvar $help "type `describe(topic);' or `example(topic);' or `? topic'")

(defun $help (&rest dummy)
  (declare (ignore dummy))
  $help)

(eval-when (:load-toplevel :execute)
  (let ((context '$global))
    (declare (special context))
    (dolist (x '($%pi $%i $%e $%phi %i $%gamma  ;numeric constants
                 $inf $minf $und $ind $infinity ;pseudo-constants
                 t nil))                        ;logical constants (Maxima names: true, false)
      (kind x '$constant)
      (setf (get x 'sysconst) t))))

;;; Now that all of maxima has been loaded, define the various lists
;;; and hashtables of builtin symbols and values.

;;; The assume database structures for numeric constants such as $%pi and $%e
;;; are circular.  Attempting to copy a circular structure
;;; into *builtin-symbol-props* would cause a hang.  Therefore
;;; the properties are copied into *builtin-symbol-props* before
;;; initializing the assume database.

(let ((maxima-package (find-package :maxima)))
  (do-symbols (s maxima-package)
    (when (and (eql (symbol-package s) maxima-package)
	       (not (eq s '||))
	       (member (char (symbol-name s) 0) '(#\$ #\%) :test #'char=))
      (push s *builtin-symbols*)
      (setf (gethash s *builtin-symbol-props*)
	    (copy-tree (symbol-plist s))))))


;; Initialize assume database for $%pi, $%e, etc
(dolist (c *builtin-numeric-constants*)
  (initialize-numeric-constant c))

(dolist (s *builtin-symbols*)
  (when (boundp s)
    (push s *builtin-symbols-with-values*)))

(dolist (s *builtin-symbols-with-values*)
  (setf (gethash s *builtin-symbol-values*) (symbol-value s)))

(setf *builtin-$props* (copy-list $props))
(setf *builtin-$rules* (copy-list $rules))
