use SpotifyTADb;
--Show all the tuples
select * from dbo.spotify_songs$;

--Retriview how many songs per each of artists
select track_artist,count(*) as No_of_Songs from dbo.spotify_songs$
group by track_artist
order by No_of_Songs desc;
--identify the tuples which having nulls 
select * from dbo.spotify_songs$ 
where track_name is null;

--Find the danceability per each artist descending order
select avg(danceability) as average_dance_ability,track_artist from dbo.spotify_songs$
where track_artist  like 'A%'
group by track_artist
order by average_dance_ability desc;

select track_name,track_artist,year(track_album_release_date) as Released_year from dbo.spotify_songs$
where track_album_release_date like '%2019%' and track_artist like 'Ariana%';