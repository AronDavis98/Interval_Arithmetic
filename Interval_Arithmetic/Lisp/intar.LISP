;;;Beccacece Aron Davis 856480

;;Definizioni delle costanti -infinito e +infinito.
(defconstant +neg-infinity+ '+neg-infinity+)
(defconstant +pos-infinity+ '+pos-infinity+)

;;Definizione dell'intervallo vuoto come costante.
(defconstant +empty-interval+ '())

;;empty-interval
;;Funzione che restituisce il simbolo dell'interallo vuoto.
(defun empty-interval ()
  '+empty-interval+)

;;+e
;;Somma per numeri reali estesi.
(defun +e (&optional (x 0) (y 0))
  (cond
    ((and (numberp x) (zerop x) (numberp y) (zerop y)) 0)
    ((or (eql x +pos-infinity+) (eql y +pos-infinity+))
     (if (or (eql x +neg-infinity+) (eql y +neg-infinity+))
         (error "Combinazione non definita: (+pos-infinity+ +neg-infinity+)")
         +pos-infinity+))

    ((or (eql x +neg-infinity+) (eql y +neg-infinity+))
     (if (or (eql x +pos-infinity+) (eql y +pos-infinity+))
         (error "Combinazione non definita: (+neg-infinity+ +pos-infinity+)")
         +neg-infinity+))

    ((and (numberp x) (numberp y))
     (+ x y))

    (t
     (error "Combinazione di valori non definita"))))

;;-e
;;Sottrazione per numeri reali estesi.
(defun -e (x &optional (y 0))
  (cond
    ((and (numberp x) (zerop x) (eql y +pos-infinity+))
     +neg-infinity+)
    ((and (numberp x) (zerop x) (eql y +neg-infinity+))
     +pos-infinity+)

    ((eql x +pos-infinity+)
     (if (eql y +pos-infinity+)
         (error "Combinazione non definita: (+pos-infinity+ - +pos-infinity+)")
         (if (eql y +neg-infinity+)
             +pos-infinity+
             +pos-infinity+)))

    ((eql x +neg-infinity+)
     (if (eql y +neg-infinity+)
         (error "Combinazione non definita: (+neg-infinity+ - +neg-infinity+)")
         (if (eql y +pos-infinity+)
             +neg-infinity+
             +neg-infinity+)))

    ((eql y +pos-infinity+)
     (if (eql x +pos-infinity+)
         (error "Combinazione non definita: (+pos-infinity+ - +pos-infinity+)")
         (if (eql x +neg-infinity+)
             +pos-infinity+
             +neg-infinity+)))

    ((eql y +neg-infinity+)
     (if (eql x +neg-infinity+)
         (error "Combinazione non definita: (+neg-infinity+ - +neg-infinity+)")
         (if (eql x +pos-infinity+)
             +neg-infinity+
             +neg-infinity+)))

    ((and (numberp x) (numberp y))
     (- x y))

    (t
     (error "Combinazione di valori non definita"))))

;;*e
;;Moltiplicazione per numeri reali estesi.
(defun *e (&optional (x 1) (y 1))
  (cond
    ((null x) (if (null y) 1 (*e 1 y)))

    ((or (and (numberp x) (zerop x))
         (and (numberp y) (zerop y)))
     (if (or (eql x +pos-infinity+) (eql x +neg-infinity+)
             (eql y +pos-infinity+) (eql y +neg-infinity+))
         (error "Combinazione non definita: infinito moltiplicato per zero")
         0))

    ((eql x +pos-infinity+)
     (if (or (eql y +pos-infinity+) (eql y +neg-infinity+))
         (if (eql y +pos-infinity+) +pos-infinity+
             +neg-infinity+)
         (if (numberp y)
             (if (zerop y) 
                 (error "Combinazione non definita: infinito moltiplicato per zero")
                 (if (plusp y) +pos-infinity+
                     +neg-infinity+))
             (error "Combinazione non definita"))))

    ((eql x +neg-infinity+)
     (if (or (eql y +pos-infinity+) (eql y +neg-infinity+))
         (if (eql y +pos-infinity+) +neg-infinity+
             +pos-infinity+)
         (if (numberp y)
             (if (zerop y)
                 (error "Combinazione non definita: infinito moltiplicato per zero")
                 (if (plusp y) +neg-infinity+
                     +pos-infinity+))
             (error "Combinazione non definita"))))

    ((eql y +pos-infinity+)
     (if (or (eql x +pos-infinity+) (eql x +neg-infinity+))
         (if (eql x +pos-infinity+) +pos-infinity+
             +neg-infinity+)
         (if (numberp x)
             (if (zerop x)
                 (error "Combinazione non definita: infinito moltiplicato per zero")
                 (if (plusp x) +pos-infinity+
                     +neg-infinity+))
             (error "Combinazione non definita"))))

    ((eql y +neg-infinity+)
     (if (or (eql x +pos-infinity+) (eql x +neg-infinity+))
         (if (eql x +pos-infinity+) +neg-infinity+
             +pos-infinity+)
         (if (numberp x)
             (if (zerop x)
                 (error "Combinazione non definita: infinito moltiplicato per zero")
                 (if (plusp x) +neg-infinity+
                     +pos-infinity+))
             (error "Combinazione non definita"))))

    ((and (numberp x) (numberp y))
     (* x y))

    (t
     (error "Combinazione di valori non definita"))))

;;/e
;;Divisione per numeri reali estesi.
(defun /e (x &optional (y 1))
  (cond
    ((and (numberp y) (zerop y))
     (if (or (eql x +pos-infinity+) (eql x +neg-infinity+))
         (error "Combinazione non definita: infinito diviso per zero")
         (error "Divisione per zero non definita")))

    ((and (or (eql x +pos-infinity+) (eql x +neg-infinity+))
          (or (eql y +pos-infinity+) (eql y +neg-infinity+)))
     (error "Combinazione non definita: infinito diviso per infinito"))

    ((or (eql x +pos-infinity+) (eql x +neg-infinity+))
     (if (numberp y)
         (if (zerop y)
             (error "Combinazione non definita: infinito diviso per zero")
             (if (plusp y) x
                 (if (eql x +pos-infinity+) +neg-infinity+
                     +pos-infinity+)))
         (error "Combinazione non definita")))

    ((or (eql y +pos-infinity+) (eql y +neg-infinity+))
     (if (numberp x)
         (if (zerop x)
             0
             0)
         (error "Combinazione non definita")))

    ((and (numberp x) (numberp y))
     (/ x y))

    (t
     (error "Combinazione di valori non definita"))))

;;interval
;;Crea un intervallo [l, h].
(defun interval (&optional (l +empty-interval+) (h +empty-interval+))
  (cond
    ((and (null l) (null h))
     '+empty-interval+)

    ((and (or (numberp l) (eql l +pos-infinity+) (eql l +neg-infinity+))
          (null h))
     (list l l))

    ((and (or (numberp l) (eql l +pos-infinity+) (eql l +neg-infinity+))
          (or (numberp h) (eql h +pos-infinity+) (eql h +neg-infinity+)))
     (if (or (eql l +neg-infinity+)
             (eql h +pos-infinity+)
             (and (and (numberp l) (numberp h) (<= l h))))
         (list l h)
         '+empty-interval+))

    (t
     (error "Entrambi l e h devono essere numeri reali o infiniti."))))

;;whole-interval
;;Restituisce l'intervallo che rappresenta tutti i numeri reali.
(defun whole-interval ()
  (list +neg-infinity+ +pos-infinity+))

;;is-interval 
;;Restituisce T se x è un intervallo valido o una lista di intervalli validi.
(defun is-interval (x)
  (if (every #'listp x) 
      (every #'is-interval x)  
      (and (listp x)               
           (= (length x) 2)         
           (let ((l (first x))
                 (h (second x)))
             (and (or (numberp l) (eql l +neg-infinity+) (eql l +pos-infinity+))  
                  (or (numberp h) (eql h +neg-infinity+) (eql h +pos-infinity+)) 
                  (or (and (numberp l) (numberp h) (<= l h)) 
                      (and (eql l +neg-infinity+) (eql h +neg-infinity+)) 
                      (and (eql l +pos-infinity+) (eql h +pos-infinity+)) 
                      (and (eql l +neg-infinity+) (numberp h)) 
                      (and (eql h +pos-infinity+) (numberp l)) 
                      (and (eql l +neg-infinity+) (eql h +pos-infinity+))))))))

;;is-empty
;;Restituisce T se x è l'intervallo vuoto.
(defun is-empty (x)
  (cond
    ((equal x '+empty-interval+) T)
    ((is-interval x) NIL)

    (t
     (error "x deve essere un intervallo valido."))))

;;is-singleton
;;Restituisce T se x è un intervallo singleton.
(defun is-singleton (x)
  (cond
    ((is-interval x)
     (let ((l (first x))
           (h (second x)))
       (if (and (numberp l) (numberp h) (eql l h))
           T
           NIL)))

    (t
     (error "x deve essere un intervallo valido."))))

;;inf
;;Restituisce il limite inferiore di un intervallo i.
(defun inf (i)
  (cond
    ((is-empty i)
     (error "L'intervallo è vuoto."))

    ((is-interval i)
     (first i)) 

    (t
     (error "i deve essere un intervallo valido."))))

;;sup
;;Restituisce il limite superiore di un intervallo i.
(defun sup (i)
  (cond
    ((is-empty i)
     (error "L'intervallo è vuoto."))

    ((is-interval i)
     (second i)) 

    (t
     (error "i deve essere un intervallo valido."))))

;;contains
;;Verifica se un numero o un intervallo x è contenuto all'interno dell'intervallo i.
(defun contains (i x)
  (unless (is-interval i)
    (error "i deve essere un intervallo valido."))

  (when (is-empty i)
    (error "L'intervallo è vuoto."))

  (let ((l (inf i))   
        (h (sup i))) 
    (cond
      ((numberp x)
       (and (or (eql l +neg-infinity+) (<= l x)) 
            (or (eql h +pos-infinity+) (<= x h))))

      ((is-interval x)
       (let ((lx (inf x))
             (hx (sup x)))
         (and (or (eql l +neg-infinity+) (<= l lx)) 
              (or (eql h +pos-infinity+) (<= hx h))))) 

      (t (error "x deve essere un numero o un intervallo valido.")))))


;;overlap
;;Restituisce T se gli intervalli i1 e i2 si sovrappongono.
(defun overlap (i1 i2)
  (unless (and (is-interval i1) (is-interval i2))
    (error "Entrambi i parametri devono essere intervalli validi."))

  (when (or (is-empty i1) (is-empty i2))
    (return-from overlap NIL)) 

  (let ((l1 (inf i1)) (h1 (sup i1))  
        (l2 (inf i2)) (h2 (sup i2))) 
    (or (and (or (eql l1 +neg-infinity+) (<= l1 h2)) 
             (or (eql h1 +pos-infinity+) (<= l2 h1))) 
        (and (or (eql l2 +neg-infinity+) (<= l2 h1)) 
             (or (eql h2 +pos-infinity+) (<= l1 h2))))))

;;i+
;;Restituisce la somma di due intervalli.
(defun i+ (&optional (x 0) (y 0))
  (let* ((ix (if (numberp x) (interval x) x))  
         (iy (if (numberp y) (interval y) y)))
    (cond
      ((and (is-interval ix) (is-interval iy))
       (let* ((l1 (inf ix)) (h1 (sup ix)) 
              (l2 (inf iy)) (h2 (sup iy)) 
              (l (+e l1 l2)) 
              (h (+e h1 h2)))
         (interval l h))) 

      (t
       (error "x e y devono essere numeri reali o intervalli validi.")))))

;;i-
;;Restituisce la sottrazione di due intervalli.
(defun i- (x &optional y)
  (let* ((ix (if (numberp x) (interval x) x)) 
         (iy (if (and y (numberp y)) (interval y) y))) 
    (cond
      ((null y)
       (let ((l (-e 0 (inf ix)))  
             (h (-e 0 (sup ix)))) 
         (interval l h))) 

      ((and (is-interval ix) (is-interval iy))
       (let* ((l1 (inf ix)) (h1 (sup ix))  
              (l2 (inf iy)) (h2 (sup iy)) 
              (l (-e l1 h2))  
              (h (-e h1 l2)))  
         (interval l h))) 

      (t
       (error "x e y devono essere numeri reali o intervalli validi.")))))

;;i*
;;Restituisce il prodotto di due intervalli.
(defun i* (&optional (x 1) (y 1))
  (let* ((ix (if (numberp x) (interval x) x)) 
         (iy (if (numberp y) (interval y) y)) 
         (l1 (inf ix)) (h1 (sup ix)) 
         (l2 (inf iy)) (h2 (sup iy)) 
         (p1 (*e l1 l2))
         (p2 (*e l1 h2))
         (p3 (*e h1 l2))
         (p4 (*e h1 h2))
         (products (list p1 p2 p3 p4)))
    (cond
      ((and (member +neg-infinity+ products)
            (member +pos-infinity+ products))
       (interval +neg-infinity+ +pos-infinity+))

      ((member +pos-infinity+ products)
       (interval (apply 'min (remove +pos-infinity+ products))
                 +pos-infinity+))

      ((member +neg-infinity+ products)
       (interval +neg-infinity+ (apply 'max (remove +neg-infinity+ products))))

      (t (interval (apply 'min products) (apply 'max products))))))

;;i/
;;Restituisce il quoziente di due intervalli.
(defun i/ (x &optional y)
  (let* ((x (if (numberp x) (interval x x) x))
         (y (if (and y (numberp y)) (interval y y) y))
         (x-inf (inf x))
         (x-sup (sup x))
         (y-inf (inf y))
         (y-sup (sup y)))

    (unless (and (is-interval x) (or (not y) (is-interval y)))
      (error "I parametri devono essere numeri reali o intervalli validi."))

    (if (null y)
        (i/ (interval 1 1) x) 
	(if (and (contains y 0) (or (equal y-inf +neg-infinity+)(/= y-inf 0)) (or (equal y-sup +pos-infinity+) (/= y-sup 0)))
	    (if (contains x 0)
		(whole-interval)
		(let* ((x-inf (inf x)) (x-sup (sup x))
		       (y-inf (inf y)) (y-sup (sup y))

		       (x-sup-negative (and (not (equal x-sup +pos-infinity+))(< x-sup 0)))
		       (l1 (if x-sup-negative
                               (apply #'max (remove-if-not #'numberp (list (/e x-inf y-sup) (/e x-sup y-sup))))
                               (apply #'max (remove-if-not #'numberp (list (/e x-inf y-inf) (/e x-sup y-inf))))))
		       (l2 (if x-sup-negative
                               (apply #'min (remove-if-not #'numberp (list (/e x-inf y-inf) (/e x-sup y-inf))))
                               (apply #'min (remove-if-not #'numberp (list (/e x-inf y-sup) (/e x-sup y-sup))))))

                       (left-result (interval +neg-infinity+ l1))
                       (right-result (interval l2 +pos-infinity+)))
		  (interval-union left-result right-result)))
            (cond
	      ((equal y-inf 0)
               (cond
		 
		 ((and (or (equal x-inf +neg-infinity+) (< x-inf 0)) (or (equal x-sup +pos-infinity+) (> x-sup 0)))
		  (whole-interval))
		 
		 ((and (not (equal x-inf +neg-infinity+))(>= x-inf 0))
		  (interval (/e x-inf y-sup) +pos-infinity+))

		 ((and (not (equal x-sup +pos-infinity+))(<= x-sup 0))
		  (interval +neg-infinity+ (/e x-sup y-sup)))))

	      ((equal y-sup 0)
	       (cond
		 
		 ((and (or (equal x-inf +neg-infinity+) (< x-inf 0)) (or (equal x-sup +pos-infinity+) (> x-sup 0)))
		  (whole-interval))
		 
		 ((and (not (equal x-inf +neg-infinity+))(>= x-inf 0))
		  (interval +neg-infinity+ (/e x-inf y-inf)))

		 ((and (not (equal x-sup +pos-infinity+))(<= x-sup 0))
		  (interval (/e x-sup y-inf) +pos-infinity+))))

	      (t

	       (let* ((p1 (/e (inf x) (inf y)))  
		      (p2 (/e (inf x) (sup y)))  
		      (p3 (/e (sup x) (inf y)))  
		      (p4 (/e (sup x) (sup y)))  
		      
		      (min-lim (apply #'min (remove-if-not #'numberp (list p1 p2 p3 p4))))
		      (max-lim (apply #'max (remove-if-not #'numberp (list p1 p2 p3 p4)))))
		 
		 (setq min-lim (if (member +neg-infinity+ (list p1 p2 p3 p4)) +neg-infinity+ min-lim))
		 (setq max-lim (if (member +pos-infinity+ (list p1 p2 p3 p4)) +pos-infinity+ max-lim))
		 
		 (interval min-lim max-lim))))

	    )
	)))

;;interval-union
;;Combina due intervalli i1 e i2.
(defun interval-union (i1 i2)
  (let ((l1 (inf i1)) (h1 (sup i1))
        (l2 (inf i2)) (h2 (sup i2)))
    
    (if (> l2 h1)
        (list i1 i2)
	(interval (min l1 l2) (max h1 h2)))))

;;print-interval
;;Funzione di stampa.
(defun print-interval (input)
  (cond
    ((eq input '+empty-interval+)
     (format t "[ ]~%"))
    
    ((and (listp input) (not (null input)) (not (listp (car input))))
     (format t "[~{~a~^ ~}]~%" input))
    
    ((and (listp input) (every #'(lambda (x) (and (listp x) (<= (length x) 2))) input))
     (let ((first (car input))
           (rest (cdr input)))
       (format t "[~{~a~^ ~}]" first)
       (dolist (sublist rest)
         (format t " U [~{~a~^ ~}]" sublist))))
    (t
     (format t "Input non valido~%"))))

;;f
;;Definisce una funzione.
(defun f (x) 
  (- (* x x) 2))

;;f-deriv
;;Definisce una funzione derivata.
(defun f-deriv (x) 
  (* 2 x))

;;metodo-newton
;;Funzione Metodo di Newton.
(defun metodo-newton (f f-deriv a interval)
  (let ((F (set-extension f interval))        
        (F-deriv (set-extension f-deriv interval))) 
    (when (contains (interval-intersection F F-deriv) 0)
      (error "0 è nell'intersezione di F(a) e F'(I), impossibile procedere."))
    
    (let* ((fa (funcall #'f a))                    
           (f-deriv-a (funcall #'f-deriv a))     
           (Na (- a (/ fa f-deriv-a))))           
      
      (let ((risultato (interval-intersection interval (interval Na))))
        risultato))))

;;interval-intersection
;;Restituisce l'intersezione tra due intervalli i1 e i2, se si sovrappongono.
(defun interval-intersection (i1 i2)
  (unless (and (is-interval i1) (is-interval i2))
    (error "Uno o entrambi i parametri non sono intervalli validi."))

  (if (overlap i1 i2)
      (interval (max (inf i1) (inf i2)) (min (sup i1) (sup i2)))
      nil))

;;set-extension
;;Funzione ausiliaria per fissare l'estensione.
(defun set-extension (f interval)
  (let* ((a (car interval))
         (b (cadr interval))
         (min-value (min (funcall f a) (funcall f b))) 
         (max-value (max (funcall f a) (funcall f b)))) 
    (interval min-value max-value)))

