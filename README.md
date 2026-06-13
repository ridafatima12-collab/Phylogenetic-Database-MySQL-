# Phylogenetic Database System 🧬

A relational MySQL database storing biological and evolutionary data for 50+ species across 10 taxonomic groups. Built as a student-conceived group project at NUST (BS Bioinformatics).

---

## Schema Overview
species                   — scientific name, taxonomy, genome size

evolutionary_relationship — ancestor/descendant pairs, divergence time

genetic_sequence          — DNA, RNA, protein sequences per species

trait                     — categorized biological traits per species
---

## Taxonomic Coverage

Bacteria · Archaea · Fungi · Plants · Invertebrates · Fish · Amphibians · Reptiles · Birds · Mammals

---

## How to Run

**Requirements:** MySQL 8.0+

```sql
SOURCE phylogenetic_db.sql;
```

Or import via MySQL Workbench: Server → Data Import → Import from Self-Contained File.

---

## Concepts Applied

- Multi-table relational schema with `PRIMARY KEY` and `FOREIGN KEY` constraints
- `ENUM` for controlled vocabulary
- `CHECK` constraint to prevent self-referencing relationships
- Subquery-based `INSERT` for referential integrity
- `JOIN` queries across related tables
- `LONGTEXT` for biological sequence storage

---

## Project Context

Student-conceived group project for DBMS course at NUST (BS Bioinformatics) — Semester 2. Schema design and concept originated by the group. Progressed from basic table creation to a fully normalized multi-entity biological database.

---

## Files
phylogenetic_db.sql

README.md


