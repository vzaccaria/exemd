# Profilo argine

La seguente figura mostra l’andamento del profilo dell’argine di un fiume `p(m)` in funzione della distanza dalla foce `m`:

```{ditaa ! }
p(m)  +                                                      
      |                                                      
      |                                       XXXX           
      |                                    XXXX  XX          
      |                                   XX                 
      |                                  XX                  
      |                                 XX                   
      |                                XX                    
      |                               XX                     
      |                              XX                      
      | XXXXXXXXX                   XX                       
      |         XXXX               XX                        
      |            XXXX           XX                         
      |               XXXXXX   XXXX                          
      |                    XXXXX                             
      |                                                      
      |                                                      
      |                                                      
      |                                                      
      +----------------------------------------------+       
                                                             
                                                      m      
```

Come si nota, l’argine presenta altezze diverse nei vari punti del fiume. Si supponga che il fiume scorra in piano lungo tutto il suo percorso (non ci sono quindi salti di livello). 

Si chiede di sviluppare in Matlab/Octave una funzione `calcolaRischio` che sia in grado di identificare e restituire al chiamante i punti dell’argine a rischio di esondazione in giornata, in base a:

1.  profilo dell’argine `p(m)`: vettore contenente l'altezza dell'argine in metri rispetto al fondo del letto del fiume a distanza `m` dalla foce (nella precedente figura i dati contenuti in `p(m)`sono cerchiati)

2.  l’altezza attuale `a` del fiume (in metri) rispetto al fondo del letto del fiume (sempre considerando la distanza dalla foce `m`).

3.  quanti millimetri `mil` di pioggia fara' durante la giornata (al massimo).

Ovviamente i punti dell’argine a rischio di esondazione in giornata sono quelli in cui l’altezza dell’argine è minore dell’altezza massima che può raggiungere il fiume.


1. Si scriva il codice della funzione `calcolaRischio`: 

    ```octave
    function pr = calcolaRischio(p, a, mil)
             pr = find(p <= a + (mil / 1000));
    ```

3. Si costruisca uno script che: 

    * carica da un file ascii `profiloArgine.txt` (contenente un numero per ogni riga) i dati relativi alle altezze dell’argine del fiume nei vari punti (ovvero `p(m)`).
    
    * chiede all’utente l’altezza attuale del fiume `a` e la previsione di incremento giornaliero totale di altezza del fiume in base alla pioggia prevista `mil`.
    
    * genera una tabella `tab` contenente, per ciascun punto in cui puo' avvenire una esondazione, il minuto in cui questa potra' avvenire.
   
    ```octave
     load('profiloArgine.txt');
     a      = input('Altezza attuale: ');
     mil    = input('Incremento totale previsto millimetri: ');
     
     pr     = calcolaRischio(p, a, mil) ;
     
     minuti = 1000 * 24 * 60 * (p - a) / mil;
     tab    = [ p’ minuti’ ];
     tab    = tabella(punti, :)
    ``` 



# Codice ISBN

Il codice ISBN è una sequenza numerica di 13 cifre usata internazionalmente per la classificazione dei libri. 
L'ultima cifra del codice ISBN svolge una funzione di controllo e viene calcolata con il seguente algoritmo:

* si moltiplica ognuna delle prime 12 cifre per un peso definito in base alla posizione della cifra stessa nella sequenza: la prima cifra si moltiplica per 1, la seconda per 3, la terza per 1, la quarta per 3 e così via

* si sommano i risultati delle 12 moltiplicazioni

* si divide la somma per 10 e si prende il resto della divisione

* si sottrae il resto della divisione da 10: la cifra che si ottiene è la cifra di controllo, ovvero la 13-esima cifra del codice ISBN.


Si risponda ai seguenti quesiti:

1. Implementare in linguaggio Matlab una funzione `controllo` che riceve in ingresso un vettore numerico contenente le prime 12 cifre di un codice ISBN e ritorna la corrispondente 13-esima cifra di controllo.

    Esempio:

        controllo([9 7 8 8 8 4 3 0 2 5 3 4])
        
    ritorna 3 poichè: 
    
        9*1 + 7*3 + 8*1 + 8*3 + 8*1 + 4*3 + 3*1 + 0*3 + 2*1 + 5*3 + 3*1 + 4*3 = 117
        117 mod 10 = 7
        10 - 7 = 3
    
    **Spazio soluzione:**
    
      ```octave
          function c = controllo(a)
               s = sum(a(1:2:12)) + sum(3 * a(2:2:12));
               c = 10 - mod(s,10);
      ```


2. Implementare in linguaggio Matlab una funzione `verifica` che riceve in ingresso un vettore numerico contenente le 13 cifre di un codice ISBN e ritorna `true` se la cifra di controllo è corretta, `false` altrimenti.

    Esempio:

        verifica([9 7 8 8 8 4 3 0 2 5 3 4 3]) 

    ritorna `true` dato che, come visto sopra, la cifra di controllo corretta per l’input considerato è 3.

    **Spazio soluzione:**
    
      ```matlab
      function r = verifica(a)
         r = a(13) == controllo(a(1:12));
      ```




# Precipitazione

Sia dato un array definito in Matlab e contenente le informazioni riguardanti le precipitazioni registrate da una stazione meteorologica. Ogni elemento dell'array `dati` è una `struct` che contiene un campo numerico `giorno`, un campo numerico `mese`, un campo numerico `anno`, e un campo numerico `mm` che rappresenta la quantità di pioggia (in mm) caduta nella data specificata dai precedenti campi. 

Ad esempio, per memorizzare nell'array `dati` che il 3 giugno 2013 sono stati registrati 15 mm di pioggia si avrà:

```octave
dati(i) = struct("giorno", 3, "mese", 6, "anno", 2013, "mm", 15);
```

## Calcolo media
Scrivere una funzione Matlab `media` che riceva in ingresso l'array `dati` e un parametro numerico `anno`; la funzione deve restituire in uscita un array di 12 elementi che, sulla base del contenuto dell'array `dati`, fornisca il valore medio dei mm di pioggia in ciascun mese dell'anno solare `anno`.

```octave
function stat = media (dati,anno) 
     for i = 1:12 
       idx = find([dati.anno] == anno & [dati.mese] == i);   
       stat(i) = mean([dati(idx).mm]); 
     end
end
```
