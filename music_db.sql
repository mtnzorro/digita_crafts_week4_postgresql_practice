
CREATE TABLE track (
  id serial PRIMARY KEY,
  name varchar,
  duration integer NOT NULL,
  album_id integer NOT NULL REFERENCES album (id), -- move to track
  song_id integer REFERENCES song(id) NOT NULL

);

CREATE TABLE songwriter (
  id serial PRIMARY KEY,
  name varchar
);

CREATE TABLE song (
  id serial PRIMARY KEY,
  name varchar,
  songwriter_id integer REFERENCES songwriter (id) NOT NULL
);


CREATE TABLE artist (
  id serial PRIMARY KEY,
  name varchar
);


CREATE TABLE plays (
  id serial PRIMARY KEY,
  instrument_id integer NOT NULL REFERENCES instrument (id), -- move to track
  artist_id integer REFERENCES artist (id) NOT NULL
);

CREATE TABLE instrument (
  id serial PRIMARY KEY,
  instrument varchar
);



CREATE TABLE album (
  id serial PRIMARY KEY,
  name varchar,
  produced_by varchar,
  release_date date,
  lead_artist_id integer NOT NULL REFERENCES artist (id),
);

CREATE TABLE participation (
  id serial PRIMARY KEY,
  album_id integer NOT NULL REFERENCES album (id), -- move to track
  artist_id integer REFERENCES artist (id) NOT NULL
);


--Queries:
select track.name, album.name from track inner join album on track.album_id = album.id where album.name = 'Are You Experienced?';

select instrument.instrument, artist.name from plays inner join instrument on plays.instrument_id = instrument.id inner join artist on plays.artist_id = artist.id order by artist.name;

select max(duration), song.name from track inner join song on track.song_id = song.id group by song.name order by max desc limit 1;

select album.name, album.release_date from album where album.release_date < '2000-12-31' order by album.release_date;

select artist.name, count(album.name) from artist inner join album on album.lead_artist_id = artist.id where album.release_date < '1999-12-31'and album.release_date > '1990-01-01' and artist.name = 'Mariah Carey' group by artist.name;

select
	sum(track.duration), album.name
from track
inner join album
	on track.album_id = album.id
group by album.name;

select track.name, artist.name from artist inner join participation on participation.artist_id = artist.id inner join album on participation.album_id = album.id inner join track on track.album_id = album.id;

select album.name, artist.name from artist inner join participation on participation.artist_id = artist.id inner join album on participation.album_id = album.id where artist.solo = 'TRUE';

select
name
from
(select
	album.id, album.name, count(artist.id) as artist_count
from album
inner join participation
	on participation.album_id = album.id
inner join artist
	on participation.artist_id = artist.id
group by album.id) as artist_counts
where
	artist_count = 1

;



select album.name, artist.name from artist inner join album on album.lead_artist_id = artist.id;

select album.name, artist.name from album inner join participation on participation.album_id = album.id inner join artist on participation.artist_id = artist.id order by album.name;

select count(album.name), artist.name from artist inner join participation on participation.artist_id = artist.id inner join album on participation.album_id = album.id group by artist.name order by count desc limit 5;

select album.name, artist.name, instrument.instrument from album inner join artist on album.lead_artist_id = artist.id inner join plays on plays.artist_id = artist.id inner join instrument on plays.instrument_id = instrument.id where instrument.instrument = 'Piano';

select count(song.name), song.name from album inner join track on track.album_id = album.id inner join song on track.song_id = song.id group by song.name order by count desc limit 5;

select count(songwriter.name), songwriter.name from songwriter inner join song on song.songwriter_id = songwriter.id inner join track on track.song_id = song.id inner join album on track.album_id = album.id group by songwriter.name order by count desc limit 5;

select count(songwriter.name), songwriter.name from songwriter inner join song on song.songwriter_id = songwriter.id  group by songwriter.name order by count desc limit 1;

select count(instrument.instrument), artist.name from plays inner join instrument on plays.instrument_id = instrument.id inner join artist on plays.artist_id = artist.id group by artist.name order by count desc limit 1;


select
	artist.id, artist.name
from
	artist,
	participation,
	album
where
	artist.id = participation.artist_id and
	participation.album_id = album.id and
	album.id in (select
	artist.id, artist.name
from
	artist,
	participation,
	album
where
	artist.id = participation.artist_id and
	participation.album_id = album.id and
	artist.name = 'Mariah Carey')
	
-- CREATE TABLE recordings (
--   id serial PRIMARY KEY,
--   produced_by varchar NOT NULL,
--   lead_artist integer NOT NULL REFERENCES artist (id) UNIQUE,
--   artist_id integer NOT NULL REFERENCES artist (id),--drop
--   songwriter_id integer REFERENCES songwriter (id) NOT NULL, --drop
--   instrument_id integer REFERENCES instrument (id),
--   track_id integer NOT NULL REFERENCES track (id) UNIQUE,
--   song_id integer NOT NULL REFERENCES song (id),
--   album_id integer NOT NULL UNIQUE REFERENCES album (id)
-- );
