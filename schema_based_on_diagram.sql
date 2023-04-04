CREATE TABLE patients (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(255),
date_of_birth DATE
);

CREATE TABLE treatments (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
type VARCHAR(255),
name VARCHAR(255)
);

CREATE TABLE treatments (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
admitted_at TIMESTAMP,
patient_id INT REFERENCES patients(id),
status VARCHAR(255)
);