#) All films with PG-13 films with rental rate of 2.99 or lower
SELECT * FROM sakila.film AS f 
WHERE f.rating = "PG-13" 
AND f.rental_rate<=2.99;

#) All films that have deleted scenes
SELECT * FROM sakila.film AS f 
WHERE f.special_features LIKE "%Deleted Scenes%";

#) All active customers
SELECT COUNT(*) FROM sakila.customer WHERE active=1;

#) Names of customers who rented a movie on 26th July 2005
SELECT c.first_name , c.last_name, r.rental_date FROM sakila.rental AS r 
JOIN customer c ON c.customer_id = r.customer_id 
WHERE date(r.rental_date) = "2005-07-26";

#) Distinct names of customers who rented a movie on 26th July 2005
SELECT distinct c.first_name FROM sakila.rental AS r 
JOIN customer c ON c.customer_id = r.customer_id 
WHERE date(r.rental_date) = "2005-07-26";

#) How many distinct last names we have in the data?
SELECT c.last_name FROM sakila.customer AS c;
SELECT * FROM sakila.customer ORDER BY last_name;
SELECT COUNT(distinct last_name) FROM customer;

#) How many rentals we do ON each day?
SELECT date(rental_date) d, COUNT(rental_date) FROM rental group by date(rental_date) ORDER BY COUNT(rental_date) desc limit 1;
SELECT * FROM rental;


#) All Sci-fi films in our catalogue
SELECT c.*, f.film_id , fi.title FROM category c 
JOIN film_category f ON f.category_id = c.category_id
JOIN film fi ON fi.film_id = f.film_id
WHERE c.name = "Sci-Fi";


#) Name of customers and how many movies they rented from us so far?
SELECT r.customer_id ,concat(c.first_name,' ',c.last_name ) 'Full Name' ,COUNT(r.customer_id) FROM sakila.rental r 
JOIN customer c ON c.customer_id=r.customer_id
group by r.customer_id
ORDER BY COUNT(r.customer_id) desc;

#) Which movies should we discontinue from our catalogue (less than 5 lifetime rentals)
SELECT f.title, COUNT(r.rental_id) AS rental_COUNT
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) < 3;


