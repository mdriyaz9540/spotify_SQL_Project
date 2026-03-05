# Spotify SQL Data Analysis 🎵

## 📌 Project Overview

This project performs **data analysis on a Spotify dataset using SQL**. The goal of this project is to explore music data and extract useful insights about **artists, tracks, albums, views, likes, comments, and streaming performance**.

The analysis includes **data cleaning, exploratory data analysis (EDA), aggregations, and advanced SQL techniques such as window functions and Common Table Expressions (CTEs).**

This project demonstrates how SQL can be used to analyze real-world datasets and answer business-related questions.

---

## 🛠 Tools & Technologies

* SQL
* PostgreSQL
* Git & GitHub
* Dataset from Spotify music analytics

---

## 📂 Dataset Information

The dataset contains information about Spotify music tracks including:

* Artist Name
* Track Name
* Album
* Album Type
* Danceability
* Energy
* Loudness
* Speechiness
* Acousticness
* Instrumentalness
* Liveness
* Valence
* Tempo
* Duration
* Views
* Likes
* Comments
* Streams
* Platform (Spotify / YouTube)

These attributes allow us to analyze **music popularity, engagement, and audio characteristics.**

---

## 🧹 Data Cleaning

The following cleaning steps were performed before analysis:

* Removed tracks with **zero duration**
* Checked **distinct artists and album types**
* Validated platform information (Spotify / YouTube)
* Verified missing values

Example cleaning query:

```sql
DELETE FROM spotify
WHERE duration_min = 0;
```

---

# 📊 Exploratory Data Analysis (EDA)

Basic exploration queries were used to understand the dataset.

### Total Number of Records

```sql
SELECT COUNT(*) FROM spotify;
```

### Total Unique Artists

```sql
SELECT COUNT(DISTINCT artist) FROM spotify;
```

### Album Types in Dataset

```sql
SELECT DISTINCT album_type FROM spotify;
```

### Maximum Track Duration

```sql
SELECT MAX(duration_min) FROM spotify;
```

### Minimum Track Duration

```sql
SELECT MIN(duration_min) FROM spotify;
```

---

# 📈 Business Questions & SQL Analysis

## 1️⃣ Tracks with More Than 1 Billion Streams

```sql
SELECT track, stream
FROM spotify
WHERE stream > 1000000000;
```

---

## 2️⃣ List All Albums with Their Artists

```sql
SELECT artist, album
FROM spotify;
```

---

## 3️⃣ Total Comments for Licensed Tracks

```sql
SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed = TRUE;
```

---

## 4️⃣ Tracks That Belong to the Album Type "Single"

```sql
SELECT album, track, album_type
FROM spotify
WHERE album_type = 'single';
```

---

## 5️⃣ Total Number of Tracks by Each Artist

```sql
SELECT artist, COUNT(track) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks ASC;
```

---

## 6️⃣ Average Danceability of Tracks in Each Album

```sql
SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;
```

---

## 7️⃣ Top 5 Tracks with Highest Energy

```sql
SELECT track, MAX(energy)
FROM spotify
GROUP BY track
ORDER BY MAX(energy) DESC
LIMIT 5;
```

---

## 8️⃣ Tracks with Official Video (Views & Likes)

```sql
SELECT track,
SUM(views) AS total_views,
SUM(likes) AS total_likes
FROM spotify
WHERE official_video = TRUE
GROUP BY track
ORDER BY total_views DESC;
```

---

## 9️⃣ Total Views for Each Album

```sql
SELECT album,
SUM(views) AS total_views
FROM spotify
GROUP BY album;
```

---

## 🔟 Tracks Streamed More on Spotify Than YouTube

```sql
SELECT *
FROM (
SELECT track,
COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS stream_on_youtube,
COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS stream_on_spotify
FROM spotify
GROUP BY track
) AS t
WHERE stream_on_spotify > stream_on_youtube
AND stream_on_youtube <> 0;
```

---

## 1️⃣1️⃣ Top 3 Most Viewed Tracks for Each Artist

Window Function Example:

```sql
WITH ranking_artist AS (
SELECT artist,
track,
SUM(views) AS most_viewed,
DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
FROM spotify
GROUP BY artist, track
)

SELECT *
FROM ranking_artist
WHERE rank <= 3;
```

---

## 1️⃣2️⃣ Tracks with Liveness Above Average

```sql
SELECT *
FROM spotify
WHERE liveness > (
SELECT AVG(liveness)
FROM spotify
);
```

---

## 1️⃣3️⃣ Difference Between Highest and Lowest Energy in Each Album

Using **CTE (Common Table Expression)**

```sql
WITH cte AS (
SELECT album,
MAX(energy) AS highest_energy,
MIN(energy) AS lowest_energy
FROM spotify
GROUP BY album
)

SELECT album,
highest_energy - lowest_energy AS energy_difference
FROM cte
ORDER BY energy_difference DESC;
```

---

# 🧠 SQL Concepts Used

This project demonstrates the following SQL concepts:

* Data Cleaning
* Aggregate Functions
* GROUP BY
* ORDER BY
* Subqueries
* CASE WHEN
* Window Functions
* CTE (Common Table Expressions)
* Data Exploration


# 🎯 Key Insights

Some interesting insights discovered from the dataset:

* Several tracks have **over 1 billion streams**
* Some artists dominate **view counts across multiple tracks**
* Certain tracks perform **better on Spotify compared to YouTube**
* Energy levels vary significantly between albums

---


---

# 👨‍💻 Author

**Mohd Riyaz**

Aspiring **Data Analyst / Data Scientist**
* Machine Learning
* Power BI
