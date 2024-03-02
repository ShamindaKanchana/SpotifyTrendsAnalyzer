--Use SpotifyTAb database and retriview all the data on the dataset
use SpotifyTADb;
--Show all the tuples
select * from dbo.spotify_songs$;






--Find duplications from the dataset 
SELECT distinct  track_artist, track_name, track_popularity
FROM spotify_songs$
WHERE track_popularity = (SELECT MAX(track_popularity) FROM spotify_songs$);

--Remove duplications from the dataset and choose the fields which are only required to my analyse
SELECT track_name, track_artist, COUNT(*) as duplications 
FROM spotify_songs$
GROUP BY track_name, track_artist
HAVING COUNT(*) > 1
order by duplications desc;

select  count(*) from spotify_songs$
where track_artist like 'Ariana%';

select track_name,track_artist from spotify_songs$
where track_name like 'Music has the Powe%'


WITH UniqueRows AS (
  SELECT
    track_name,
    track_artist,
    track_popularity,
    ROW_NUMBER() OVER (PARTITION BY track_name, track_artist ORDER BY track_popularity DESC) AS RowNum
  FROM
    spotify_songs$
)
SELECT
  track_name,
  track_artist,
  track_popularity
FROM
  UniqueRows
WHERE
  RowNum = 1;
