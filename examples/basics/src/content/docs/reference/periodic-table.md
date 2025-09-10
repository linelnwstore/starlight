---
title: Periodic Table Database
description: A comprehensive SQL schema demonstrating database design for the periodic table of elements.
---

This page demonstrates SQL syntax highlighting in Starlight using a comprehensive periodic table database schema.

## Database Overview

The periodic table database provides a complete relational schema for storing and querying information about chemical elements, their properties, isotopes, and relationships.

### Key Features

- **Complete element data**: All essential properties including atomic mass, electron configuration, and physical properties
- **Categorization**: Elements grouped by type (alkali metals, noble gases, etc.)
- **Isotope tracking**: Support for radioactive and stable isotopes
- **Historical data**: Discovery information and timeline
- **Performance optimized**: Proper indexing and constraints

## Schema Structure

### Main Tables

1. **periodic_elements** - Core element data
2. **element_categories** - Classification system
3. **electron_configurations** - Electron shell arrangements
4. **isotopes** - Isotope variations

### Sample Queries

Here are some example queries you can run against the database:

```sql
-- Find all noble gases
SELECT pe.symbol, pe.name, pe.atomic_number
FROM periodic_elements pe
JOIN element_categories ec ON pe.category_id = ec.id
WHERE ec.name = 'Noble gases'
ORDER BY pe.atomic_number;
```

```sql
-- Get elements discovered in the 18th century
SELECT symbol, name, discovered_year, discovered_by
FROM periodic_elements
WHERE discovered_year BETWEEN 1700 AND 1799
ORDER BY discovered_year;
```

## Implementation

The complete SQL implementation includes:

- **DDL statements** for table creation
- **Sample data** for the first 20 elements
- **Views** for common queries
- **Stored procedures** for complex operations
- **Triggers** for audit logging
- **Indexes** for performance optimization

## Usage Examples

### Basic Element Lookup

```sql
-- Get basic information about hydrogen
SELECT symbol, name, atomic_mass, period_number, group_number
FROM periodic_elements
WHERE symbol = 'H';
```

### Complex Analytical Queries

```sql
-- Find elements with similar properties
SELECT symbol, name, electronegativity, atomic_radius
FROM periodic_elements
WHERE electronegativity BETWEEN 2.0 AND 3.0
  AND atomic_radius BETWEEN 50 AND 100
ORDER BY electronegativity;
```

## File Structure

The complete database schema is available in the `periodic_table.sql` file, which includes:

- Schema creation statements
- Table definitions with proper constraints
- Sample data insertions
- Utility views and procedures
- Performance optimizations
- Documentation comments

This demonstrates how Starlight can effectively highlight SQL syntax and provide a clean, readable documentation experience for database schemas and technical content.