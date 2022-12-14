/*1 - tutte le sale di Pisa*/
SELECT *
FROM sale
WHERE sale.citta = 'Roma'

/*2 - titolo dei film di "F. Fellini" prodotti post 1960*/
SELECT film.titolo
FROM film
WHERE regista = 'F. Fellini'
AND annoproduzione > 1960

/*3 - titolo dei film di fantascienza giapponesi o francesi prodotti dopo il 1990*/

SELECT titolo, genere, nazionalita, annoproduzione
FROM film
WHERE 
    (film.nazionalita LIKE '_iapponese'
    OR
        film.nazionalita LIKE '_rancese')
AND
    film.annoproduzione > 1990
AND
    film.genere LIKE '%_antascienza%'

/*4 - titolo dei film di fantascienza giapponesi prodotti dopo il 1990* e tutti i film francesi*/

SELECT titolo
FROM film
WHERE 
    (film.genere LIKE '%_antascienza%'
    AND
        film.nazionalita LIKE '_iapponese'
    AND
       film.annoproduzione > 1990)
OR
    film.nazionalita LIKE '_rancese'

/*5 - titoli dei film dello stesso autore di "Casablanca"*/
SELECT film.titolo
FROM film
WHERE film.regista IN 
    (SELECT film.regista
    FROM film
    WHERE film.titolo = 'Casablanca');

/*6 - titolo o genere dei film proiettati nelle sale il giorno di natale del 2004*/
SELECT
    film.titolo, film.genere
FROM 
    film
WHERE 
    codfilm  IN
        (SELECT codfilm
        FROM proiezioni AS P
        WHERE P.dataproiezione = '2004-12-25')

/*7- titolo e genere dei film proiettati nelle sale di Napoli il giorno di natale del 2004*/
SELECT film.titolo, film.genere
FROM 
    film
WHERE 
    codfilm  IN
        (SELECT codfilm
        FROM proiezioni AS P
            JOIN sale AS S
                ON P.codsala = S.codsala
        WHERE P.dataproiezione = '2004-12-25'
        AND S.citta = 'Napoli')

/*8- nomi delle sale di Napoli in cui il giorno di natale 2004 è stato proiettato un film con "R.Williams" */


SELECT sale.nome
FROM sale
WHERE sale.codsala IN (
    SELECT P.codsala
    FROM proiezioni AS P
    WHERE P.dataproiezione = '2004-12-25'
    AND P.codfilm IN (
        SELECT 
        film.codfilm
        FROM 
        film 
        JOIN recita 
            ON film.codfilm = recita.codfilm 
        JOIN attori 
            ON recita.codattore = attori.codattore
        WHERE attori.nome = 'R. Williams'
))

/*9- Titolo dei film in cui recitano "M. Mastroianni" oppure "S. Loren"*/
SELECT film.titolo
FROM 
    film
    JOIN recita AS R
        ON film.codfilm = R.codfilm
    JOIN attori AS A
        ON R.codattore = A.codattore
WHERE A.nome = 'M. Mastroianni'
OR A.nome = 'S. Loren'

/*10- Titolo dei film in cui recitano "M. Mastroianni" e "S. Loren"*/
SELECT film.titolo
FROM 
    film
    JOIN recita AS R
        ON film.codfilm = R.codfilm
    JOIN attori AS A
        ON R.codattore = A.codattore
WHERE A.nome = 'M. Mastroianni'
AND A.nome = 'S. Loren'

/*11- per ogni film in cui recita un attore francese, titolo del film e nome dell'attore*/
SELECT film.titolo, A.nome
FROM 
    film
    JOIN recita AS R
        ON film.codfilm = R.codfilm
    JOIN attori AS A
        ON R.codattore = A.codattore
WHERE A.nazionalita LIKE '_rancese';

/*12- per ogni film che è stato proiettato a pisa nel gennaio 2005, titolo del film e nome della sala*/
SELECT film.titolo, sale.nome
FROM 
    proiezioni AS P
    JOIN film
        ON P.codfilm = film.codfilm
    JOIN sale
        ON sale.codsala = P.codsala
WHERE sale.citta = 'Pisa'
AND EXTRACT(MONTH FROM P.dataproiezione) = '01'
AND EXTRACT(YEAR FROM P.dataproiezione) = '2005';

/*13- numero di sale a Pisa con più di 60 posti*/
SELECT count(*) AS n_sale_grandi_a_pisa
FROM sale
WHERE sale.posti > 60
AND sale.citta = 'Pisa'

/*14- numero totale di posti a Pisa*/
SELECT sum(sale.posti) AS totale
FROM sale
WHERE sale.citta = 'Pisa'

/*15- per ogni città il numero delle sale*/
SELECT sale.citta, sum(sale.posti) AS totale_posti
FROM sale
GROUP BY sale.citta

/*16- per ogni città il numero di sale con più di 60 posti*/
SELECT sale.citta, count(*) AS tot_sale_grandi
FROM sale
WHERE sale.posti > 60
GROUP BY sale.citta 

/*17- per ogni regista il numero di film diretti dopo il 1990*/
SELECT F.regista, count(*) AS tot_film
FROM film AS F
WHERE F.annoproduzione > 1990
GROUP BY F.regista

/*18- per ogni regista l'incasso totale di tutte le proiezioni dei suoi film*/
SELECT F.regista, sum(P.incasso)
FROM film AS F
    JOIN proiezioni AS P
        ON F.codfilm = P.codfilm
GROUP BY F.regista

/*19- per ogni film di S.Spielberg, il titolo del film, il numero totale di proiezioni a Pisa  e l'incasso totale*/

SELECT 
    F.titolo, 
    count(*) AS num_proiezioni_pisane,
    sum(P.incasso)*count(*) AS tot_incasso_pisano
FROM 
    film AS F 
    JOIN proiezioni AS P 
        ON F.codfilm = P.codfilm 
    JOIN sale AS S 
        ON S.codsala = p.codsala
WHERE 
    F.regista LIKE '%pielberg'
AND 
    S.citta = 'Pisa'
GROUP BY 
    F.titolo