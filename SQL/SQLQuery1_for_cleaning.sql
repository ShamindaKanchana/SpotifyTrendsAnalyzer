--Use SpotifyTAb database and retriview all the data on the dataset
use SpotifyTADb;
--Show all the tuples
select * from dbo.spotify_songs$;

--Find duplications from the dataset 
SELECT track_name, track_artist, COUNT(*) as duplications 
FROM spotify_songs$
GROUP BY track_name, track_artist
HAVING COUNT(*) > 1
order by duplications desc;



--Remove duplications from the dataset and choose the fields which are only required to my analyse with appropriate  modifications 
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


select * from  spotify_songs_cleaned$;

--Remove row which having null value 

delete from spotify_songs$
where track_name is null;



