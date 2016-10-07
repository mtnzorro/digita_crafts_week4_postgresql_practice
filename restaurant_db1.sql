CREATE TABLE restaurant (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  address varchar,
  category varchar
);

CREATE TABLE reviewer (
  id serial PRIMARY KEY,
  name varchar,
  email varchar,
  karma integer DEFAULT 0 CHECK (karma between 0 and 7)
);

CREATE TABLE review (
  id serial PRIMARY KEY,
  author_reviewer_id integer NOT NULL UNIQUE,
  stars integer CHECK (stars between 0 and 5),
  title varchar,
  review text,
  restaurant_id integer NOT NULL UNIQUE
);

#Queries:


select review, restaurant_id from review where restaurant_id = 1;
select review, author_reviewer_id from review where author_reviewer_id = 1;
select review, restaurant_id from review order by restaurant_id;
select review, restaurant.name from review right outer join restaurant on restaurant_id = restaurant.id order by restaurant.name;
select review, restaurant.name from review right outer join restaurant on restaurant_id = restaurant.id order by restaurant.name;
select avg(stars), restaurant.name from review inner join restaurant on restaurant_id = restaurant.id group by restaurant.name;
select count(review.review), restaurant.name from review inner join restaurant on restaurant_id = restaurant.id group by restaurant.name;
select review, reviewer.name, restaurant.name from review inner join restaurant on restaurant_id = restaurant.id right outer join reviewer on author_reviewer_id = reviewer.id order by restaurant.name;
select avg(stars), reviewer.name from review innner join reviewer on author_reviewer_id = reviewer.id group by reviewer.name;
select min(stars), reviewer.name from review inner join reviewer on author_reviewer_id = reviewer.id group by reviewer.name;
select count(id), restaurant.category from restaurant group by category;
select count(stars), restaurant.name from review inner join restaurant on restaurant_id = restaurant.id where stars = 5 group by restaurant.name;
select avg(stars), restaurant.category from review inner join restaurant on restaurant_id = restaurant.id group by restaurant.category;
