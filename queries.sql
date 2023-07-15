/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg> 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name!= 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT dlt1;
UPDATE animals SET weight_kg=weight_kg*-1;
ROLLBACK TO SAVEPOINT dlt1;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE SIGN(weight_kg)=-1;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts =0;
SELECT AVG(weight_kg) FROM animals;
SELECT SUM(escape_attempts) AS escape_attempts, neutered FROM animals GROUP BY neutered;
SELECT MIN(weight_kg),MAX(weight_kg),species FROM animals GROUP BY species;
SELECT AVG(escape_attempts) as AVG_escape_attempts,species FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT * 
   FROM animals LEFT JOIN owners
   ON animals.owner_id = owners.id
   WHERE full_name = 'Melody Pond';

SELECT * 
   FROM animals LEFT JOIN species
   ON animals.species_id = species.id
   WHERE species.name = 'Pokemon';

SELECT * 
   FROM owners FULL OUTER JOIN animals
   ON owners.id = animals.owner_id;

SELECT COUNT(*), species.name
   FROM animals JOIN species
   ON animals.species_id = species.id
   GROUP BY species.name;

SELECT * 
   FROM animals JOIN owners
   ON animals.owner_id = owners.id
   JOIN species
   ON animals.species_id = species.id
   WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT *
   FROM animals JOIN owners
   ON animals.owner_id = owner_id
   WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT COUNT(*), owners.full_name
   FROM animals JOIN owners
   ON animals.owner_id = owners.id
   GROUP BY owners.full_name
   ORDER BY COUNT DESC LIMIT 1;

SELECT vets.name, animals.name , date_of_visit
   FROM animals JOIN visits
   ON animals.id = visits.animals_id
   JOIN vets
   ON vets.id = visits.vets_id 
   WHERE vets.name = 'William Tatcher'
   ORDER BY date_of_visit DESC LIMIT 1;

SELECT vets.name, COUNT(visits.date_of_visit) 
   FROM visits JOIN vets
   ON vets.id = visits.vets_id
   WHERE vets.name = 'Stephanie Mendez';
   GROUP BY vets.name;

SELECT vets.name, specializations.species_id, specializations.vets_id, species.name
   FROM specializations FULL OUTER JOIN species
   ON specializations.id = species.id
   FULL OUTER JOIN vets
   ON specializations.vets_id = vets.id;

SELECT vets.name, animals.name , visits.date_of_visit
   FROM animals JOIN visits
   ON animals.id = visits.animals_id
   JOIN vets
   ON vets.id = visits.vets_id
   WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits.date_of_visit)
   FROM animals JOIN visits
   ON animals.id = visits.animals_id
   GROUP BY animals.name
   ORDER BY COUNT DESC LIMIT 1;

SELECT vets.name, animals.name , visits.date_of_visit
   FROM vets JOIN visits
   ON vets.id = visits.vets_id
   JOIN animals
   ON visits.animals_id = animals.id
   WHERE vets.name = 'Maisy Smith'
   ORDER BY visits.date_of_visit ASC LIMIT 1;

SELECT animals.id, animals.name, animals.date_of_birth,animals.neutered,vets.name,vets.age,visits.date_of_visit
   FROM animals JOIN visits
   ON animals.id = visits.animals_id
   JOIN vets
   ON vets.id = visits.vets_id
   ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT vets.name, COUNT(visits.date_of_visit)
   FROM vets JOIN visits
   ON vets.id = visits.vets_id
   JOIN specializations
   ON visits.vets_id = specializations.vets_id
   WHERE specializations.species_id IS NULL
   GROUP BY vets.name;

SELECT vets.name,species.name, COUNT(species.name)
   FROM visits JOIN animals
   ON visits.animals_id = animals.id
   JOIN vets
   ON visits.vets_id = vets_id
   JOIN species
   ON species.id = animals.species_id
   GROUP BY vets.name, species.name
   ORDER BY COUNT DESC LIMIT 1;