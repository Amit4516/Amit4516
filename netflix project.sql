create database netflix;
use netflix;

create table netflix
(
show_id VARCHAR(1000),
type    VARCHAR(10),
title   VARCHAR(150),
director  VARCHAR(208),
cast     VARCHAR(1000),
country  VARCHAR(150),
date_added  VARCHAR(50),
release_year  INT,
rating   VARCHAR(10),
duration  VARCHAR(15),
listed_id  VARCHAR(105),
description  VARCHAR(225)
);

select * from netflix;

select
    count(*) as total_content
from netflix;

select 
    distinct type
from netflix;

select * from netflix; 

-- 15 business problem 

-- 1. Count the number of Movies Vs Tv shows

select * from netflix;

select type, count(*) as total_content
from netflix
Group by type;

-- 2. find the most common rating for movies and tv shows

select
    type,
    rating
from
(    
    select
        type,
        rating,
        count(*),
		rank() over(partition by type order by count(*)) as ranking
    from netflix
    group by 1,2
) as t1
where
    ranking = 1;
    
-- 3. list all movies released in a specific year (e.g., 2020)  

select*from netflix
where  
type = 'movie'
and release_year = 2020;

select title
from netflix 
where listed_id like 'movie%' and release_year = 2019;

-- 4. find the top 5 countries with the most content on netflix

SELECT COUNTRY , COUNT(*) AS CONTENT_COUNT
FROM NETFLIX
GROUP BY COUNTRY
ORDER BY CONTENT_COUNT DESC
LIMIT 5;

-- 5. Identify the longest movie?

SELECT * FROM NETFLIX
WHERE
    TYPE = 'MOVIE'
    AND
    DURATION = (select MAX(duration)from netflix);
    
    
select cast(replace(duration,' min','') as unsigned),type from netflix where type = 'movie%'
order by cast(replace(duration,' min','') as unsigned) DESC LIMIT 1;
    
SELECT TITLE,DURATION, TYPE FROM NETFLIX     
WHERE TYPE LIKE 'MOVIE%'
ORDER BY CAST(REPLACE(DURATION,' min','') AS UNSIGNED) DESC
LIMIT 1 ;

-- 6.  find content added in the last 5 years 

select * 
from netflix
where STR_to_date(date_added, '%M %D, %Y') >= curdate() - interval 5 year;
    
-- 7. List All Movies that are Documentaries

select * from netflix;
DESC NETFLIX;
SHOW COLUMNS FROM NETFLIX;

select title from netflix where type like 'Movie%' and
LISTED_ID like 'documentaries%';

select count(title) as count_of_documentary_movie from netflix where type like 'Movie%' and
listed_id like '%documentaries%';

-- 8. COUNT the number of content items in Each genre

select listed_id as genre, count(*) total_content
from netflix
group by listed_id
order by total_content desc;

select * from netflix;

-- 9. find content added in the last 5 years

select title 
from netflix
where year(CURDATE()) - YEAR(str_to_date(DATE_ADDED, '%M %D, %Y')) <= 5;

SELECT YEAR(curdate());
select year(STR_TO_DATE(date_added, '%M %D, %')) FROM NETFLIX;

-- 10. find all Movies/TV shows by directors 'rajiv chilaka'

select *
from netflix
where director = 'rajiv chilaka';

-- 11. list all tv shows with more than 5 seasons

select title,duration
from netflix
where type like '%tv shows%' and cast(replace(duration, ' season','')as UNSIGNED)
LIMIT 5;

-- 12. FOR EXPLANATION 

SELECT CAST(REPLACE (DURATION, ' SEASON', '') AS UNSIGNED)
FROM netflix
WHERE TYPE LIKE '%TV SHOWS%';

-- 13. Find How Many Movies Actor 'salman khan' Released in the last 10 years

select count(*) AS movie_count
from netflix
where type like '%movie' and cast like '%salman khan%'
and release_year >= year(curdate()) - 10;

-- 14. identify movies/TV Shows Featuring a specific Actor (e.g., "robert de niro")

select *
from netflix
where cast like "robert de niro";

-- 15. group the records by year and count the number of movies/TV shows added each other

select release_year, count(*)as CONTENT_COUNT
from NETFLIX
group by RELEASE_YEAR
ORDER BY RELEASE_YEAR DESC;

-- 16. Find Each Year and the Average Numbers of Content released in india on netflix

SELECT RELEASE_YEAR, AVG(CONTENT_COUNT)
FROM
(SELECT RELEASE_YEAR, COUNT(*) AS CONTENT_COUNT
FROM netflix
WHERE COUNTRY = 'INDIA'
GROUP BY RELEASE_YEAR
ORDER BY RELEASE_YEAR DESC) AS YEAR_DATA
GROUP BY release_year;

-- 17. IDENTIFY the top 5 most Common GENRES IN the dataset

select listed_id AS genre, count(*) AS CONTENT_COUNT
from netflix
group by genre
order by CONTENT_COUNT DESC
LIMIT 5;

-- 18. Identify the Most Active Month for Adding Movies/TV shows(by count)
 
 SELECT * FROM
 (select MONTH(STR_TO_DATE(DATE_ADDED, '%M %d, %Y')) AS MONTH, COUNT(*) as content_count
 FROM NETFLIX
 GROUP BY month
 order by content_count DESC) AS RESULT_DATA
 WHERE MONTH IS NOT NULL
 LIMIT 1;

-- 19. Compare the Number of Movies and TV Shows Added Before and After 2015

select 
  case when release_year < 2015 then 'BEFORE 2015' ELSE 'AFTER 2015' end as period,
  type,
 COUNT(*) AS COUNT
from netflix
GROUP BY PERIOD,TYPE;

select * from netflix;

-- 20. Retrieve All MOVIES/TV Shows That Were Added in the last 6 months

SELECT *
FROM netflix
WHERE STR_TO_DATE(DATE_ADDED,'%M%D,%Y') >= date_sub(curdate(),INTERVAL 6 MONTH);

SELECT date_sub(curdate(),INTERVAL 6 MONTH);

-- 21. Find the Average Duration of movies (in Minutes)

SELECT DURATION FROM  NETFLIX;
select avg(CAST(replace(duration, ' MIN', '') AS unsigned))
FROM NETFLIX
WHERE TYPE LIKE '%Movie%';

-- 22. Find the top 10 Actors who have appeared in the highest number of movies produced in india
-- 23. Categorize Content Based on the presence of 'kill' and 'violence' keyword








