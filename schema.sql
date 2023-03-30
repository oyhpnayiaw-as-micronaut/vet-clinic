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

CREATE TABLE vets (
  id serial PRIMARY KEY,
  name varchar(255),
  age integer,
  date_of_graduation date
);

CREATE TABLE specializations (
  vet_id integer,
  species_id integer,
  PRIMARY KEY (vet_id, species_id),
  CONSTRAINT fk_specializations_vets FOREIGN KEY (vet_id) REFERENCES vets (id),
  CONSTRAINT fk_specializations_species FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  id serial PRIMARY KEY,
  animal_id integer,
  vet_id integer,
  visit_date date,
  CONSTRAINT fk_visits_animals FOREIGN KEY (animal_id) REFERENCES animals (id),
  CONSTRAINT fk_visits_vets FOREIGN KEY (vet_id) REFERENCES vets (id)
);


