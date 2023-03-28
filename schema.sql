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