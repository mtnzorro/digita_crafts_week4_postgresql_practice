CREATE TABLE restaurant (
  id serial primary key,
  name varchar,
  distance integer,
  stars integer,
  category varchar,
  favorite_dish varchar,
  takeout boolean,
  last_visit date
);

insert into restaurant values
  ('moxie burger', 15, 4, 'Burger', 'burger', TRUE, '2016-10-02'  );

insert into restaurant values
  ('el felix', 20, 5, 'tex mex', 'enchilada', TRUE, '2016-10-01'  );

insert into restaurant values
  ('moes', 3, 3, 'burrito', 'big burrito', TRUE, '2016-09-29'  );

insert into restaurant values
  ('sugar shack', 20, 4, 'pastry', 'beignet', TRUE, '2016-09-02'  );


select * from restaurant where stars = 5;
select * from restaurant where name like '%sugar shack%';
select name from restaurant where category = 'tex mex';
select name from restaurant where takeout = TRUE;
select name from restaurant where category = 'tex mex' and takeout = TRUE;
select name from restaurant where distance < 5;
select name from restaurant where last_visit < '2016-09-27';
select name from restaurant where stars = 5 and last_visit > '2016-09-27';

<!--10/05 Code:--->

select name, distance from restaurant order by distance limit 2;
select name from restaurant order by stars limit 2;
select name, distance from restaurant where distance <=4 order by stars;
select count(*) from restaurant;
select category, count(category) as cat_num from restaurant group by category;
select category, avg(stars) from restaurant group by category;
select category, max(stars) from restaurant group by category;
