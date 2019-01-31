-- Use USE to tell MySQL Workbench to use the data from the sakila schema
USE sakila;

-- Preview the first 10 rows to detect information that the column titles may not suggest (ex. first_name and last_name column values are
-- all capitalized). Use SELECT to retrieve the desired data, * to select all fields from the table, FROM to specify the table from which 
-- to retrieve the data, and LIMIT to constrain the number of rows returned to the first 10 rows
SELECT * FROM actor LIMIT 10;

-- 1a) Display the first and last names of all actors from the actor table
-- Use SELECT to retrieve the desired data, and specify first_name and last_name to return only the data associated with the first_name and
-- last_name columns. Use FROM to specify the table from which to retrieve the data.
SELECT first_name, last_name FROM actor;

-- 1b)  Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
-- USE SELECT to retrieve the desired data. Use CONCAT to combine string values and ' ' to put a space between the first_name and 
-- last_name values to be combined. Use AS to assign an alias to the column	and FROM to specify the table from which to retrieve the data. 
-- CONCAT_WS can be used as an alternative for CONCAT 
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

-- 2a) 2a. Find the ID number, first name, and last name of an actor when we only know the first name is "Joe."
-- Use SELECT to retrieve the desired data, specify the actor_id, first_name, and last_name to return only the data associated with
-- those columns. Use FROM to specify the table from which to retrieve the data. Use WHERE to filter the results in the first_name column 
-- by a condition, and set first_name equal to 'Joe' to define the condition.
-- rows that have the string value Joe
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'JOE';

-- 2b) Find all actors whose last name contain the letters 'GEN' 
-- Use SELECT to retrieve the desired data, place * in the area directly after SELECT to select all fields from the table, use FROM to
-- specify the table from which to retrieve the data, and use WHERE to filter the results in the last_name column by a condition. Connect 
-- last_name to %GEN% to define the condition. Use the wildcard '%' to match any number of characters, both before and after 'Gen', to 
-- return all last_name values that contain the letters 'GEN'
SELECT * FROM actor WHERE last_name LIKE '%GEN%';

-- 2c) Find all actors whose last names contain the letters LI. Order the rows by last name and first name, respectively
-- Use SELECT to retrieve the desired data, place an * directly after SELECT to select all fields from the table, and use WHERE to filter 
-- the results by a condition. Connect last_name with '%LI%' using LIKE to define the condition, and use the wildcard '%' to match any 
-- number of characters, both before and after 'Li', to return all rows that contain 'Li' in the last_name column. Use ORDER BY to sort
-- the result set by the last_name values and the first name values afterward. Both the last_name column and the first_name column 
-- will be alphabetically sorted from A-Z. The results will be ordered by the last_name column first, and once the last_name column is done
-- sorting itself the first_name column will sort the table that was returned after the last_name column finished sorting. The dual sorting
-- will create a more accurate alphabetically ordered result. When two or more last_name values are the same, ORDER BY last_name does not
-- orders the last_name values randomly. By sorting the first_name column with ORDER BY, the last_name values are assigned a structure that
-- to follow. The corresponding values in the first_name column will determine where the last_name values are placed. The result is the last_name
-- column values are no longer placed randomly in relation to matching values. They have specific areas they must be in contingent upon
-- the corresponding first_name column values which are also sorted alphabetically. 
SELECT * FROM actor WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d) Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
-- Use SELECT to retrieve the desired data, specify country_id and country to return only the data in the columns country_id and country,
-- and use WHERE to filter the results by a condition. Use IN to determine if the specified value, country, matches any value(s) in the
-- set of values that follows IN to define the condition for WHERE.
SELECT country_id, country FROM country WHERE country IN('Afghanistan', 'Bangladesh', 'China');

-- 3a) create a column in the table actor named description and use the data type BLOB
-- Use ALTER TABLE to change the structure of the table actor. Use ADD COLUMN to add a column to actor with the given name, description,
-- assigned right after COLUMN. Place BLOB after the assigned table name to assign the new description column's values the BLOB type
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b) wDelete the description column
ALTER TABLE actor DROP COLUMN description;

SELECT * FROM ACTOR;

SELECT last_name FROM actor;

#SELECT UNIQUE(last_name) FROM actor; <--------------question for class. other than common use syntax, is there a disadvantage of using '#' for notes?

-- SELECT COUNT(last_name) FROM actor;

-- SELECT last_name.COUNT(*) AS lastn_uc FROM actor GROUP BY last_name; -- HAVING lastn_uc>1;
-- 4a) 4a. List the last names of actors, as well as how many actors have that last name
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

-- 4b) List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
-- Use HAVING to filter by a condition; in this case, filter by any last_name value that has a corresponding unique first name count greater than 1
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1;

SELECT * FROM actor;

-- 4c) The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4d) In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. - think of alternative again
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

-- 5a) You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 6a) Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
SELECT first_name, last_name, address
FROM staff
JOIN address ON address.address_id=staff.staff_id;

-- Confirm number of rows we should expect to see after the tables are joined
SELECT * FROM ADDRESS;
SELECT * FROM STAFF;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- UPDATE staff
-- SET picture = NULL
-- WHERE first_name = 'Jon';

SELECT * FROM payment;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment
--           LOOK FOR JON
SELECT first_name, last_name, amount, payment_date
FROM payment
JOIN staff ON staff.staff_id=payment.staff_id
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 8;


-- SELECT payment_date FROM payment WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 8;

-- staff_id = staff_id/staff_id, amount, payment_date, first_name, last_name


-- film columns: film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length
-- replacement_cost, rating, special_features, last_update

-- film actor columns: actor_id, film_id, last_update



-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT title, COUNT(film_actor.actor_id) AS number_of_actors
FROM film
INNER JOIN film_actor ON film.film_id=film_actor.film_id
GROUP BY (film.title);

select * from film;
select * from film_actor;

-- hunchback impossible film id = 439
SELECT * FROM inventory;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system? Answer: 6
-- Retrieve the film_id associated with Hunchback Impossible from the film table. Use SELECT to retrieve the desired data, use COUNT(film_id)
-- to count the number if film_ids by the filter that will be set later in the query, use FROM to reference the source table, and use
-- WHERE to filter the table by the desired condition. In this case we want the count of the film_ids that equal 439 only because film_id
-- 439 represents the film Hunchback Impossible
SELECT COUNT(film_id) FROM inventory WHERE film_id = 439;




-- payment columns: payment_id, customer_id, staff_id, rental_id, amount, payment date, last_update
-- customer columns: customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update

-- 6e)Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name:
SELECT first_name, last_name, SUM(payment.amount) AS total
FROM customer
JOIN payment ON payment.customer_id=customer.customer_id
GROUP BY (last_name) ORDER BY(last_name);


SELECT customer_id, amount FROM payment WHERE customer_id=505;
SELECT * FROM customer;




-- Use subqueries to display the titles of movies starting with the letters K and Q whose 
-- language is English.


-- film columns: film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length
-- replacement_cost, rating, special_features, last_update


-- 7a)Use subqueries to display the titles of movies starting with the letters K and Q whose 
-- language is English.
-- Display the language table to retrieve the lanuageIid that corresponds with English. language_id = 1 = English
SELECT * FROM language;
SELECT * FROM film;

SELECT title, language_id FROM film WHERE (title LIKE 'K%' OR title LIKE 'Q%' AND language_id = 1);



-- 7b. Use subqueries to display all actors who appear in the film Alone Trip
-- Short explanation: We will use a nested subquery within another subquery. Each subquery will determine/define what to filter each column 
-- in the outer query or subquery by. The query's actor_id will be filtered by the actor_ids selected in the first subquery. The first 
-- subquery will be filtered by the selections made in the nested subquery. The nested subquery will filter itself by using WHERE and 
-- setting title equal to 'Alone Trip'. After the second subquery finishes filtering itself it will initiate a reverse domino effect
-- to filter the outer subquery and query.
-- Long explanation: We will use a nested subquery within another subquery. Nested subqueries are run before the outer query or 
-- subquery(s). Use SELECT to get only the name values ... (after long initial explanation) use IN since the subqueries will be returning more than one 
-- value(row). Use SELECT ... and set film_id equal to the nested subquery. Then nested subquery will use the
SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE 
title = 'Alone Trip'));

-- 7c. need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

-- customer columns: customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
		-- address_id, first_name, last_name, email
-- address columns: address_id, address, address2, district, city_id, postal_code, phone, location, last_update
		-- address_id, city_id
-- city columns: city_id, city, country_id, last_update
		-- city_id, country_id
-- country columns: country_id, country, last_update
		-- country_id, country

-- 7c. need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

-- 1) SELECT city_id, country JOIN city.country_id=country.country_id
-- 2) SELECT address_id, country JOIN city.city_id=address.city_id
-- 3) SELECT first_name, last_name, email JOIN address.address_id=customer.address_id GROUP BY country='Canada'

-- 7c. need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT first_name, last_name, email FROM customer
JOIN address ON customer.address_id=address.address_id
JOIN city ON address.city_id=city.city_id
JOIN country ON city.country_id=country.country_id
WHERE country='Canada';


-- SELECT first_name, last_name, email FROM customer
-- JOIN address ON customer.address_id=address.address_id 
-- (SELECT address_id FROM address
-- JOIN city ON address.city_id=city.city_id 
-- WHERE address_id IN
-- (SELECT city_id FROM city
-- JOIN country ON city.country_id=country.country_id
-- WHERE country='Canada')));



-- SELECT first_name, last_name, email FROM customer
-- JOIN address ON customer.address_id=address.address_id 
-- IN
-- (SELECT * FROM address
-- JOIN city ON address.city_id=city.city_id 
-- IN
-- (SELECT * FROM city
-- JOIN country ON city.country_id=country.country_id
-- WHERE country='Canada'));


-- SELECT * FROM customer;
-- SELECT * FROM country;
-- SELECT * FROM address;
-- SELECT * FROM city;


SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

-- film related columns: film_id, title
-- category related columns: category_id, name...SELECT category_id FROM category WHERE name = 'Family'; -- answer = 8
-- film_category related columns: film_id, category_id


-- 7d)  Identify all movies categorized as family films.
SELECT title FROM film WHERE film_id IN (SELECT film_id FROM film_category where category_id IN (SELECT category_id FROM category WHERE
name = 'Family'));

-- 7e. Display the most frequently rented movies in descending order.
SELECT rental_rate FROM film ORDER BY rental_rate DESC;


-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT store, CONCAT('$', total_sales) AS business_total_sales FROM sales_by_store;


-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT * FROM sales_by_store;

-- store name = city, country
-- store.address_id = 1, 2
-- address.address_id=address.city_id = store.1 = 300, store.2 = 576
-- city.1 = Lethbridge...city.2 = Woodridge...country_id.1 = 20 ...country_id2 = 8
-- country.1 = Canada...country.2 = Australia
-- store_id = 1 is Lethbridge, Canada...store_id = 2 is Woodridge, Australia


-- 7g. Write a query to display for each store its store ID, city, and country.
-- store in sales_by_store,	store_id in store,	city in city	country in country

-- sales_by_store columns: 	store, manager, total_sales
-- store columns:			store_id, manager_staff_id, address_id, last_update
-- city columns:			city_id, city, country_id, last_update
-- country columns:			country_id, country, last_update

-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM store
JOIN address
ON store.address_id=address.address_id
JOIN city ON address.city_id=city.city_id
JOIN country ON city.country_id=country.country_id;

-- 7h. List the top five genres in gross revenue in descending order
-- category columns:		category_id, name [of genre], last_update
-- film_category columns:	category_id, film_id, last_update
-- inventory columns:		inventory_id, film_id, store_id, last_update
-- payment columns:			payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
-- rental columns:			rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update

SELECT * FROM category; -- category_id, name
SELECT * FROM film_category; -- category_id, film_id
SELECT * FROM inventory; -- film_id, inventory_id
SELECT * FROM rental; -- inventory_id, rental_id
SELECT * FROM payment; -- rental_id, amount

-- 7h. List the top five genres in gross revenue in descending order

SELECT name, SUM(amount) AS gross_revenue
FROM category
JOIN film_category ON category.category_id=film_category.category_id
JOIN inventory ON film_category.film_id=inventory.film_id
JOIN rental ON inventory.inventory_id=rental.inventory_id
JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
-- Use the solution from the problem above to create a view.
CREATE VIEW top_five_genres AS 
SELECT name, SUM(amount) AS gross_revenue
FROM category
JOIN film_category ON category.category_id=film_category.category_id
JOIN inventory ON film_category.film_id=inventory.film_id
JOIN rental ON inventory.inventory_id=rental.inventory_id
JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8b. How would you display the view that you created in 8a?
SELECT * FROM top_five_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_genres;

SELECT * FROM top_five_genres;