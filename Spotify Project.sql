--  Spotify Analysis
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

select*from spotify;

-- EDA
SELECT COUNT(*)FROM spotify;

SELECT COUNT(DISTINCT artist)FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min) FROM spotify

SELECT MIN(duration_min) FROM spotify

SELECT * FROM spotify
WHERE duration_min = 0

DELETE FROM spotify 
WHERE duration_min = 0

SELECT DISTINCT channel FROM spotify

SELECT DISTINCT most_played_on FROM spotify;

-- These problem questions 

-- Retrieve the names of all tracks that have more than 1 billion streams.
SELECT track,stream from spotify
WHERE stream >1000000000

-- List all albums along with their respective artists.

SELECT artist,album FROM spotify

-- Get the total number of comments for tracks where licensed = TRUE.

SELECT SUM(comments) as total_comments
from spotify
WHERE licensed = 'true'

-- Find all tracks that belong to the album type single.

SELECT album,track,album_type from spotify
WHERE album_type = 'single'

-- Count the total number of tracks by each artist.

SELECT artist,count(track)as total_track from spotify
GROUP BY artist
order by total_track asc 

-- Calculate the average danceability of tracks in each album.

SELECT album ,AVG(danceability) as avg_danceability
from spotify
GROUP BY album
ORDER BY avg_danceability desc

-- Find the top 5 tracks with the highest energy values.

SELECT DISTINCT track , MAX(energy) from spotify
GROUP BY DISTINCT track 
ORDER BY MAX(energy) desc
limit 5

-- List all tracks along with their views and likes where official_video = TRUE.

SELECT track,SUM(views) AS Total_views,
SUM(likes) as total_likes 
from spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY Total_views DESC

-- For each album, calculate the total views of all associated tracks.

SELECT track,album, sum(views) as total_views
from spotify
GROUP BY 
track,album

-- Retrieve the track names that have been streamed on Spotify more than YouTube.
select*from
(SELECT track,
coalesce(sum(case when most_played_on = 'Youtube' then stream end),0)as stream_on_youtube,
coalesce(sum(case when most_played_on = 'Spotify' then stream end),0)as stream_on_Spotify
from spotify
group by track)as t

where stream_on_Spotify > stream_on_Youtube
and stream_on_Youtube<>0

-- Find the top 3 most-viewed tracks for each artist using window functions.

WITH Ranking_artist AS(
SELECT artist,track,sum(views) as most_viewed,
DENSE_RANK() OVER(PARTITION BY artist ORDER BY sum(views) DESC) AS RANK
from spotify
group by artist,track
order by artist,most_viewed desc)
SELECT * FROM Ranking_artist
WHERE RANK <=3

-- Write a query to find tracks where the liveness score is above the average.

Select * from spotify
where liveness > (select avg(liveness)from spotify)

-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
with cte
as(
select album,
max(energy) as highest_energy,
min(energy) as lowest_energy
from spotify
group by album)
select album,
highest_energy - lowest_energy as energy_difference
from cte
order by energy_difference desc

