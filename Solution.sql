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
    sighting_time TIMESTAMP NOT NULL,
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


-- problem 2
SELECT count(DISTINCT species_id) AS unique_species_count FROM sightings;


-- problem 3
SELECT * FROM sightings
    WHERE "location" LIKE '%Pass%';







-- INSERT INTO rangers("name", region)
-- VALUES ('Alice Green', 'Dhaka');
-- INSERT INTO sightings (sighting_id, species_id, ranger_id, "location", "sighting_time", notes)
-- VALUES (100, 2, 5, 'Dhaka', '2025-05-18 18:30:00', 'Dhakay Dekhsi Go');

-- problem 4
SELECT "name", count(*) FROM rangers
INNER JOIN sightings USING(ranger_id)
GROUP BY ranger_id; --here if we group by name, it will wrong, because same name person can appear but their ranger_id is different, and the query says to select *each* ranger



--problem 5
SELECT common_name FROM species LEFT JOIN sightings
USING(species_id) WHERE sighting_id IS NULL;



--problem 6
SELECT common_name, sighting_time, "name" FROM species INNER JOIN
sightings USING(species_id) ORDER BY sighting_time;

CREATE View sightings_ranger
AS 
SELECT sighting_id, ranger_id, "name" FROM sightings
LEFT JOIN rangers USING(ranger_id);

CREATE View sightings_species
AS
SELECT sighting_id, species_id, common_name, sighting_time
FROM sightings LEFT JOIN
species USING(species_id);

DROP VIEW sightings_ranger;
DROP VIEW sightings_species;
SELECT * FROM sightings_ranger;
SELECT * FROM sightings_species;


SELECT common_name, sighting_time, "name"
FROM sightings_ranger
INNER JOIN sightings_species
USING(sighting_id) ORDER BY sighting_time DESC LIMIT 2;


--problem 6 end



--problem 7
UPDATE  species 
SET conservation_status = 'Historic'
WHERE extract(year FROM discovery_date) < 1800;
--problem 7 end

SELECT * FROM species;




-- problem 8
SELECT sighting_id, 
CASE 
    WHEN extract(hour FROM sighting_time)
     BETWEEN 0 AND 11 THEN 'Morning'
    WHEN extract(hour FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN extract(hour FROM sighting_time) BETWEEN 17 AND 24 THEN 'Evening'  
END AS time_of_day
FROM sightings;
