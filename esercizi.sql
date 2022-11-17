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

/*7- titolo o genere dei film proiettati nelle sale di Napoli il giorno di natale del 2004*/
SELECT
    film.titolo, film.genere
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