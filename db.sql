CREATE TABLE planets (
	ID serial PRIMARY KEY,
	planet_name VARCHAR(90) NOT NULL,
	area INT NOT NULL,
	dist_from_earth INT NOT NULL
);


<<<<<<< HEAD
\COPY planets(planet_name, area, dist_from_earth)
FROM 'data/data'
=======
COPY planets(planet_name, area, dist_from_earth)
FROM '/data/data'
>>>>>>> 834d16db2dc4e7cb512713c0649f74b2cbd93348
DELIMITER ','
CSV HEADER;
