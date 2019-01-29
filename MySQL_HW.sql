-- PLEASE READ BEFORE CONTINUING: To shorten the amount to read for each problem, the general steps taken for each problem will be listed 
-- here and the problem-specific steps will be notated with each related problem. The general steps here will each be assigned a number and
-- the number(s) that represent the general steps will be listed in the appropriate position in each problem. 
	-- Example: 1 = Use SELECT to specify the columns of interest and fetch the desired data 2 = Use * to select all of the columns in the 
	-- 			table when using SELECT
	-- 			3 = Use FROM to reference the source table
	-- 			Problem: Display all column values in x_table using the customer's first name, 'Bob'
    -- 			Notes in problem: -- 1, 2, 3. Use WHERE to filter the column values by setting first_name equal to 'Bob'
	-- 			The above note is equivalent to: Use SELECT to fetch all desired data (represented by 1), Use * to select all of the columns
    -- 			in the table when using SELECT (represented by 2), Use FROM to reference the source table (represented by 3). Use WHERE to
    -- 			filter the column values by setting first_name equal to 'Bob'
--  create gameplan: 
	-- notate column names in each table to view everything we may need in one area and select the columns necessary to execute our objective(s)


-- Use USE to tell MySQL Workbench to use the data from the sakila schema
USE sakila;

-- Preview first 10 rows to confirm information column titles may not suggest (ex. first_name and last_name column values are all 
-- capitalized). Use SELECT to fetch the desired data, * to select all of the columns in the table, FROM to reference the source table, and
-- LIMIT to display only the first 10 rows
SELECT * FROM actor LIMIT 10;

-- 1a) Display the first and last names of all actors from the actor table
-- Use SELECT to fetch the desired data, specify first_name and last_name to fetch only the data associated with the first_name and
-- last_name columns and FROM to reference the source table
SELECT first_name, last_name FROM actor;

-- 1b)  Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
-- USE SELECT to fetch the desired data. Use CONCAT to merge string values and ' ' to put a space between the first names and last names.
-- Use AS to create the column's name and FROM to reference the source table
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

-- 2a) 2a. Find the ID number, first name, and last name of an actor when we only know the first name is "Joe."
-- Use SELECT to fetch the desired data, specify the actor_id, first_name, and last_name to fetch only the data associated with those
-- columns. Use FROM to reference the source table and use WHERE to filter the results in the first_name column to display only the
-- rows that have the string value Joe
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'JOE';

-- 2b) Find all actors whose last name contain the letters 'GEN' 
-- Use SELECT to fetch the desired data, * to select all columns in the table, WHERE to filter the results in the last_name column using %%
-- as wildcards
SELECT * FROM actor WHERE last_name LIKE '%GEN%';

-- 2c) Find all actors whose last names contain the letters LI. Order the rows by last name and first name, respectively
-- The rows will be sorted by last name first, and the corresponding first names afterward
SELECT * FROM actor WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d) Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
SELECT country_id, country FROM country WHERE country IN('Afghanistan', 'Bangladesh', 'China');

SELECT * FROM country;

-- 3a) create a column in the table actor named description and use the data type BLOB
ALTER TABLE actor
ADD COLUMN description BLOB;

SELECT * FROM actor;

SET SQL_SAFE_UPDATES = 0;

-- DELETE FROM actor WHERE description;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM actor;

-- Delete the description column
ALTER TABLE actor DROP COLUMN description;

SELECT * FROM ACTOR;

SELECT last_name FROM actor;

#SELECT UNIQUE(last_name) FROM actor; <--------------question for class. other than common use syntax, is there a disadvantage of using '#' for notes?

-- SELECT COUNT(last_name) FROM actor;

-- SELECT last_name.COUNT(*) AS lastn_uc FROM actor GROUP BY last_name; -- HAVING lastn_uc>1;

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

-- 7f. Write a query to display how much business, in dollars, each store brought in



SELECT * FROM store;
SELECT * FROM inventory;
SELECT * FROM customer;
SELECT * FROM payment;
SELECT * FROM film_category;
SELECT * FROM rental;


-- film category columns: film_id, category_id, last_update
-- rental columns: rental_id, rental_date, inventory_id, customer_id, staff_id, (dates)
		-- rental_id, inventory_id, customer_id, staff_id
-- inventory columns: inventory_id, film_id, store_id, last_update
		-- store_id, inventory_id, film_id
        
                
-- 7f. Write a query to display how much business, in dollars, each store brought in

-- store columns: store_id, manager_staff_id, address_id, last_update
		-- store_id, address_id
-- payment columns: payment_id, customer_id, staff_id, rental_id, amount, (dates)
		-- payment_id, customer_id, rental_id, amount

-- customers columns: customer_id, store_id, first_name, last_name, email, address_id, (active and dates)
		-- store_id, customer_id, address_id

-- store and customer using address_id
-- payment and customer using store_id



SELECT store_id, SUM(amount) AS total_business FROM payment WHERE customer_id IN
(SELECT customer_id FROM customer WHERE store_id IN
(SELECT store_id FROM store WHERE store_id=1));


SELECT DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME IN ('')
AND TABLE_SCHEMA = 'sakila';

SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;


SELECT * FROM sales_by_store;

-- store name = city, country
-- store.address_id = 1, 2
-- address.address_id=address.city_id = store.1 = 300, store.2 = 576
-- city.1 = Lethbridge...city.2 = Woodridge...country_id.1 = 20 ...country_id2 = 8
-- country.1 = Canada...country.2 = Australia
-- store_id = 1 is Lethbridge, Canada...store_id = 2 is Woodridge, Australia













-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM payment;
SELECT * FROM store; 
SELECT * FROM inventory;
SELECT * FROM rental;


-- inventory columns: inventory_id, film_id, store_id, last_update
		-- store_id
-- rental columns: rental_id, inventory_id, customer_id, (staff and dates)
  
-- 1) -- store columns: store_id, manager_staff_id, address_id, last_update
		-- store_id
-- 2) customer columns: customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
		-- customer_id, store_id
-- 3) payment columns: payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
		-- customer_id, amount 

        
SELECT store_id, SUM(amount) AS total_business FROM payment 
WHERE store_id IN
(SELECT customer_id FROM customer 
WHERE store_id IN 
(SELECT store_id FROM store)
);


-- GROUP BY store_id;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
