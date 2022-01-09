DROP DATABASE astro;

DROP USER root;

CREATE USER root WITH ENCRYPTED PASSWORD 'root';

ALTER USER root WITH SUPERUSER;

CREATE DATABASE astro;

GRANT ALL PRIVILEGES ON DATABASE astro TO root;

\c astro

CREATE TABLE planet (
  id SERIAL,
  name VARCHAR(255) NOT NULL,
  mass VARCHAR(255) NOT NULL,
  diameter VARCHAR(255) NOT NULL,
  density VARCHAR(255) NOT NULL,
  gravity VARCHAR(255) NOT NULL,
  escape_velocity VARCHAR(255) NOT NULL,
  rotation_period VARCHAR(255) NOT NULL,
  length_of_day VARCHAR(255) NOT NULL,
  distance_from_sun VARCHAR(255) NOT NULL,
  perihelion VARCHAR(255) NOT NULL,
  aphelion VARCHAR(255) NOT NULL,
  orbital_period VARCHAR(255) NOT NULL,
  orbital_velocity VARCHAR(255) NOT NULL,
  orbital_inclination VARCHAR(255) NOT NULL,
  orbital_eccentricity VARCHAR(255) NOT NULL,
  obliquity_to_orbit VARCHAR(255) NOT NULL,
  mean_temperature VARCHAR(255) NOT NULL,
  surface_pressure VARCHAR(255) NULL,
  number_of_moons INT NOT NULL,
  has_ring_system BOOLEAN NOT NULL,
  has_global_magnetic_field BOOLEAN,
  PRIMARY KEY (id),
  type VARCHAR(255)
);

CREATE TABLE satellite (
  id SERIAL,
  planet VARCHAR(255),
  sat_name VARCHAR(255) NOT NULL,
  gm VARCHAR(255) NOT NULL,
  radius VARCHAR(255) NOT NULL,
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
FROM '/home/zinedine/Bureau/STUDY/M1/ProgDist/prog-dist/pgdata/planets.csv'
DELIMITER ','
CSV HEADER;

COPY satellite(planet,sat_name,gm,radius,density,magnitude,albedo)
FROM '/home/zinedine/Bureau/STUDY/M1/ProgDist/prog-dist/pgdata/satellites.csv'
DELIMITER ','
CSV HEADER;

COPY descriptions(name, descr)
FROM '/home/zinedine/Bureau/STUDY/M1/ProgDist/prog-dist/pgdata/description.csv'
DELIMITER ';'
CSV HEADER;