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
