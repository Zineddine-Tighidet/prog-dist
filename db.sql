CREATE TABLE planets (
	ID serial PRIMARY KEY,
	planet_name VARCHAR(90) NOT NULL,
	area INT NOT NULL,
	dist_from_earth INT NOT NULL
);


COPY planets(planet_name, area, dist_from_earth)
FROM '/data/data'
DELIMITER ','
CSV HEADER;
