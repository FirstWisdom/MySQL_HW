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
SELECT * from actor WHERE last_name LIKE '%LI%'
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

