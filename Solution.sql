-- Active: 1747586299054@@127.0.0.1@5432@conservation_db

CREATE DATABASE conservation_db;

CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    region VARCHAR(70) NOT NULL 
)

DROP Table rangers;


CREATE Table species (
    species_id SERIAL PRIMARY KEY NOT NULL,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL UNIQUE,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(30) NOT NULL
)

CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id) NOT NULL,
    ranger_id INT REFERENCES rangers(ranger_id) NOT NULL,
    "location" VARCHAR(50) NOT NULL,
    sighting_time DATE NOT NULL,
    notes TEXT
)


INSERT INTO rangers(name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');





INSERT INTO sightings(sighting_id, species_id, ranger_id, "location", sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


DROP Table rangers;

DROP Table species;

DROP table sightings;


SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;

-- problem 1
INSERT INTO rangers("name", region)
    VALUES ('Derek Fox', 'Coastal Plains');