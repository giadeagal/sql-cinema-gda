/*1 - tutte le sale di Pisa*/
SELECT *
FROM sale
WHERE sale.citta = 'Roma'

/*2 - titolo dei film di "F. Fellini" prodotti post 1960*/
SELECT *
FROM film
WHERE regista = 'F. Fellini'
AND annoproduzione > 1960