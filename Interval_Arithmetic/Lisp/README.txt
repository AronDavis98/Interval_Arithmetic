Beccacece Aron Davis 856480

# Interval Arithmetic #

- Libreria di Lisp che implementa le operazioni fondamentali dell'aritmetica degli intervalli e il metodo di Newton.-

--Le seguenti funzioni sono necessarie per gestire i numeri reali estesi.

Funzione +e (&optional x y) → risultato
Questa è la funzione di somma che prende x e y come valori sui numeri reali estesi secondo la tabella sopra. La funzione chiamata senza argomenti restituisce 0, cioè l'unità rispetto all'operazione di sommazione. 
La funzione deve chiamare error quando la combinazione dei valori di x e y corrisponde a ⊥ nella tabella.

Funzione -e (x &optional y) → risultato
Questa è la funzione di sottrazione che prende x e y come valori sui numeri reali estesi secondo la tabella sopra. La versione unaria è il reciproco di x rispetto alla sommazione secondo la tabella di sommazione. 
La funzione deve chiamare error quando la combinazione dei valori di x e y corrisponde a ⊥ nella tabella.

Funzione *e (&optional x y) → risultato
Questa è la funzione di moltiplicazione che prende x e y come valori sui numeri reali estesi secondo la tabella sopra. La funzione chiamata senza argomenti restituisce 1, cioè l'unità rispetto all'operazione di moltiplicazione. 
La funzione deve chiamare error quando la combinazione dei valori di x e y corrisponde a ⊥ nella tabella.

Funzione /e (x &optional y) → risultato
Questa è la funzione di divisione che prende x e y come valori sui numeri reali estesi secondo la tabella sopra. La versione unaria è il reciproco di x rispetto all'operazione di moltiplicazione secondo la tabella di moltiplicazione. 
La funzione deve chiamare error quando la combinazione dei valori di x e y corrisponde a ⊥ nella tabella.

--Le seguenti funzioni costituiscono la base per le operazioni di aritmetica degli intervalli. 

Funzione interval (&optional l h) → i
Questa funzione è il principale costruttore per un intervallo. La funzione interval chiama error se, quando viene passata, l o h non sono numeri reali.

Funzione whole-interval () → whole
Il risultato è una rappresentazione dell'intero intervallo pieno.

Funzione is-interval (x) → boolean
Questa funzione restituisce T se x è un intervallo (semplice o disgiunto); altrimenti restituisce NIL.

Funzione is-empty (x) → boolean
La funzione is-empty restituisce T se x è l'intervallo vuoto, oppure NIL se è un intervallo non vuoto. Dovrebbe chiamare la funzione error se x non è un intervallo.

Funzione is-singleton (x) → boolean
La funzione is-singleton restituisce T se x è un intervallo singleton che contiene esattamente un numero. Altrimenti, dovrebbe restituire NIL. 
Dovrebbe chiamare la funzione error se x non è un intervallo.

Funzione inf (i) → l
Se i non è un intervallo, o se è un intervallo vuoto, la funzione dovrebbe chiamare la funzione error. Altrimenti, restituisce l.

Funzione sup (i) → h
Se i non è un intervallo, o se è un intervallo vuoto, la funzione dovrebbe chiamare la funzione error. Altrimenti, restituisce h.

Funzione contains (i, x) → boolean
Se i non è un intervallo, o se è un intervallo vuoto, la funzione dovrebbe chiamare la funzione error. Altrimenti, dato l'intervallo i, restituirà T se i contiene x. x può essere un numero o un altro intervallo.

Funzione overlap (i1, i2) → boolean
La funzione overlap restituisce un valore non NIL se i due intervalli i1 e i2 “si sovrappongono”. La funzione error viene chiamata se i1 o i2 non sono intervalli.

--Le seguenti funzioni implementano le operazioni di aritmetica degli intervalli.

Funzione i+ (&optional x y) → intervallo
La funzione i+ restituisce la somma di due intervalli. Se chiamata senza argomenti, restituisce l'intervallo singleton . 
Se x o y, quando passati, sono numeri reali, vengono prima trasformati nel corrispondente intervallo singleton. 
Se x o y, quando passati, non sono numeri reali o intervalli, viene chiamata la funzione error. 
La funzione error dovrebbe essere chiamata ogni volta che l'operazione è indefinita.

Funzione i- (x &optional y) → intervallo
La funzione i- restituisce la sottrazione di due intervalli. Se chiamata con un solo argomento, restituisce l'intervallo reciproco secondo l'operazione di sommazione. 
Se x o y, quando passati, sono numeri reali, vengono prima trasformati nel corrispondente intervallo singleton. 
Se x o y, quando passati, non sono numeri reali o intervalli, viene chiamata la funzione error. 
L'intervallo risultante è calcolato secondo le regole presentate nella tabella appropriata; la funzione error dovrebbe essere chiamata ogni volta che l'operazione è indefinita.

Funzione i* (&optional x y) → intervallo
La funzione i* restituisce la moltiplicazione di due intervalli. Se chiamata senza argomenti, restituisce l'intervallo singleton. 
Se x o y, quando passati, sono numeri reali, vengono prima trasformati nel corrispondente intervallo singleton. 
Se x o y, quando passati, non sono numeri reali o intervalli, viene chiamata la funzione error. 
La funzione error dovrebbe essere chiamata ogni volta che l'operazione è indefinita.

Funzione i/ (x &optional y) → intervallo
La funzione i/ restituisce la divisione di due intervalli. Se chiamata con un solo argomento, restituisce l'intervallo reciproco secondo l'operazione di moltiplicazione. 
Se x o y, quando passati, sono numeri reali, vengono prima trasformati nel corrispondente intervallo singleton. Se x o y, quando passati, non sono numeri reali o intervalli, viene chiamata la funzione error. 
La funzione error dovrebbe essere chiamata ogni volta che l'operazione è indefinita. Può restituire un intervallo disgiunto.

--Il Metodo di Newton per Trovare la Radice di una Funzione
Una delle applicazioni dell'aritmetica degli intervalli è trovare un intervallo che contenga gli zeri di una funzione.

metodo_newton(F, f, a, I, Result) → Result
Il predicato restituisce il punto dove la funzione F è zero.

--Funzioni ausiliarie:
print-interval
set-extension(F, I, R)
interval-intersection(X, Y, R)
f(X, Y)
f-deriv(X, Y)