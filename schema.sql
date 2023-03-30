CREATE DATABASE vet_clinic;

\c vet_clinic;

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar(255),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species varchar(255);

CREATE TABLE owners (
  id serial PRIMARY KEY,
  full_name varchar(255),
  age integer
);

CREATE TABLE species (
  id serial PRIMARY KEY,
  name varchar(255)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id integer;
ALTER TABLE animals ADD COLUMN owner_id integer;
ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners (id);
