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