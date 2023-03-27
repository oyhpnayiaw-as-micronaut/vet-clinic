CREATE DATABASE vet_clinic;

-- create the table
CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

