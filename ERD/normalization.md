## What is Normalization
Normalization is the process of structuring a relational database (e.g., PostgreSQL) to eliminate data redundancy, insertion/deletion/update anomalies, and ensure data integrity. It involves decomposing tables into smaller, well-organized tables that follow specific rules called normal forms.

#### Purpose
- Reduce Redundancy: Avoid storing the same data multiple times.
- Prevent Anomalies: Ensure updates don’t cause inconsistencies.
- Improve Efficiency: Optimize queries and storage, critical for  app’s performance.

### Steps to follow
Normalization progresses through First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF). Each step builds on the previous one. Below, I’ll explain each normal form and the steps to achieve it.

#### Step one
- Ensure all fields are atomic
- Remove repeating groups by creating separate rows or tables
- Add a primary key

#### Step two
- Identify the primary key (single or composite)
- Check if a non-key column depends on only part of the primary key
- Move partially dependent columns to a new table with the relevant key part

#### Step three
- Identify non-key attributes that depend on other non-key attributes
- Move these attributes to a new table with the attribute they depend on
- Link back using foreign key

## Review of entities
All the entities in the alx-aribnb-databse are 3NF comlient with all the attributes in each entity dependent only on the entity's primary key.

The only exception is the booking table where the attribute total_price is is derived.
