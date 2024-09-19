CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

--   Count the Number of Movies vs TV Shows
SELECT type, COUNT(*) AS count
FROM netflix
GROUP BY type;

--  Find the Most Common Rating for Movies and TV Shows
SELECT type, rating, COUNT(*) AS count
FROM netflix
GROUP BY type, rating
ORDER BY count DESC
LIMIT 1;

-- List All Movies Released in a Specific Year (e.g., 2020)
SELECT title
FROM netflix
WHERE type = 'Movie' AND release_year = 2020;


-- Find the Top 5 Countries with the Most Content on Netflix
SELECT country, COUNT(*) AS count
FROM netflix
GROUP BY country
ORDER BY count DESC
LIMIT 5;


-- Identify the Longest Movie
SELECT title, duration
FROM netflix
WHERE type = 'Movie'
ORDER BY duration DESC
LIMIT 1;


--  Find Content Added in the Last 5 Years
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';


--  Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT title, type
FROM netflix
WHERE director = 'Rajiv Chilaka';


--  List All TV Shows with More Than 5 Seasons
SELECT title, duration
FROM netflix
WHERE type = 'TV Show' AND duration > '5 Seasons';


--  Count the Number of Content Items in Each Genre
SELECT listed_in AS genre, COUNT(*) AS count
FROM netflix
GROUP BY listed_in
ORDER BY count DESC;


--  Find each year and the average numbers of content release in India on netflix
SELECT release_year, COUNT(*) / 5 AS average_content
FROM netflix
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY release_year;


--  List All Movies that are Documentaries
SELECT title
FROM netflix
WHERE type = 'Movie' AND listed_in LIKE '%Documentary%';


-- Find All Content Without a Director
SELECT title, type
FROM netflix
WHERE director = '';


-- Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


--   Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;


--  Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
SELECT 
    CASE 
        WHEN description LIKE '%kill%' THEN 'Contains Kill'
        WHEN description LIKE '%violence%' THEN 'Contains Violence'
        ELSE 'Other'
    END AS category,
    COUNT(*) AS count
FROM netflix
GROUP BY category;



