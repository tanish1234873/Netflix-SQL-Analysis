-- 1. Total Movies vs TV Shows

SELECT type, COUNT(*) AS total
FROM netflix_titles
GROUP BY type;


-- 2. Most Common Rating

SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
ORDER BY total DESC;


-- 3. Top 10 Countries Producing Content

SELECT country, COUNT(*) AS total
FROM netflix_titles
WHERE country IS NOT NULL
AND TRIM(country) <> ''
GROUP BY country
ORDER BY total DESC
LIMIT 10;


-- 4. Top 10 Directors

SELECT director, COUNT(*) AS total
FROM netflix_titles
WHERE director IS NOT NULL
AND TRIM(director) <> ''
GROUP BY director
ORDER BY total DESC
LIMIT 10;


-- 5. Content Released Per Year

SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;


-- 6. Longest Movie

SELECT title, duration
FROM netflix_titles
WHERE type='Movie'
ORDER BY CAST(REPLACE(duration,' min','') AS UNSIGNED) DESC
LIMIT 1;


-- 7. Number of Indian Titles

SELECT COUNT(*) AS indian_titles
FROM netflix_titles
WHERE country LIKE '%India%';


-- 8. Year With Highest Releases

SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY total_titles DESC
LIMIT 1;


-- 9. Top 5 Ratings For Movies

SELECT rating, COUNT(*) AS total_movies
FROM netflix_titles
WHERE type='Movie'
GROUP BY rating
ORDER BY total_movies DESC
LIMIT 5;


-- 10. Top 5 Ratings For TV Shows

SELECT rating, COUNT(*) AS total_tvshows
FROM netflix_titles
WHERE type='TV Show'
GROUP BY rating
ORDER BY total_tvshows DESC
LIMIT 5;


-- 11. Average Movie Duration

SELECT ROUND(
AVG(CAST(REPLACE(duration,' min','') AS UNSIGNED)),2
) AS avg_movie_duration
FROM netflix_titles
WHERE type='Movie';


-- 12. Movies Longer Than Average Duration

SELECT title, duration
FROM netflix_titles
WHERE type='Movie'
AND CAST(REPLACE(duration,' min','') AS UNSIGNED) >
(
SELECT AVG(
CAST(REPLACE(duration,' min','') AS UNSIGNED)
)
FROM netflix_titles
WHERE type='Movie'
);


-- 13. Directors Working In Both Movies And TV Shows

SELECT director
FROM netflix_titles
WHERE director IS NOT NULL
AND TRIM(director) <> ''
GROUP BY director
HAVING COUNT(DISTINCT type)=2;


-- 14. Year-wise Content Distribution By Type

SELECT release_year,
type,
COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year,type
ORDER BY release_year;