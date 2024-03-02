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
-- Find duplications from the dataset and keep only the most popular tracks
SELECT DISTINCT track_artist, track_name, track_popularity
FROM spotify_songs$
WHERE track_popularity = (SELECT MAX(track_popularity) FROM spotify_songs$);