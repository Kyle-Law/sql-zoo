-- List each country name where the population is larger than that of 'Russia'.
-- world(name, continent, area, population, gdp)

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Richer than UK
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world
WHERE gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom') AND continent = 'Europe'

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
WHERE continent IN (SELECT continent FROM world WHERE name = 'Argentina' OR name = 'Australia')
ORDER BY name

-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world
WHERE population > (SELECT population from world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(
    ROUND(
        population*100/(SELECT population FROM world WHERE name = 'Germany')
        )
        ,'%') 
    FROM world WHERE continent = 'Europe'

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
-- You need the condition gdp>0 in the sub-query as some countries have null for gdp.


SELECT name FROM world WHERE gdp > ALL((SELECT gdp FROM world WHERE continent = 'Europe' AND gdp>0))

-- Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND population>0)
-- The above example is known as a correlated or synchronized sub-query.
-- You would say “select the country details from world where the area is greater than or equal to the area of all countries where the continent is the same”.

-- List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x
WHERE name<= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent)

-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population 
FROM world x 
WHERE 25000000 > ALL (SELECT population 
FROM world y 
WHERE x.continent=y.continent)

-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world x WHERE population/3 >= ALL
 (SELECT population FROM world y WHERE x.continent=y.continent AND name NOT IN 
(SELECT name FROM world x WHERE population >= 
ALL(SELECT population FROM world y WHERE y.continent=x.continent )));