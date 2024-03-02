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

select  count(*) from spotify_songs$
where track_artist like 'Ariana%';

select track_name,track_artist from spotify_songs$
where track_name like 'Music has the Powe%'

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
	danceability*100 as danceability, --to show as percentage
	energy*100 as energy,
	[key],
	loudness,
	mode,
	speechiness*100 as speechiness, 
	acousticness*100 as acousticness, 
	liveness*100 as liveness, 
	valence*100 as valence, 
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


