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


-- film columns: film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length,
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

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
-- Retrieve the film_id associated with Hunchback Impossible from the film table. Use SELECT to retrieve the desired data, use COUNT(film_id)
-- to count the number if film_ids by the filter that will be set later in the query, use FROM to reference the source table, and use
-- WHERE to filter the table by the desired condition. In this case we want the count of the film_ids that equal 439 only because film_id
-- 439 represents the film Hunchback Impossible
SELECT COUNT(film_id) FROM inventory WHERE film_id = 439;