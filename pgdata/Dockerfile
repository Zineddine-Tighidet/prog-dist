FROM postgres:latest
ENV POSTGRES_PASSWORD=postgres POSTGRES_USER=postgres

RUN apt-get update

RUN apt-get install nano

COPY db.sql ./docker-entrypoint-initdb.d
COPY . .

EXPOSE 5432

