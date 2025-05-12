Beccacece Aron Davis 856480

# Interval Arithmetic #

- Libreria di Prolog che implementa le operazioni fondamentali dell'aritmetica degli intervalli e il metodo di Newton.-

--I seguenti predicati sono necessari per gestire i numeri reali estesi.

plus e(0) 
plus e(X, Result) 
plus e(X, Y, Result)
Il predicato plus e/1 è vero con l'unità dell'operazione di somma.
Il predicato plus e/2 è vero quando Result è un reale esteso che si unifica con X. X deve essere istanziato e deve essere un reale esteso. In caso contrario, il predicato fallisce.
Il predicato plus e/3 è vero quando Result è la somma reale estesa di X e Y, che devono entrambi essere reali estesi istanziati. In caso contrario, il predicato fallisce.

minus e(X, Result)
minus e(X, Y, Result)
Il predicato minus e/2 è vero quando Result è un reale esteso che è il reciproco di X rispetto alla somma. X deve essere istanziato e deve essere un reale esteso. In caso contrario, il predicato fallisce.
Il predicato minus e/3 è vero quando Result è la sottrazione reale estesa di Y da X, che devono entrambi essere reali estesi istanziati. In caso contrario, il predicato fallisce.

times e(1)
times e(X, Result)
times e(X, Y, Result)
Il predicato times e/1 è vero con l'unità dell'operazione di somma.
Il predicato times e/2 è vero quando Result è un reale esteso che si unifica con X. X deve essere istanziato e deve essere un reale esteso. In caso contrario, il predicato fallisce.
Il predicato times e/3 è vero quando Result è la moltiplicazione reale estesa di X e Y, che devono entrambi essere reali estesi istanziati. In caso contrario, il predicato fallisce.

div e(X, Result)
div e(X, Y, Result)
Il predicato div e/2 è vero quando Result è un reale esteso che è il reciproco di X rispetto alla moltiplicazione. X deve essere istanziato e deve essere un reale esteso. In caso contrario, il predicato fallisce.
Il predicato div e/3 è vero quando Result è la sottrazione reale estesa di Y da X, che devono entrambi essere reali estesi istanziati. In caso contrario, il predicato fallisce.

--I seguenti predicati sono la base per le operazioni di aritmetica degli intervalli.

empty interval([])
Questo predicato è vero solo per l'intervallo vuoto [].

interval([])
interval(X, SI)
interval(L, H, I)
Il predicato interval/1 serve a costruire un intervallo vuoto.
Il predicato interval/2 costruisce un intervallo singleton SI che contiene solo X. X deve essere istanziato e deve essere un reale esteso; altrimenti, il predicato fallisce.
Il predicato interval/3 costruisce un intervallo I con L come punto inferiore e H come punto superiore. L e H devono essere istanziati e devono essere reali estesi; altrimenti, il predicato fallisce. Si noti che I può essere l'intervallo vuoto se L > H.

is interval(I)
Il predicato is interval/1 è vero se I è un termine che rappresenta un intervallo (incluso l'intervallo vuoto e possibilmente intervalli disgiunti).

whole interval(R)
Il predicato whole interval/1 è vero se R è un termine che rappresenta l'intervallo intero R.

is singleton(S)
Il predicato is singleton/1 è vero se S è un termine che rappresenta un intervallo singleton.

iinf(I, L)
Il predicato iinf/2 è vero se I è un intervallo non vuoto e L è il suo limite inferiore.

isup(I, H)
Il predicato isup/2 è vero se I è un intervallo non vuoto e H è il suo limite superiore.

icontains(I, X)
Se I non è un intervallo, o se è un intervallo vuoto, il predicato fallisce. Altrimenti, dato l'intervallo I, avrà successo se I contiene X. X può essere un numero o un altro intervallo.

ioverlap(I1, I2)
Il predicato ioverlaps ha successo se i due intervalli I1 e I2 si “sovrappongono”. Il predicato fallisce se I1 o I2 non è un intervallo.

--I seguenti predicati implementano le operazioni di aritmetica degli intervalli. è necessario tenere conto degli intervalli disgiunti in ogni operazione;
cioè, la somma di due intervalli disgiunti è, molto probabilmente, un intervallo disgiunto.

iplus(ZI)
iplus(X, R)
iplus(X, Y, R)
Il predicato iplus/1 è vero se ZI è un intervallo non vuoto.
Il predicato iplus/2 è vero se X è un intervallo non vuoto istanziato e R si unifica con esso, oppure se X è un reale esteso istanziato e R è un intervallo singleton contenente solo X.
Il predicato iplus/3 è vero se X e Y sono intervalli non vuoti istanziati e R è l'intervallo costruito secondo la tabella di sommazione per due intervalli non vuoti. Se X o Y sono reali estesi istanziati, vengono prima trasformati in intervalli singleton.
In tutti gli altri casi, i predicati falliscono.

iminus(X, R)
iminus(X, Y, R)
Il predicato iminus/2 è vero se X è un intervallo non vuoto istanziato e R si unifica con il suo reciproco rispetto all'operazione di sommazione. Se X è un reale esteso, viene prima trasformato in un intervallo singleton.
Il predicato iminus/3 è vero se X e Y sono intervalli non vuoti istanziati e R è l'intervallo costruito secondo la tabella di sottrazione per due intervalli non vuoti. Se X o Y sono reali estesi istanziati, vengono prima trasformati in intervalli singleton.
In tutti gli altri casi, i predicati falliscono.

itimes(ZI)
itimes(X, R)
itimes(X, Y, R)
Il predicato itimes/1 è vero se ZI è un intervallo non vuoto.
Il predicato itimes/2 è vero se X è un intervallo non vuoto istanziato e R si unifica con esso, oppure se X è un reale esteso istanziato e R è un intervallo singleton contenente solo X.
Il predicato itimes/3 è vero se X e Y sono intervalli non vuoti istanziati e R è l'intervallo costruito secondo la tabella di moltiplicazione per due intervalli non vuoti. Se X o Y sono reali estesi istanziati,
vengono prima trasformati in intervalli singleton. In tutti gli altri casi, i predicati falliscono.

idiv(X, R)
idiv(X, Y, R)
Il predicato idiv/2 è vero se X è un intervallo non vuoto istanziato e R si unifica con il suo reciproco rispetto all'operazione di moltiplicazione. Se X è un reale esteso, viene prima trasformato in un intervallo singleton.
Il predicato idiv/3 è vero se X e Y sono intervalli non vuoti istanziati e R è l'intervallo costruito secondo la tabella di divisione per due intervalli non vuoti. Se X o Y sono reali estesi istanziati, vengono prima trasformati in intervalli singleton.
In tutti gli altri casi, i predicati falliscono.

--Il Metodo di Newton per Trovare la Radice di una Funzione
Una delle applicazioni dell'aritmetica degli intervalli è trovare un intervallo che contenga gli zeri di una funzione.

metodo_newton(F, f, a, I, Result)
Il predicato restituisce il punto dove la funzione F è zero.

--Funzioni ausiliarie:
getiinf(X, R)
getisup(X, R)
set_extension(F, I, R)
interval_intersection(X, Y, R)
f(X, Y)
f-deriv(X, Y)