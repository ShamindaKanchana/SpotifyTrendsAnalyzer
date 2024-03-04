# SpotifyTrendsAnalyzer
SpotifyTrendsAnalyzer is a data analytics project focused on unraveling trends within the world of Spotify music. Explore the popularity of artists, discover trending songs, and delve into the metrics of danceability and energy. 
## Objectives 
### Artist Popularity Analysis:
Explore the popularity of each artist in the Spotify dataset.
Identify trends and variations in artist popularity over time.
### Trending Songs Analysis:
Determine which songs were trending during specific time periods.
Investigate factors contributing to the popularity of these songs.
### Artist Productivity Comparison:
Compare the number of songs created by each artist in the dataset.
Analyze the productivity of artists over different time intervals.
### Song Features Exploration:
Examine the danceability, energy, and other features of popular songs.
Uncover patterns and correlations between song features and popularity.

## Analysis Steps

### 1. Prepare

- **Import Dataset:**
  - The dataset used in this project was obtained from Kaggle, a platform known for high-quality datasets. (https://www.kaggle.com/datasets/joebeachcapital/30000-spotify-songs?resource=download)
  - Data has been validated to ensure accuracy and reliability.
  - Since the dataset originates from Spotify via Kaggle, we can trust its authenticity, and steps have been taken to confirm the data's validity.
  - The original dataset was initially available in CSV format.
  - Due to compatibility considerations with Microsoft SQL Server Studio, the dataset was converted to Excel format for ease of import.
- **Data Exploration:**
  - Use SQL queries to understand the structure of the data.
  - Identify potential areas of interest.

- **Excel Format for SQL Server:**
  - Excel format facilitates a smoother import process into Microsoft SQL Server Studio.
  - The dataset in Excel format is more conducive to SQL operations and analysis.

- **Data Validation:**
  - Before conversion, the integrity of the dataset was validated to ensure accurate representation after the format change.

### 2. Process

#### Data Cleaning -Removing Duplicates

To ensure data quality and eliminate duplicate entries, I performed a cleaning step to identify and retain only the most popular tracks within each group of duplicates. The following SQL query was used:

```sql
--Find duplications from the dataset 
SELECT track_name, track_artist, COUNT(*) as duplications 
FROM spotify_songs$
GROUP BY track_name, track_artist
HAVING COUNT(*) > 1
order by duplications desc;
```


#### Data Cleaning - Remove  Duplicates and Select Relevant Fields

It will be easy if we converted some fields in to some appropriate formats. For future analysis we need to have some varience of each of values. Otherwise it will be difficult to identify significance of data when we do visualize. So 
To ensure data accuracy and streamline the dataset for analysis, a data cleaning step was performed. The following SQL query was utilized to remove duplicates and select only the relevant fields for analysis:

```sql
-- Remove duplications from the dataset and choose the required fields with appropriate modifications
WITH UniqueRows AS (
  SELECT
    track_name,
    track_artist,
    track_popularity,
	track_album_name,
	YEAR(track_album_release_date) as released_year ,
	playlist_name,
	playlist_genre,
	playlist_subgenre,
	ROUND(danceability*100,1) as danceability, --to show as percentage
	ROUND(energy*100,1) as energy,
	[key],
	ROUND(loudness,2) as loudness,
	mode,
	ROUND(speechiness*100,2) as speechiness, 
	ROUND(acousticness*100,2) as acousticness, 
	ROUND(liveness*100,2) as liveness, 
	ROUND(valence*100,2) as valence, 
	ROUND(tempo,2) as tempo, --to keep only two decimal places 
	FORMAT(DATEADD(MILLISECOND,duration_ms,0),'mm:ss') as duration, --convert milliseconds to minutes and seconds 
    ROW_NUMBER() OVER (PARTITION BY track_name, track_artist ORDER BY track_popularity DESC) AS RowNum
  FROM
    spotify_songs$
)
SELECT
  track_name,
  track_artist,
  track_popularity,
  track_album_name,
  released_year,
  playlist_name,
  playlist_genre,
  playlist_subgenre,
  danceability,
  energy,
  [key],
  loudness,
  mode,
  speechiness,
  acousticness,
  liveness,
  valence,
  tempo,
  duration
FROM
  UniqueRows
WHERE
  RowNum = 1;
```

#### Handling Null Values

Identify and handle null values to ensure data quality. The following steps were taken:

1. **Identifying Null Values:**
  - SQL queries were executed to pinpoint rows where null values were present in specific columns.

    ```sql
    --To check which rows having null values
    select * from spotify_songs$ where track_name is null or playlist_name is null or playlist_genre is null or 
    playlist_genre is null or 
    playlist_subgenre is null or 
    danceability is null or energy is null or
    [key] is null or
    loudness is null or 
    mode is null or 
    speechiness is null or 
    acousticness is null or 
    liveness is null or 
    valence is null or 
    tempo is null or 
    duration_ms is null;
    ```

    This query helped in understanding the extent of null values across the dataset.

2. **Handling Null Values:**
   - Once identified, null values were handled appropriately based on the nature of the dataset and specific column requirements.
  

    ```sql
    --Remove row which having null value 
    delete from spotify_songs$
    where track_name is null;
    ```

  


### 2. Analysis

### Analyze Stage - Artist Characteristics
In this section, we explore the interplay between artist characteristics and song popularity. Visualizations are used to illustrate how key attributes such as danceability, energy, and overall popularity evolve across different artists.

Insights from Visual Analysis
Artist Characteristics Over Time
The line chart below depicts how artist characteristics change over time, focusing on key metrics: popularity, danceability, and energy.
![How each or arsits avg  popularity,avg tempo and avg enery varies ](Screenshots/popularity_tempo_change_with_artist.png)
```sql
--To  find how each of artist popularity relation with  average of their songs danceability,enery and tempo
select track_artist,round(avg(danceability),2) as dance_ability,round(avg(track_popularity),2) as popularity,round(avg(tempo),2) as tempo,round(avg(energy),2) as energy from spotify_songs_cleaned$
group by track_artist
order by popularity desc;

```

