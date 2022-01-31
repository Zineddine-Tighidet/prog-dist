DROP DATABASE IF EXISTS astro;

DROP USER IF EXISTS root;

CREATE USER root WITH ENCRYPTED PASSWORD 'root';

ALTER USER root WITH SUPERUSER;

CREATE DATABASE astro;

GRANT ALL PRIVILEGES ON DATABASE astro TO root;

\c astro

DROP TABLE IF EXISTS planet;
DROP TABLE IF EXISTS satellite;
DROP TABLE IF EXISTS descriptions;

CREATE TABLE planet (
  id SERIAL,
  name VARCHAR(255),
  mass VARCHAR(255),
  diameter VARCHAR(255),
  density VARCHAR(255),
  gravity VARCHAR(255),
  escape_velocity VARCHAR(255),
  rotation_period VARCHAR(255),
  length_of_day VARCHAR(255),
  distance_from_sun VARCHAR(255),
  perihelion VARCHAR(255),
  aphelion VARCHAR(255),
  orbital_period VARCHAR(255),
  orbital_velocity VARCHAR(255),
  orbital_inclination VARCHAR(255),
  orbital_eccentricity VARCHAR(255),
  obliquity_to_orbit VARCHAR(255),
  mean_temperature VARCHAR(255),
  surface_pressure VARCHAR(255) NULL,
  number_of_moons INT,
  has_ring_system BOOLEAN,
  has_global_magnetic_field BOOLEAN,
  path VARCHAR(255),
  PRIMARY KEY (id),
  type VARCHAR(255)
);

CREATE TABLE satellite (
  id SERIAL,
  planet VARCHAR(255),
  sat_name VARCHAR(255),
  gm VARCHAR(255),
  radius VARCHAR(255),
  density VARCHAR(255) NULL,
  magnitude VARCHAR(255) NULL,
  albedo VARCHAR(255) NULL,
  PRIMARY KEY (id)
);

CREATE TABLE descriptions (
  name VARCHAR(255),
  descr VARCHAR(800)
);


COPY planet(name,mass,diameter,density,gravity,escape_velocity,rotation_period,length_of_day,distance_from_sun,perihelion,aphelion,orbital_period,orbital_velocity,orbital_inclination,orbital_eccentricity,obliquity_to_orbit,mean_temperature,surface_pressure,number_of_moons,has_ring_system,has_global_magnetic_field,type)
FROM '/planets.csv'
DELIMITER ','
CSV HEADER;

COPY satellite(planet,sat_name,gm,radius,density,magnitude,albedo)
FROM '/satellites.csv'
DELIMITER ','
CSV HEADER;

COPY descriptions(name, descr)
FROM '/description.csv'
DELIMITER ';'
CSV HEADER;


-- for test
-- COPY planet(name,mass,diameter,density,gravity,escape_velocity,rotation_period,length_of_day,distance_from_sun,perihelion,aphelion,orbital_period,orbital_velocity,orbital_inclination,orbital_eccentricity,obliquity_to_orbit,mean_temperature,surface_pressure,number_of_moons,has_ring_system,has_global_magnetic_field,type,path)
-- FROM '/home/zinedine/Bureau/STUDY/M1/ProgDist/prog-dist/pgdata/planets.csv'
-- DELIMITER ','
-- CSV HEADER;

-- COPY satellite(planet,sat_name,gm,radius,density,magnitude,albedo)
-- FROM '/home/zinedine/Bureau/STUDY/M1/ProgDist/prog-dist/pgdata/satellites.csv'
-- DELIMITER ','
-- CSV HEADER;

-- COPY descriptions(name, descr)
-- FROM '/home/zinedine/Bureau/STUDY/M1/ProgDist/prog-dist/pgdata/description.csv'
-- DELIMITER ';'