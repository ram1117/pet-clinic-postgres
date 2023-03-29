/*Queries that provide answers to the questions from all projects.*/

/* Milestone 1 */

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered =true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE weight_kg  BETWEEN 10.4 AND 17.3;

/* Milestone 2 */

-- using transactions to update and rollback animals table

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;

-- rollback changes made above

ROLLBACK;
SELECT * FROM animals;

-- using transactions to update species column in animals table

BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species='pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- using transaction to delete all records in animals table, using ROLLBACK to restore table to prevoius state

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;

ROLLBACK;
SELECT * FROM animals;

-- using transactions with savepoints to update animal weights

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO SP1;
UPDATE animals
SET weight_kg = weight_kg*-1
WHERE weight_kg<0;
SELECT * FROM animals;
COMMIT;

-- Queries with aggregate functions

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered,SUM(escape_attempts) AS escapes FROM animals GROUP BY neutered;
SELECT species,MIN(weight_kg) AS minimum_weight,MAX(weight_kg) AS maximum_weight FROM animals GROUP BY species;
SELECT species,AVG(escape_attempts) AS avg_escapes FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'  GROUP BY species;

/* Milestone 3*/

-- Queries using JOINS for the scenarios requested in Milestone 3 requirements.

SELECT full_name AS owner, name AS animal  FROM animals A JOIN owners O ON A.owner_id=O.id WHERE O.full_name='Melody Pond';

SELECT  A.name AS animal, S.name AS species FROM animals A JOIN species S ON A.species_id=S.id WHERE S.name='Pokemon';

SELECT O.full_name AS owners,A.name AS animals FROM owners O FULL OUTER JOIN animals A ON O.id=A.owner_id;

SELECT S.name, COUNT(*) AS species FROM animals A JOIN species S ON A.species_id=S.id GROUP BY S.name;

SELECT O.full_name AS owner,A.name AS animal,S.name AS species FROM owners O JOIN animals A ON O.id=A.owner_id JOIN species S ON A.species_id=S.id WHERE S.name='Digimon' AND  O.full_name='Jennifer Orwell';

SELECT O.full_name AS owner,A.name AS animal FROM owners O JOIN animals A ON O.id=A.owner_id WHERE O.full_name='Dean Winchester' AND A.escape_attempts=0;

SELECT O.full_name AS owner,COUNT(*) AS pets FROM owners O JOIN animals A ON O.id=A.owner_id GROUP BY O.full_name ORDER BY COUNT(*) desc limit 1;

/* Milestone 4 Join table for visits */

-- queries to answer questions in Milestone 4 project requirements

SELECT A.name,VT.name,V.visit_date FROM animals A JOIN visits V ON A.id = V.animal_id JOIN vets VT ON vt.id = V.vet_id WHERE VT.name = 'William Tatcher' ORDER BY V.visit_date DESC LIMIT 1 ;

SELECT VT.name,COUNT(DISTINCT V.animal_id) AS animals_seen FROM animals A JOIN visits V ON A.id = V.animal_id JOIN vets VT ON vt.id = V.vet_id WHERE VT.name='Stephanie Mendez' GROUP BY VT.name;

SELECT V.name AS vet_name,SP.name AS speciality from vets V FULL JOIN specializations S ON V.id=S.vet_id FULL JOIN species SP ON S.species_id=SP.id;

SELECT A.name AS animal_name,VT.name AS vet_name,V.visit_date FROM animals A JOIN visits V ON A.id=V.animal_id JOIN vets VT ON V.vet_id=VT.id WHERE V.visit_date BETWEEN '2020-04-01' AND '2020-08-30'  AND VT.name = 'Stephanie Mendez'  ;

SELECT A.name AS animal_name,COUNT(A.name) AS visits  FROM animals A JOIN visits V ON A.id=V.animal_id GROUP BY A.name ORDER BY COUNT(A.name) DESC LIMIT 1;

SELECT V.name AS vet_name, A.name AS animal_name, VT.visit_date FROM vets V JOIN visits VT ON V.id=VT.vet_id JOIN animals A ON VT.animal_id=A.id WHERE V.name='Maisy Smith' ORDER BY VT.visit_date ASC LIMIT 1;

SELECT A.name AS animal_name, V.name AS vet_name, VT.visit_date FROM vets V JOIN visits VT ON V.id=VT.vet_id JOIN animals A ON VT.animal_id=A.id  ORDER BY VT.visit_date DESC LIMIT 1;

SELECT COUNT(*) FROM visits V JOIN animals A ON V.animal_id=A.id JOIN vets VT ON V.vet_id=VT.id FULL JOIN specializations S ON VT.id=S.vet_id WHERE A.species_id NOT IN (
SELECT species_id FROM specializations WHERE vet_id = V.vet_id
);

SELECT S.name AS species,COUNT(*) FROM visits V JOIN animals A ON V.animal_id=A.id JOIN vets VT ON V.vet_id=VT.id JOIN species S ON A.species_id = S.id WHERE VT.name='Maisy Smith' GROUP BY S.name ORDER BY COUNT(*) DESC LIMIT 1;

