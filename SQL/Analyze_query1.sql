use SpotifyTADb;


--To  find how each of artist popularity relation with  average of their songs danceability,enery and tempo
select track_artist,round(avg(danceability),2) as dance_ability,round(avg(track_popularity),2) as popularity,round(avg(tempo),2) as tempo,round(avg(energy),2) as energy from spotify_songs_cleaned$
where  not track_popularity=0
group by track_artist
order by popularity ;


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
where  released_year>2014
group by track_artist
having  count(distinct playlist_name)>10
order by avg_popularity desc;

--TO group each of year how many pop songs have released 
select released_year,count(playlist_genre from spotify_songs_cleaned$ where playlist_genre like 'Po%') from spotify_songs_cleaned$
group by released_year;


select released_year,count(track_name) as no_of_songs_per_year from spotify_songs_cleaned$
group by released_year
order by no_of_songs_per_year desc;

--Popularity analyze for sad songs made artists 
select track_artist,avg(track_popularity) as avg_popular from spotify_songs_cleaned$
where playlist_name like 'Sad%' and  not track_popularity=0
group by track_artist;

--No of artists included for each type of playlist categories
select playlist_name,count(track_artist) as no_of_artists  from spotify_songs_cleaned$
group by playlist_name
order by no_of_artists desc;

select  track_artist from spotify_songs_cleaned$
where playlist_genre='rap' and playlist_name like 'Sa%';


--Each of artists popularity,energy vs tempo how changes 
select track_artist,round(avg(track_popularity),0) as popularity,round(avg(energy),0) as energy ,round(avg(tempo),0) as tempo from spotify_songs_cleaned$
group by track_artist
order by popularity desc;

--How tempo,popularity energy varies according to playlist genre
--This query output will be used to analyze statistics taking play list as a one factor and other all cetegories in one factor 
select playlist_genre,round(avg(track_popularity),0) as popularity,round(avg(energy),0) as energy ,round(avg(tempo),0) as tempo from spotify_songs_cleaned$
group by playlist_genre
order by popularity desc;
