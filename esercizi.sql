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