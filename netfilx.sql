-- 1.Count no of movies vs tv show;
SELECT (type) ,count(*) as total_count FROM netfilx.netflix_data
group by type;

-- 2.common rating for movies and tv show;
SELECT * 
FROM (
    SELECT type, rating, COUNT(*) AS count,
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranks
    FROM netfilx.netflix_data
    GROUP BY type, rating
) ranked_data
WHERE ranks = 1
ORDER BY type, count DESC;


-- 3.list all movies release in 2018;
select * from netfilx.netflix_data
where type='Movie' and release_year=2018;

-- 4.Top 5 counteries with most content; 
select country,count(*) as content_count
from netfilx.netflix_data
group by country 
order by content_count desc
LIMIT 5;

-- 5.Find the oldest movie or TV show in the dataset:; 
SELECT title ,release_year
from netfilx.netflix_data 
order by release_year
limit 1;
-- 6. Find longest content duration ;
select title , duration from netfilx.netflix_data
where type='Movie'
order by CAST(substring_index(duration,' ',1) as unsigned) DESC  
LIMIT 1;
-- 7 most common content duration;
select duration ,count(*) as occurences
from netfilx.netflix_data
where type='Movie'
group by duration 
order by occurences desc
LIMIT 1;

-- 8 MOST FREQUENT DIRECTORS WITH MOVIES;
select director ,count(*) as movie_count
from netfilx.netflix_data
where type='Movie' and director is not null
group by director
order by movie_count desc 
limit 5;
-- 9 content released after 2020;
select title,release_year
from netfilx.netflix_data
where release_year > 2020;  

-- 10 most recent titles;

select title ,date_added
from netfilx.netflix_data
order by date_added desc
limit 10;
-- 11 . find top genres for tv show;
select listed_in as genre,count(*) as tvshow_count
from netfilx.netflix_data
where type='TV Show'
group by genre
order by tvshow_count desc
limit 5;
-- 12 cast appering most;
select cast ,count(*) as apperences
from netfilx.netflix_data
where cast is not null
group by cast
order by apperences  desc
limit 5;
-- 13 content that is both tv show and in india:
select title ,country , type 
from netfilx.netflix_data
where type ='TV Show'
and country like '%India%'
order by title ;
-- 14 Find content with a TV-MA rating, grouped by country;
select country ,count(*) as content_count
from netfilx.netflix_data
where rating='TV-MA'
group by country
order by content_count;

-- 15 list of movies direscted by specific director (Milan Luthria);
select title,director ,release_year
from netfilx.netflix_data
where director='Milan Luthria'
and type='Movie';
-- 16 content with description contain word 'love';
select title , description from netfilx.netflix_data
where description LIKE '%love%';








