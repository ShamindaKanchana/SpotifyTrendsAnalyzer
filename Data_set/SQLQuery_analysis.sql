--Use SpotifyTAb database and retriview all the data on the dataset
use SpotifyTADb;



SELECT track_artist,count(track_artist) as no_of_songs  from spotify_songs_cleaned$
group by track_artist
order by no_of_songs desc;


