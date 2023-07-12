/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(70),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(50),
    age INT
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT REFERENCES species;
ALTER TABLE animals ADD owner_id INT REFERENCES owners;
