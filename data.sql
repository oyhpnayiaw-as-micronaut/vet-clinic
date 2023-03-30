INSERT INTO 
  animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8), 
  ('Pikachu', '2021-01-07', 1, false, 15.04), 
  ('Devimon', '2017-05-12', 5, true, 11),
  ('Charmander', '2020-02-08', 0, false, -11),
  ('Plantmon', '2021-11-15', 2, true, -5.7),
  ('Squirtle', '1993-04-02', 3, false, -12.13),
  ('Angemon', '2005-06-12', 1, true, -45),
  ('Boarmon', '2005-06-07', 7, true, 20.4),
  ('Blossom', '1998-10-13', 3, true, 17),
  ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO 
  owners (full_name, age) 
VALUES 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO
  species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE animals SET species_id = ( SELECT id FROM species WHERE name = 'Pokemon');

UPDATE animals
SET species_id = ( 
  SELECT id FROM species WHERE name = 'Digimon'
)
WHERE name LIKE '%mon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Dean Winchester'
)
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO 
  vets (name, age, date_of_graduation)
VALUES 
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES 
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO 
  visits (animal_id, vet_id, visit_date)
SELECT 
  a.id, v.id, visit_date::date
FROM (
  VALUES
    ('Agumon', 'William Tatcher', '2020-05-24'),
    ('Agumon', 'Stephanie Mendez', '2020-07-22'),
    ('Gabumon', 'Jack Harkness', '2021-02-02'),
    ('Pikachu', 'Maisy Smith', '2020-01-05'),
    ('Pikachu', 'Maisy Smith', '2020-03-08'),
    ('Pikachu', 'Maisy Smith', '2020-05-14'),
    ('Devimon', 'Stephanie Mendez', '2021-05-04'),
    ('Charmander', 'Jack Harkness', '2021-02-24'),
    ('Plantmon', 'Maisy Smith', '2019-12-21'),
    ('Plantmon', 'William Tatcher', '2020-08-10'),
    ('Plantmon', 'Maisy Smith', '2021-04-07'),
    ('Squirtle', 'Stephanie Mendez', '2019-09-29'),
    ('Angemon', 'Jack Harkness', '2020-10-03'),
    ('Angemon', 'Jack Harkness', '2020-11-04'),
    ('Boarmon', 'Maisy Smith', '2019-01-24'),
    ('Boarmon', 'Maisy Smith', '2019-05-15'),
    ('Boarmon', 'Maisy Smith', '2020-02-27'),
    ('Boarmon', 'Maisy Smith', '2020-08-03'),
    ('Blossom', 'Stephanie Mendez', '2020-05-24'),
    ('Blossom', 'William Tatcher', '2021-01-11')
) AS visit (animal_name, vet_name, visit_date)
JOIN animals a ON a.name = visit.animal_name
JOIN vets v ON v.name = visit.vet_name;
