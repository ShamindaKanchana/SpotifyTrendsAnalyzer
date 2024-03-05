use SpotifyTADb;


--To  find how each of artist popularity relation with  average of their songs danceability,enery and tempo
select track_artist,round(avg(danceability),2) as dance_ability,round(avg(track_popularity),2) as popularity,round(avg(tempo),2) as tempo,round(avg(energy),2) as energy from spotify_songs_cleaned$
group by track_artist
order by popularity desc;

select avg(track_popularity) from spotify_songs_cleaned$ where track_artist like 'Tones%';

select playlist_genre,count(distinct track_artist) as no_of_artists from spotify_songs_cleaned$
where  track_artist like 'Ar%'
group by playlist_genre;

--To find no of songs for each artist
select distinct track_artist,count(track_artist) as no_0f_tracks from spotify_songs_cleaned$
group by track_artist
having count(track_artist)>30
order by no_0f_tracks desc;

--No of artists for each of genres
select playlist_genre,count(distinct track_artist) as no_of_artists from spotify_songs_cleaned$
group by playlist_genre;

--To find each of year how many songs released and how many artists relased songs 
select released_year,count(track_name) as no_of_songs,count(distinct track_artist) as no_of_artists from spotify_songs_cleaned$
group by released_year
having released_year>2010
order by no_of_songs desc;

--find for each artists how many playlists have released after 2015
select track_artist,count(distinct playlist_name) as no_of_playlists,round(avg(track_popularity),2) as avg_popularity  from spotify_songs_cleaned$
where released_year>2015
group by track_artist
having  count(distinct playlist_name)>10
order by avg_popularity desc;


