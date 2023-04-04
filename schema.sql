/* Database schema to keep the structure of entire database. */

/* Milestone 1 */
CREATE TABLE animals (
id INT GENERATED ALWAYS AS IDENTITY,
name TEXT NOT NULL,
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg FLOAT,
PRIMARY KEY (id)
);

/* Milestone 2 */

-- Alter table to add species column
ALTER TABLE animals ADD species TEXT;

/* Milestone 3 */
 
-- add owners and species tables

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY,
full_name TEXT,
age INT,
PRIMARY KEY(id)
);
CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(300),
PRIMARY KEY(id)
);

-- alter animals table-drop species column add species_id, owner_id as foreign keys

ALTER TABLE animals
DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id),
ADD COLUMN owner_id INT REFERENCES owners(id);

/* Milestone 4 Join table for visits */

-- create vets table, create specializations, visits join tables

CREATE TABLE vets (
id INT GENERATED ALWAYS AS IDENTITY,
name TEXT,
age INT,
date_of_graduation DATE,
PRIMARY KEY(id)
);

CREATE TABLE specializations (
vet_id INT REFERENCES vets(id),
species_id INT REFERENCES species(id),
PRIMARY KEY (vet_id,species_id)
);

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(id)
);

/*  Performance audit exercise  */

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- add index on animal_id in visits table for optimization

CREATE INDEX animal_id_asc ON visits (animal_id ASC);

-- add index on vet_id in visits table
CREATE INDEX vet_id_desc ON visits (vet_id DESC);

-- Add Index on email column in owners table
CREATE INDEX email_id ON owners (email ASC);
