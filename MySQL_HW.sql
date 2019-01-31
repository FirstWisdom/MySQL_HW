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

-- 3a) Create a column in the table actor named description and use the data type BLOB
-- Use ALTER TABLE to change the structure of the table actor. Use ADD COLUMN to add a column to actor with the given name, description,
-- assigned right after COLUMN. Place BLOB after the assigned table name to assign the new description column's values the BLOB type
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b) Use ALTER TABLE to allow changes in the actor table's structure. Use DROP COLUMN to delete the description column in actor.
ALTER TABLE actor DROP COLUMN description;

-- 4a) List the last names of actors, as well as how many actors have that last name
-- Use SELECT to retrieve the desired data, specify last name to return and use the function COUNT() on last name to only return the values
-- in the last_name and the count of each last name. Use FROM to specify the table in which to retrieve the data, and use GROUP BY to
-- divide the rows returned from the SELECT statement into groups. The groups will be grouped by the values in the last_name column.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

-- 4b) List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
-- Use SELECT to retrieve the desired data, specify last name to return and use the function COUNT() on last name to only return the values
-- in the last_name and the count of each last name. Use FROM to specify the table in which to retrieve the data, and use GROUP BY to
-- divide the rows returned from the SELECT statement into groups. The groups will be grouped by the values in the last_name column. Use
-- HAVING to specify the filter conditions for the groups specified in GROUP BY. Use HAVING to define the condition that must be
-- satisfied to run the query; in this case each last_name value returned must have at least more than one actor that have that value.
-- If a last_name value has one or zero actors with the last_name value then the last_name value must not be returned.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1;

-- 4c) The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
-- Use UPDATE to enable modification of the table actor. Use set to specify which column to modify and what to assign the value(s) to. Use
-- WHERE to filter the returned values only if the values satisfy a specified condition. Set first_name equal to 'GROUCHO' and last_name
-- to 'WILLIAMS' to define part of the condition that must be satisfied. Use the boolean operator AND to return the results only if both
-- conditions are true. If at least one of the conditions is false then 'HARPO' will not be changed to 'GROUCHO'.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4d) In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
-- Use UPDATE to enable modification of the table, actor. Use SET to specify which column to modify and what to assign the value(s) to. Use
-- WHERE to filter the returned values only if the values satisfy a specified condition. Set first_name equal to 'HARPO' and last_name
-- to 'WILLIAMS' to define part of the condition that must be satisfied. Use the boolean operator AND to return the results only if both
-- conditions are true. If at least one of the conditions is false then the 'GROUCHO' will not be changed to 'HARPO'.
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

-- 5a) You cannot locate the schema of the address table. Which query would you use to re-create it?
-- Use SHOW CREATE TABLE to return the CREATE TABLE statement that created the table address. Enter what is returned into a schema
-- of your choice.
SHOW CREATE TABLE address;

-- 6a) Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
SELECT first_name, last_name, address
FROM staff
JOIN address ON address.address_id=staff.staff_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment
-- Use SELECT to retrieve the desired data, specify first_name, last_name, amount, and payment_date to return only the data in those
-- columns, and use FROM to specify the table in which to retrieve the data. Use JOIN to link the data between the tables staff and payment,
-- and use ON to specify the column names for the join keys in both tables. Use the syntax table1.column=table2.column to specify the 
-- columns the two tables will be joined on. Use WHERE to filter the results by a condition. Assign the YEAR() function to 2005 to return
-- the year part for a given date and assign the MONTH() function to 8 to return the month of the date to define part of the condition. Use
-- the logical operator AND complete the condition definition and only return the values where both stated conditions are true.
SELECT first_name, last_name, amount, payment_date
FROM payment
JOIN staff ON staff.staff_id=payment.staff_id
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 8;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
-- Use SELECT to retrieve the desired data, specify title and use COUNT() to return only the data in the title column and the count of
-- the actor_ids. Use AS to assign COUNT(film_actor.actor_id) an alias and use the table_name.column_name syntax to make sure the values
-- being counted are coming from the film_actor table. Use FROM the specify the table in which to retrieve the data from, and use INNER 
-- JOIN to select the data that have matching values in both tables. Use ON to specify the column names for join keys in both tables. Use
-- Use the syntax table1.column=table2.column to specify the columns the two tables will be joined on and use GROUP BY to divide the
-- data returned from the SELECT statement into groups of the title column values in the table film.
SELECT title, COUNT(film_actor.actor_id) AS number_of_actors
FROM film
INNER JOIN film_actor ON film.film_id=film_actor.film_id
GROUP BY (film.title);

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system? Answer: 6
-- Retrieve the film_id associated with Hunchback Impossible from the film table to use for the problem.
SELECT * FROM film WHERE title = 'Hunchback Impossible'; 
-- Use SELECT to retrieve the desired data, use COUNT(film_id) to count the number of film_ids, and use FROM to specify the table in which
-- to retrieve the data from. Use WHERE to  by the filter that will be set later in the query, use FROM to reference the source table, and use
-- WHERE to filter the table by a condition and define that condition by setting film_id equal to 439. The only value that satisfied the
-- condition returned the value 6, which means six copies of the film 'Hunchback Impossible' existed in the inventory system. 
SELECT COUNT(film_id) FROM inventory WHERE film_id = 439;

-- 6e)Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
-- Use SELECT to retrieve the desired data. Specify first_name, last_name, and SUM(payment.amount)to retrieve only the data in the columns
-- first_name, last_name, and the sum of the amount values in the payment column. Use AS to assign SUM(payment.amount) the alias total. Use
-- FROM to specify the table in which to retrieve the data from and use JOIN to link the data between the payment and customer tables. Use 
-- ON to specify the column names for join keys in both tables. Set payment.customer_id=customer.customer_id to join the tables on those
-- columns. Use GROUP BY to divide the rows returned from the SELECT statement into groups of last_name values. Use ORDER BY to sort the
-- last_name values alphabetically.
SELECT first_name, last_name, SUM(payment.amount) AS total
FROM customer
JOIN payment ON payment.customer_id=customer.customer_id
GROUP BY (last_name) ORDER BY(last_name);

-- 7a)Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.	
-- Display the language table to retrieve the lanuageIid that corresponds with English. language_id = 1 = English
SELECT * FROM language;
-- Use SELECT to retrieve the desired data, and specify title and language_id to return only data in those columns. Use FROM to specify
-- the table in which to retrieve the data from, and WHERE to set a condition that must be satisfied. Use parenthesis to group the
-- condition definition parts together otherwise SQL will not run all of the conditions listed. Use LIKE to use the % wildcard after both
-- the letter 'K' and the letter 'Q' to retrieve all movie titles that start with the letters 'K' or 'Q'. Use OR so that only one of the 
-- movie title starting letter conditions need to be true to move on to the second test. Use AND to make sure that any value that 
-- satisfies one of the previous conditions will only be returned if the movie's language is English.
SELECT title, language_id FROM film WHERE (title LIKE 'K%' OR title LIKE 'Q%' AND language_id = 1);

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip
-- Nutshell explanation: We will use a nested subquery within another subquery. Each subquery will determine/define what to filter each column 
-- in the outer query or subquery by. The query's actor_id will be filtered by the actor_ids selected in the first subquery. The first 
-- subquery will be filtered by the selections made in the nested subquery. The nested subquery will filter itself by using WHERE and 
-- setting title equal to 'Alone Trip'. After the second subquery finishes filtering itself it will initiate a reverse domino effect
-- to filter the outer subquery and query.
-- Step-by-step explanation: We will use a nested subquery within another subquery. Nested subqueries are run before the outer query or 
-- subquery(s). Use SELECT to retrieve the desired data, and specify first_name and last_name to only retrieve data from those columns.
-- Use FROM to specify the table in which to retrieve the data and use WHERE to set a condition that must be satisfied. Use IN to determine
-- if a specified value is returned by a subquery since WHERE cannot be used when multiple values are returned from subqueries. Use the
-- same syntax from the query (SELECT, FROM, WHERE), but set the condition equal to the nested subquery since the nested subquery will
-- return only one value. Set title equal to alone trip to define the first condition that must be met. There are three conditions that
-- must be met for a value to be returned with the nested subquery's condition being the first requirement to be met.
SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE 
title = 'Alone Trip'));

-- 7c. need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
-- Use SELECT to retrieve the desired data, and specify first_name, last_name, email to return data only from those columns. Use FROM to
-- specify the table in which to retrieve the data from and use a total of three JOINS to link data from four tables. Use ON to specify
-- the column names for the different join keys used in each individual JOIN. Use the table_name.column_name to specify the columns to
-- merge the tables on. Finally, use WHERE to create a condition that must be met and set country equal to 'Canada' to return data that
-- is only related to Canada.
SELECT first_name, last_name, email FROM customer
JOIN address ON customer.address_id=address.address_id
JOIN city ON address.city_id=city.city_id
JOIN country ON city.country_id=country.country_id
WHERE country='Canada';

-- 7d)  Identify all movies categorized as family films.
-- Nutshell explanation: We will use a nested subquery within another subquery. Each subquery will determine/define what to filter each column 
-- in the outer query or subquery by. The query's film_id will be filtered by the actor_ids selected in the first subquery. The first 
-- subquery will be filtered by the selections made in the nested subquery. The nested subquery will filter itself by using WHERE and 
-- setting title equal to 'Family'. After the second subquery finishes filtering itself it will initiate a reverse domino effect
-- to filter the outer subquery and query.
-- Step-by-step explanation: We will use a nested subquery within another subquery. Nested subqueries are run before the outer query or 
-- subquery(s). Use SELECT to retrieve the desired data, and specify titl to only retrieve data from those the title column.
-- Use FROM to specify the table in which to retrieve the data and use WHERE to set a condition that must be satisfied. Use IN to determine
-- if a specified value is returned by a subquery since WHERE cannot be used when multiple values are returned from subqueries. Use the
-- same syntax from the query (SELECT, FROM, WHERE), and use IN to determine if a specified value is returned by the nested subquery since
-- the nested subquery also returns multiple values. Set title equal to 'Family' to define the first condition that must be met. There are 
-- three conditions that must be met for a value to be returned with the nested subquery's condition being the first requirement to be met.
SELECT title FROM film WHERE film_id IN (SELECT film_id FROM film_category where category_id IN (SELECT category_id FROM category WHERE
name = 'Family'));

-- 7e. Display the most frequently rented movies in descending order.
-- Use SELECT to retrieve the desired data, specify rental_rate to retrieve only data in the rental_rate column, and use FROM to specify
-- the table in which to retrieve the data from.  Use ORDER BY to sort the resulting set by rental rate, and use DESC to sort in descending
-- order.
SELECT rental_rate FROM film ORDER BY rental_rate DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
-- Use SELECT to retrieve the desired data. Specify store and CONCAT('$', total_sales) to retrieve only the data from the store and 
-- total_sales columns. Use CONCAT to combine '$' with each value in the total_sales column. Use AS to assign an allias to the new column
-- and use FROM the specify the table in which to retrieve the data from. 
-- last_name values to be combined
SELECT store, CONCAT('$', total_sales) AS business_total_sales FROM sales_by_store;


-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT * FROM sales_by_store;

-- 7g. Write a query to display for each store its store ID, city, and country.
-- Use SELECT to retrieve the desired data, and specify store_id, city, and country to retrieve data from only those columns. Use FROM to
-- specify the table in which to retrieve teh data from. Use a total of three joins to link four tables together. Use three ONs to specify
-- the different join keys used in each individual JOIN in all of the tables. Use the table_name.column_name to specify the columns to
-- merge the tables on.
SELECT store_id, city, country
FROM store
JOIN address ON store.address_id=address.address_id
JOIN city ON address.city_id=city.city_id
JOIN country ON city.country_id=country.country_id;

-- 7h. List the top five genres in gross revenue in descending order
-- Use SELECT to retrieve the desired data, and specify store_id, city, and country to retrieve data from only those columns. Use FROM to
-- specify the table in which to retrieve teh data from. Use a total of three joins to link four tables together. Use three ONs to specify
-- the different join keys used in each individual JOIN in all of the tables. Use the table_name.column_name to specify the columns to
-- merge the tables on.
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
-- Follow the exact same steps as the solution to problem 7h, except above the first line insert 'CREATE VIEW'. Place top_five_genres
-- to the immediate left of CREATE VIEW to name the view top_five_genres and use AS to assign top_five_genres as an alias to the query
-- that follows. 
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
-- Use SELECT to retrieve the desired data, place an * after SELECT to select all fields in the table, and use FROM to specify the table
-- in which to retrieve the data from.
SELECT * FROM top_five_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
-- Use DROP to to enable a removal/deletion of whatever follows DROP, use VIEW to indicate that what will be removed/deleted is a VIEW, and
-- state the name of the VIEW that is to be removed/deleted.
DROP VIEW top_five_genres;