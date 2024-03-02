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

--Categorize according to playlist genre
select playlist_genre,count(*) as no_of_songs from dbo.spotify_songs$ 
where track_artist like 'The We%d'
group by playlist_genre
order by no_of_songs desc;

select playlist_genre,count(*) as no_of_songs from dbo.spotify_songs$ 
--where track_artist like 'Ariana%'
group by playlist_genre
order by no_of_songs desc;

-
select track_artist from spotify_songs$ 
where track_popularity=max(select track_popularity from spotify_songs$);

SELECT track_artist, MAX(track_popularity) AS max_popularity
FROM spotify_songs$
GROUP BY track_artist
ORDER BY max_popularity DESC;
 

select max(track_popularity) from spotify_songs$;
