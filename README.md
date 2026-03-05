# Spotify SQL Data Analysis

## Project Overview
This project analyzes Spotify music data using SQL to extract insights about tracks, artists, albums, and streaming performance.

## Tools Used
- PostgreSQL
- SQL
- GitHub

## Dataset
Spotify dataset containing information about:
- Artists
- Tracks
- Albums
- Streams
- Views
- Likes
- Comments
- Audio features (danceability, energy, tempo, etc.)

## Project Steps

1. Created Spotify table
2. Performed Exploratory Data Analysis (EDA)
3. Answered business questions using SQL

## Key Analysis

### Tracks with More Than 1 Billion Streams

```sql
SELECT track, stream
FROM spotify
WHERE stream > 1000000000;
```

### Top 3 Most Viewed Tracks Per Artist

Used **Window Functions**.

### Tracks More Popular on Spotify than YouTube

Used **CASE WHEN + Aggregation**

## Skills Demonstrated

- SQL Joins
- Aggregations
- Window Functions
- CTEs
- Data Cleaning
- Exploratory Data Analysis

## Author

Mohd Riyaz
Aspiring Data Analyst / Data Scientist
