-- ==========================================
-- PHYLOGENETIC DATABASE SYSTEM
-- ==========================================

CREATE DATABASE phylogenetic_db;

USE phylogenetic_db;

-- ==========================================
-- SPECIES TABLE
-- ==========================================

CREATE TABLE species (
    species_id INT PRIMARY KEY AUTO_INCREMENT,
    scientific_name VARCHAR(100) NOT NULL UNIQUE,
    common_name VARCHAR(100),
    kingdom VARCHAR(50),
    phylum VARCHAR(50),
    class_name VARCHAR(50),
    genome_size_mb FLOAT
);

-- ==========================================
-- EVOLUTIONARY RELATIONSHIP TABLE
-- ==========================================

CREATE TABLE evolutionary_relationship (
    relationship_id INT PRIMARY KEY AUTO_INCREMENT,
    ancestor_species_id INT NOT NULL,
    descendant_species_id INT NOT NULL,
    divergence_time_mya FLOAT,
    evidence_type VARCHAR(50),

    FOREIGN KEY (ancestor_species_id)
        REFERENCES species(species_id),

    FOREIGN KEY (descendant_species_id)
        REFERENCES species(species_id),

    CHECK (ancestor_species_id <> descendant_species_id)
);

-- ==========================================
-- GENETIC SEQUENCE TABLE
-- ==========================================

CREATE TABLE genetic_sequence (
    sequence_id INT PRIMARY KEY AUTO_INCREMENT,
    species_id INT NOT NULL,

    sequence_type ENUM('DNA','RNA','Protein'),

    gene_name VARCHAR(100),

    sequence_data LONGTEXT,

    FOREIGN KEY (species_id)
        REFERENCES species(species_id)
);

-- ==========================================
-- TRAIT TABLE
-- ==========================================

CREATE TABLE trait (
    trait_id INT PRIMARY KEY AUTO_INCREMENT,
    species_id INT NOT NULL,
    trait_name VARCHAR(100),
    trait_value VARCHAR(100),
    trait_category VARCHAR(50),

    FOREIGN KEY (species_id)
        REFERENCES species(species_id)
);

-- ==========================================
-- SAMPLE SPECIES DATA
-- ==========================================

INSERT INTO species
(scientific_name, common_name, kingdom, phylum, class_name, genome_size_mb)
VALUES
('Ancestor_LUCA','Last Universal Common Ancestor',NULL,NULL,NULL,NULL),
('Homo sapiens','Human','Animalia','Chordata','Mammalia',3200),
('Pan troglodytes','Chimpanzee','Animalia','Chordata','Mammalia',3100),
('Escherichia coli','E. coli','Bacteria','Proteobacteria','Gammaproteobacteria',4.6),
('Arabidopsis thaliana','Thale Cress','Plantae','Tracheophyta','Magnoliopsida',135);

-- ==========================================
-- SAMPLE EVOLUTIONARY RELATIONSHIPS
-- ==========================================

INSERT INTO evolutionary_relationship
(
    ancestor_species_id,
    descendant_species_id,
    divergence_time_mya,
    evidence_type
)
VALUES
(
    (SELECT species_id FROM species
     WHERE scientific_name='Ancestor_LUCA'),

    (SELECT species_id FROM species
     WHERE scientific_name='Escherichia coli'),

    3800,
    'molecular'
);

-- ==========================================
-- SAMPLE TRAITS
-- ==========================================

INSERT INTO trait
(species_id, trait_name, trait_value, trait_category)
VALUES
(
    (SELECT species_id
     FROM species
     WHERE scientific_name='Homo sapiens'),
    'bipedal',
    'true',
    'behavioral'
),
(
    (SELECT species_id
     FROM species
     WHERE scientific_name='Homo sapiens'),
    'language',
    'complex',
    'behavioral'
),
(
    (SELECT species_id
     FROM species
     WHERE scientific_name='Escherichia coli'),
    'cell wall',
    'true',
    'structural'
);

-- ==========================================
-- VALIDATION QUERIES
-- ==========================================

SELECT COUNT(*) AS total_species
FROM species;

SELECT COUNT(*) AS total_relationships
FROM evolutionary_relationship;

SELECT COUNT(*) AS total_traits
FROM trait;

-- ==========================================
-- EVOLUTION TREE QUERY
-- ==========================================

SELECT
    a.common_name AS ancestor,
    d.common_name AS descendant,
    er.divergence_time_mya AS mya,
    er.evidence_type
FROM evolutionary_relationship er

JOIN species a
    ON a.species_id = er.ancestor_species_id

JOIN species d
    ON d.species_id = er.descendant_species_id

ORDER BY er.divergence_time_mya DESC;
