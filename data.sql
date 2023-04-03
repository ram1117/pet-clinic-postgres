/* Populate database with sample data. */

/* Milestone 1 */

-- insert records into animals table
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Agumon','Feb 3, 2020',0,true,10.23);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Gabumon','Nov 15, 2018',2,true,8);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Pikachu','Jan 7, 2021',1,false,15.04);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Devimon','May 12, 2017',5,true,11);

/* Milestone 2 */

-- insert records into animals table

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Charmander','Feb 8, 2020',0,false,-11);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Plantmon','Nov 15, 2021',2,true,-5.7);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Squirtle','Apr 2, 1993',3,false,-12.13);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Angemon','Jun 12, 2005',1,true,-45);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Boarmon','Jun 7, 2005',7,true,20.4);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Blossom','Oct 13, 1998',3,true,17);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Ditto','May 14, 2022',4,true,22);


/* Milestone 3 */

-- insert owners and specied data into owners and species tables

INSERT INTO owners (full_name,age)
VALUES
('Sam Smith',34),
('Jennifer Orwell',19),
('Bob',45),
('Melody Pond',77),
('Dean Winchester',14),
('Jodie Whittaker',38);
INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

-- update species_id values for Pokemon (1) and Digimon(2)

BEGIN;
UPDATE animals
SET species_id=2
WHERE name LIKE '%mon';
SELECT * FROM animals;
COMMIT;

BEGIN;
UPDATE animals
SET species_id=1
WHERE species_id IS NULL;
SELECT * FROM animals;
COMMIT;


-- update owner_id values for animals table

BEGIN;
UPDATE animals SET owner_id=1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id=2 WHERE name IN ('Gabumon','Pikachu');
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon','Boarmon');
COMMIT;

/* Milestone 4 Join table for visits */

-- insert data into vets, specializations and visits tables

BEGIN;
INSERT INTO vets (name,age,date_of_graduation)
VALUES
('William Tatcher',45,'Apr 23,2000'),
('Maisy Smith',26,'Jan 17,2019'),
('Stephanie Mendez',64,'May 4,1981'),
('Jack Harkness',38,'Jun 8,2008');
COMMIT;

BEGIN;
INSERT INTO specializations (vet_id,species_id)
VALUES
(1,1),
(3,2),
(3,1),
(4,2);
COMMIT;

BEGIN;
INSERT INTO visits(animal_id,vet_id,visit_date)
VALUES
(1,1,'May 24,2020'),
(1,3,'July 22,2020'),
(2,4,'Feb 2,2021'),
(3,2,'Jan 5,2020'),
(3,2,'Mar 8,2020'),
(3,2,'May 14,2020'),
(4,3,'May 4,2021'),
(5,4,'Feb 24,2021'),
(6,2,'Dec 21,2019'),
(6,1,'Aug 10,2020'),
(6,2,'Apr 7,2021'),
(7,3,'Sep 29,2019'),
(8,4,'Oct 3,2020'),
(8,4,'Nov 4,2020'),
(9,2,'Jan 24,2019'),
(9,2,'May 15,2019'),
(9,2,'Feb 27,2020'),
(9,2,'Aug 3,2020'),
(10,3,'May 24,2020'),
(10,1,'Jan 11,2021');
COMMIT;

/*  Performance audit exercise*/


-- insert new visits for exercise
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

--insert new owners with generated eemail ids
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';