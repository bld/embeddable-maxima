;;; -*-  Mode: Lisp; Package: Maxima; Syntax: Common-Lisp; Base: 10 -*- ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     The data in this file contains enhancments.                    ;;;;;
;;;                                                                    ;;;;;
;;;  Copyright (c) 1984,1987 by William Schelter,University of Texas   ;;;;;
;;;     All rights reserved                                            ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     (c) Copyright 1981 Massachusetts Institute of Technology         ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :maxima)

(macsyma-module grind)

(declare-top (genprefix gri)
	     (special lop rop *grind-charlist* chrps $aliases aliaslist linel)
	     (fixnum (chrct))
	     (*expr lbp rbp))

(defun chrct () (f- linel chrps))

(defun chrct* () (f- linel chrps))

(defvar fortranp nil)

;;(DEFMSPEC $GRIND (X) (SETQ X (CDR X))
;;  (LET (Y)
;;    (IF (NOT (ZEROP (CHARPOS T))) (MTERPRI))
;;    (COND ((OR (NULL X) (CDR X)) (WNA-ERR '$GRIND))
;;	  ((ATOM (SETQ X (STRMEVAL (CAR X))))
;;	   (SETQ X ($VERBIFY X))
;;	   (COND ((SETQ Y (MGET X 'MEXPR))
;;		  (MGRIND (LIST '(MDEFINE) (CONS (LIST X) (CDADR Y)) (CADDR Y)) NIL))
;;		 ((SETQ Y (MGET X 'MMACRO))
;;		  (MGRIND (LIST '(MDEFMACRO) (CONS (LIST X) (CDADR Y)) (CADDR Y)) NIL))
;;		 ((SETQ Y (MGET X 'AEXPR))
;;		  (MGRIND (LIST '(MDEFINE) (CONS (LIST X 'ARRAY) (CDADR Y)) (CADDR Y)) NIL))
;;		 (T (MGRIND X NIL)))
;;	   (TYO #/$ NIL))
;;	  (T (MGRIND X NIL) (TYO #/$ NIL)))
;;    '$DONE))
;;Update from F302 --gsb

(defmspec $grind (x) (setq x (cdr x))
	  (let (y)
	    #+nocp(fresh-line)
	    #-nocp(if (not (zerop (charpos t))) (mterpri))
	    (cond
          ((null x))
          ((cdr x) (mapc #'(lambda (xx) (funcall (get '$grind 'mfexpr*) `(($grind) ,xx))) x))
		  ((symbolp (setq x (strmeval (car x))))
		   (unless (mstringp x) (setq x ($verbify x)))
		   (cond ((setq y (mget x 'mexpr))
			  (mgrind (list '(mdefine) (cons (list x) (cdadr y)) (caddr y)) nil))
			 ((setq y (mget x 'mmacro))
			  (mgrind (list '(mdefmacro) (cons (list x) (cdadr y)) (caddr y)) nil))
			 ((setq y (mget x 'aexpr))
			  (mgrind (list '(mdefine) (cons (list x 'array) (cdadr y)) (caddr y)) nil))
			 (t (mgrind x nil)))
		   (tyo #\$ nil) (tyo #\Newline nil))
		  (t (mgrind x nil) (tyo #\$ nil) (tyo #\Newline nil)))
	    '$done))

(defun show-msize (lis)
  (format t "~%Length is ~A" (car lis))
  (loop for v in (cdr lis)
	 when (numberp v) do (princ (ascii v))
	 else when (consp v)
	 do   (show-msize v)))

;;Msize returns a list whose first member is the number of characters
;;in the printed representation of the rest of the list.
;;thus to print something given it's msize you could
;;use msize-print if you did not care about line breaks etc.
;;If you care about them then you should send a newline
;;if the current distance to the margin is bigger than the first element of lis

(defun msize-print (lis)
  (loop for v in (cdr lis)
	 when (numberp v)
	 do (princ (ascii v))
	 else do (msize-print v)))

(defun i-$grind (x)
  (let (y)
    #+nocp(fresh-line)
    #-nocp(if (not (zerop (charpos t))) (mterpri))
    (cond  ((symbolp (setq x (strmeval  x)))
	    (setq x ($verbify x))
	    (cond ((setq y (mget x 'mexpr))
		   (mgrind (list '(mdefine) (cons (list x) (cdadr y)) (caddr y)) nil))
		  ((setq y (mget x 'mmacro))
		   (mgrind (list '(mdefmacro) (cons (list x) (cdadr y)) (caddr y)) nil))
		  ((setq y (mget x 'aexpr))
		   (mgrind (list '(mdefine) (cons (list x 'array) (cdadr y)) (caddr y)) nil))
		  (t (mgrind x nil)))
	    (tyo #\$ nil))
	   (t (mgrind x nil) (tyo #\$ nil)))
    '$done))
  

(defun mgrind (x out)
  (setq chrps 0)
  (mprint (msize x nil nil 'mparen 'mparen) out))

(defun mprint (x out)
  (cond ((characterp x)
	 (setq chrps (f1+ chrps)) (tyo x out))
	((< (car x) (chrct*)) (mapc #'(lambda (l) (mprint l out)) (cdr x)))
	(t (prog (i) (setq i chrps)
		 (mprint (cadr x) out)
		 (cond ((null (cddr x)) (return nil))
		       ((and (or (atom (cadr x)) (< (caadr x) (chrct*)))
			     (or (> (chrct*) (// linel 2))
				 (atom (caddr x)) (< (caaddr x) (chrct*))))
			(setq i chrps)
			(mprint (caddr x) out))
		       (t (setq i (f1+ i)) (setq chrps 0) (terpri out)
			  (mtyotbsp i out) (mprint (caddr x) out)))
		 (do ((l (cdddr x) (cdr l))) ((null l))
		   (cond
		     ((or (atom (car l)) (< (caar l) (chrct*))) nil)
		     (t (setq chrps 0) (terpri out) (mtyotbsp i out)))
		   (mprint (car l) out))))))

(defun mtyotbsp (n out) (declare (fixnum n))
       (setq chrps (f+ n chrps))
       (do () ((< n 8)) (tyo #\tab out) (setq n (f- n 8)))
       (do () ((< n 1)) (tyo #\space out) (setq n (f1- n))))

(defun strgrind (x)
  (let (*grind-charlist* (chrps 0))
    (strprint (msize x nil nil 'mparen 'mparen))
    (nreverse *grind-charlist*)))

(defun strprint (x)
  (cond ((atom x) (styo x))
	((< (car x) (chrct*)) (mapc #'strprint (cdr x)))
	(t (prog (i)
	      (setq i chrps)
	      (strprint (cadr x))
	      (cond ((null (cddr x)) (return nil))
		    ((and (or (atom (cadr x)) (< (caadr x) (chrct*)))
			  (or (> (chrct*) (// linel 2))
			      (atom (caddr x)) (< (caaddr x) (chrct*))))
		     (setq i chrps)
		     (strprint (caddr x)))
		    (t (setq i (f1+ i)) (setq chrps 0) (sterpri)
		       (styotbsp i) (strprint (caddr x))))
	      (do ((l (cdddr x) (cdr l))) ((null l))
		(cond
		  ((or (atom (car l)) (< (caar l) (chrct*))) nil)
		  (t (setq chrps 0) (sterpri) (styotbsp i)))
		(strprint (car l)))))))

(defun styo (x) (setq *grind-charlist* (cons x *grind-charlist*) chrps (f1+ chrps)))

(defun sterpri () (setq *grind-charlist* (cons #\newline *grind-charlist*) chrps 0))

(defun styotbsp (n) (declare (fixnum n)) (setq chrps n)
       (do () ((< n 8)) (setq *grind-charlist* (cons #\tab *grind-charlist*) n (f- n 8)))
       (do () ((< n 1)) (setq *grind-charlist* (cons #\space *grind-charlist*) n (f1- n))))

(defmfun mstring (x)
  (nreverse (string1 (msize x nil nil 'mparen 'mparen) nil)))

(defun string1 (x l)
  (cond
    ((atom x) (cons x l))
    (t (setq x  (cdr x))
       (do () ((null x) l) (setq l (string1 (car x) l) x (cdr x))))))


(defun msize (x l r lop rop)
  (setq x (nformat x))
  (cond ((atom x) (if fortranp (msz (makestring x) l r) (msize-atom x l r)))
	((or (<= (lbp (caar x)) (rbp lop)) (> (lbp rop) (rbp (caar x))))
	 (msize-paren x l r))
	((memq 'array (cdar x)) (msize-array x l r))
	((safe-get (caar x) 'grind)
	 (the (values t) (funcall (get (caar x) 'grind) x l r)))
	(t (msize-function x l r nil))))

(defun msize-atom (x l r)
  (prog (y)
     (cond ((numberp x) (setq y (exploden x)))
	   ((and (setq y (safe-get x 'reversealias))
		 (not (and (memq x $aliases) (get x 'noun))))
	    (setq y (exploden y)))
	   ((setq y (assqr x aliaslist)) (return (msize (car y) l r lop rop)))
       ((null (setq y (exploden x))))
       ((safe-get x 'noun) (return (msize-atom (get x 'noun) l r)))
	   ((char= #\$ (car y)) (setq y (slash (cdr y))))
	   ((char= #\& (car y))
	    (do ((l (cdr y) (cdr l))) ((null l))
	      (cond ((or (zl-member (car l)
				    '(#. double-quote-char
				      #. back-slash-char
				      #. semi-colon-char #\$))
			 (and (char< (car l) #\space)
			      (not (char= (car l) #\return ;13
					  ))))
		     (rplacd l (cons (car l) (cdr l)))
		     (rplaca l #. back-slash-char) (setq l (cdr l)))))
	    (setq y (cons #.double-quote-char
			  (nconc (cdr y) (list #.double-quote-char)))))
	   (t (setq y (cons #\? (slash y)))))
     (return (msz y l r))))

(defun msz (x l r) (setq x (nreconc l (nconc x r))) (cons (length x) x))

(defun slash (x)
  (do ((l (cdr x) (cdr l))) ((null l))
    ; Following test is the same (except backslash is not included,
    ; so backslash is preceded by backslash) as in SCAN-TOKEN (src/nparse.lisp).
    (if (or (ascii-numberp (car l)) (alphabetp (car l)))
	nil
	(progn (rplacd l (cons (car l) (cdr l)))
	       (rplaca l #. back-slash-char) (setq l (cdr l)))))
  (if (alphabetp (car x)) x (cons #. back-slash-char x)))

;;#-cl
;;(DEFUN ALPHANUMP (N) (DECLARE (FIXNUM N))
;;  (OR (ASCII-NUMBERP N) (ALPHABETP N)))

(defun msize-paren (x l r)
  (msize x (cons #.left-parentheses-char l)
	 (cons #.right-parentheses-char r) 'mparen 'mparen))

;; The variables LB and RB are not uses here syntactically, but for
;; communication.  The FORTRAN program rebinds them to #/( and #/) since
;; Fortran array references are printed with parens instead of brackets.

(defvar lb #\[)
(defvar rb #\])

(defun msize-array (x l r &aux f)
  (if (eq (caar x) 'mqapply) (setq f (cadr x) x (cdr x)) (setq f (caar x)))
  (cond ((and (symbolp (caar x)) (get (caar x) 'verb) (get (caar x) 'alias))
	 (setq l (reconc '(#\' #\') l)))
	((and (symbolp (caar x))
	      (get (caar x) 'noun)
	      (not (memq (caar x) (cdr $aliases)))
	      (not (get (caar x) 'reversealias)))
	 (setq l (cons #\' l))))
  (setq l (msize f l (list lb) lop 'mfunction)
	r (msize-list (cdr x) nil (cons rb r)))
  (cons (f+ (car l) (car r)) (cons l (cdr r))))

(defun msize-function (x l r op)
  (cond ((not (symbolp (caar x))))
	((and (get (caar x) 'verb) (get (caar x) 'alias))
	 (setq l (reconc '(#\' #\') l)))
	((and (get (caar x) 'noun) (not (memq (caar x) (cdr $aliases)))
	      (not (get (caar x) 'reversealias)))
	 (setq l (cons #\' l))))
  (setq l (msize (if op (getop (caar x)) (caar x)) l (ncons #. left-parentheses-char ) 'mparen 'mparen)
	r (msize-list (cdr x) nil (cons #. right-parentheses-char r)))
  (cons (f+ (car l) (car r)) (cons l (cdr r))))

(defun msize-list (x l r)
  (if (null x) (msz nil l r)
      (do ((nl) (w 0))
	  ((null (cdr x))
	   (setq nl (cons (msize (car x) l r 'mparen 'mparen) nl))
	   (cons (f+ w (caar nl)) (nreverse nl)))
	(declare (fixnum w))
	(setq nl (cons (msize (car x) l (list #\,) 'mparen 'mparen) nl)
	      w (f+ w (caar nl)) x (cdr x) l nil))))

(defun msize-prefix (x l r)
  (msize (cadr x) (reconc (strsym (caar x)) l) r (caar x) rop))

(defun msize-infix (x l r)
  (if (not (= (length (cdr x)) 2))
    (return-from msize-infix (msize-function x l r t)))
  (setq l (msize (cadr x) l nil lop (caar x))
	r (msize (caddr x) (reverse (strsym (caar x))) r (caar x) rop))
  (list (f+ (car l) (car r)) l r))

(defun msize-postfix (x l r)
  (msize (cadr x) l (append (strsym (caar x)) r) lop (caar x)))

(defun msize-nary (x l r) (msznary x l r (strsym (caar x))))

(defun msize-nofix (x l r) (msize (caar x) l r (caar x) rop))

(defun msize-matchfix (x l r)
  (setq l (nreconc l (car (strsym (caar x))))
	l (cons (length l) l)
	r (append (cdr (strsym (caar x))) r)
	x (msize-list (cdr x) nil r))
  (cons (f+ (car l) (car x)) (cons l (cdr x))))

(defun msznary (x l r dissym)
  (cond ((null (cddr x)) (msize-function x l r t))
	(t (setq l (msize (cadr x) l nil lop (caar x)))
	   (do ((ol (cddr x) (cdr ol)) (nl (list l)) (w (car l)))
	       ((null (cdr ol))
		(setq r (msize (car ol) (reverse dissym) r (caar x) rop))
		(cons (f+ (car r) w) (nreverse (cons r nl))))
	     (declare (fixnum w))
	     (setq nl (cons (msize (car ol) (reverse dissym) nil (caar x) (caar x))
			    nl)
		   w (f+ (caar nl) w))))))

(defun strsym (x) (or (get x 'strsym) (get x 'dissym)))

(defprop bigfloat msz-bigfloat grind)

(defun msz-bigfloat (x l r)
  (msz (mapcar #'(lambda (l) (getcharn l 1)) (fpformat x)) l r))

(defprop mprogn msize-matchfix grind)
(defprop mlist msize-matchfix grind)

(defprop mqapply msz-mqapply grind)

(defun msz-mqapply (x l r)
  (setq l (msize (cadr x) l (list #. left-parentheses-char ) lop 'mfunction)
	r (msize-list (cddr x) nil (cons #. right-parentheses-char r)))
  (cons (f+ (car l) (car r)) (cons l (cdr r))))

; SPACEOUT appears solely in trace output. See mtrace.lisp.

(defprop spaceout msize-spaceout grind)

(defun msize-spaceout (x l r)
  (let ((n (cadr x)) l)
    (dotimes (i n) (setq l (cons #\space l)))
    (cons n l)))

(defprop mquote msize-prefix grind)
(defprop msetq msize-infix grind)
(defprop msetq msize-infix grind)

(defprop msetq (#\:) strsym)
(defprop msetq 180. lbp)
(defprop msetq 20. rbp)

(defprop mset msize-infix grind)
(defprop mset (#\: #\:) strsym)
(defprop mset 180. lbp)
(defprop mset 20. rbp)

(defprop mdefine msz-mdef grind)
(defprop mdefine (#\: #\=) strsym)
(defprop mdefine 180. lbp)
(defprop mdefine 20. rbp)

(defprop mdefmacro msz-mdef grind)
(defprop mdefmacro (#\: #\: #\=) strsym)
(defprop mdefmacro 180. lbp)
(defprop mdefmacro 20. rbp)

(defun msz-mdef (x l r)
  (setq l (msize (cadr x) l (copy-list (strsym (caar x))) lop (caar x))
	r (msize (caddr x) nil r (caar x) rop))
  (setq x (cons (f- (car l) (caadr l)) (cddr l)))
  (if (and (not (atom (cadr r))) (not (atom (caddr r)))
	   (< (f+ (car l) (caadr r) (caaddr r)) linel))
      (setq x (nconc x (list (cadr r) (caddr r)))
	    r (cons (car r) (cdddr r))))
  (cons (f+ (car l) (car r)) (cons (cadr l) (cons x (cdr r)))))


(defprop mfactorial msize-postfix grind)
(defprop mfactorial 160. lbp)

(defprop mexpt msz-mexpt grind)
(defprop mexpt 140. lbp)
(defprop mexpt 139. rbp)

(defun msz-mexpt (x l r)
  (setq l (msize (cadr x) l nil lop 'mexpt)
	r (if (mmminusp (setq x (nformat (caddr x))))
	      (msize (cadr x) (reverse '(#\^ #\-)) r 'mexpt rop)
	      (msize x (list #\^) r 'mexpt rop)))
  (list (f+ (car l) (car r)) l r))


(defprop mncexpt msize-infix grind)
(defprop mncexpt 140. lbp)
(defprop mncexpt 139. rbp)

(defprop mnctimes msize-nary grind)
(defprop mnctimes 130. lbp)
(defprop mnctimes 129. rbp)

(defprop mtimes msz-mtimes grind)
(defprop mtimes 120. lbp)
(defprop mtimes 120. rbp)

(defun msz-mtimes (x l r) (msznary x l r '(#\*)))


(defprop mquotient msize-infix grind)
(defprop mquotient 120. lbp)
(defprop mquotient 120. rbp) 
(defprop rat msize-infix grind)
(defprop rat 120. lbp)
(defprop rat 120. rbp)

(defprop mplus msz-mplus grind)
(defprop mplus 100. lbp)
(defprop mplus 100. rbp)

(defun msz-mplus (x l r)
  (cond ((null (cddr x))
	 (if (null (cdr x))
	     (msize-function x l r t)
	     (msize (cadr x) (append (ncons #\+) l) r 'mplus rop)))
	(t (setq l (msize (cadr x) l nil lop 'mplus) x (cddr x))
	   (do ((nl (list l)) (w (car l)) (dissym))
	       ((null (cdr x))
		(if (mmminusp (car x)) (setq l (cadar x) dissym (list #\-))
		    (setq l (car x) dissym (list #\+)))
		(setq r (msize l dissym r 'mplus rop))
		(cons (f+ (car r) w) (nreverse (cons r nl))))
	     (declare (fixnum w))
	     (if (mmminusp (car x)) (setq l (cadar x) dissym (list #\-))
		 (setq l (car x) dissym (list #\+)))
	     (setq nl (cons (msize l dissym nil 'mplus 'mplus) nl)
		   w (f+ (caar nl) w)
		   x (cdr x))))))

(defprop mminus msize-prefix grind)
(defprop mminus (#\-) strsym)
(defprop mminus 100. rbp)
(defprop mminus 100. lbp)

(defprop mequal msize-infix grind)
(defprop mequal 80. lbp)
(defprop mequal 80. rbp)

(defprop mnotequal msize-infix grind)
(defprop mnotequal 80. lbp)
(defprop mnotequal 80. rbp)

(defprop mgreaterp msize-infix grind)
(defprop mgreaterp 80. lbp)
(defprop mgreaterp 80. rbp)

(defprop mgeqp msize-infix grind)
(defprop mgeqp 80. lbp)
(defprop mgeqp 80. rbp)

(defprop mlessp msize-infix grind)
(defprop mlessp 80. lbp)
(defprop mlessp 80. rbp)

(defprop mleqp msize-infix grind)
(defprop mleqp 80. lbp)
(defprop mleqp 80. rbp)

(defprop mnot msize-prefix grind)
(defprop mnot 70. rbp)

(defprop mand msize-nary grind)
(defprop mand 65. lbp)
(defprop mand 65. rbp)

(defprop mor msize-nary grind)
(defprop mor 60. lbp)
(defprop mor 60. rbp)

(defprop mcond msz-mcond grind)
(defprop mcond 45. lbp)
(defprop mcond 45. rbp)

(defprop %mcond msz-mcond grind)
(defprop %mcond 45. lbp)
(defprop %mcond 45. rbp)

;; See comments above DIM-MCOND in displa.lisp concerning MCOND parsing and formatting.

(defun msz-mcond (x l r)
  (setq if (nreconc l '(#\i #\f #\space))
        if (cons (length if) if)
        l (msize (cadr x) nil nil 'mcond 'mparen))

    (let
      ((args (cdddr x))
       (if-literal (reverse (exploden "if ")))
       (else-literal (reverse (exploden " else ")))
       (elseif-literal (reverse (exploden " elseif ")))
       (then-literal (reverse (exploden " then ")))
       (parts)
       (part))

      (let ((sgra (reverse args)))
        (if (and (or (eq (car sgra) nil) (eq (car sgra) '$false)) (eq (cadr sgra) t))
          (setq args (reverse (cddr sgra)))))

      (setq parts (list if l))

      (setq part
            (cond
              ((= (length args) 0)
               `(,(msize (caddr x) (copy-tree then-literal) r 'mcond rop)))
              (t
                `(,(msize (caddr x) (copy-tree then-literal) nil 'mcond 'mparen))))

            parts (append parts part))
      
      (loop while (>= (length args) 2) do
        (let ((maybe-elseif (car args)) (else-or-then (cadr args)))
          (cond
            ((= (length args) 2)
             (cond
               ((eq maybe-elseif t)
                (let ((else-arg else-or-then))
                  (setq
                    part `(,(msize else-arg (copy-tree else-literal) r 'mcond rop))
                    parts (append parts part))))
               (t
                 (let ((elseif-arg maybe-elseif) (then-arg else-or-then))
                   (setq
                     part `(,(msize elseif-arg (copy-tree elseif-literal) nil 'mcond 'mparen)
                             ,(msize then-arg (copy-tree then-literal) r 'mcond rop))
                     parts (append parts part))))))
            (t
              (let ((elseif-arg maybe-elseif) (then-arg else-or-then))
                (setq
                  part `(,(msize elseif-arg (copy-tree elseif-literal) nil 'mcond 'mparen)
                          ,(msize then-arg (copy-tree then-literal) nil 'mcond 'mparen))
                  parts (append parts part))))))

        (setq args (cddr args)))

      (cons (apply '\+ (mapcar 'car parts)) parts)))

(defprop text-string msize-text-string grind)

(defun msize-text-string (x l r)
  (declare (ignore r))
  (cons (length (cdr x)) (cdr x)))

(defprop mdo msz-mdo grind)
(defprop mdo 25. lbp)
(defprop mdo 25. rbp)

(defprop mdoin msz-mdoin grind)
(defprop mdoin 30. lbp)
(defprop mdoin 30. rbp)

(defprop %mdo msz-mdo grind)
(defprop %mdo 25. lbp)
(defprop %mdo 25. rbp)

(defprop %mdoin msz-mdoin grind)
(defprop %mdoin 30. lbp)
(defprop %mdoin 30. rbp)

(defun msz-mdo (x l r)
  (msznary (cons '(mdo) (strmdo x)) l r '(#\space)))

(defun msz-mdoin (x l r)
  (msznary (cons '(mdo) (strmdoin x)) l r '(#\space)))

(defun strmdo (x)
  (nconc (cond ((second x) `($for ,(second x))))
	 (cond ((equal 1 (third x)) nil)
	       ((third x)  `($from ,(third x))))
	 (cond ((equal 1 (fourth x)) nil)
	       ((fourth x) `($step ,(fourth x)))
	       ((fifth x)  `($next ,(fifth x))))
	 (cond ((sixth x)  `($thru ,(sixth x))))
	 (cond ((null (seventh x)) nil)
	       ((eq 'mnot (caar (seventh x)))
		`($while ,(cadr (seventh x))))
	       (t `($unless ,(seventh x))))
	 `($do ,(eighth x))))

(defun strmdoin (x)
  (nconc `($for ,(second x) $in ,(third x))
	 (cond ((sixth x) `($thru ,(sixth x))))
	 (cond ((null (seventh x)) nil)
	       ((eq 'mnot (caar (seventh x)))
		`($while ,(cadr (seventh x))))
	       (t `($unless ,(seventh x))))
	 `($do ,(eighth x))))



