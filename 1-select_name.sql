-- Tutorial 1: SELECT names

-- Q1
--You can use WHERE name LIKE 'B%' to find the countries that start with "B".
-- The % is a wild-card it can match any characters
-- Find the country that start with Y
SELECT name FROM world
  WHERE name LIKE 'Y%'

-- Q2
-- Find the countries that end with y
SELECT name FROM world
  WHERE name LIKE '%y'

-- Q3
-- Luxembourg has an x - so does one other country. List them both.
-- Find the countries that contain the letter x
SELECT name FROM world
  WHERE name LIKE '%x%'

