# Migration Naming Convention

This document outlines the naming rules for SQL migrations to ensure consistency and simplify database management. All migration names must follow the structure below. Change descriptions are written in English for universality.

## Key Principles
- Use lowercase letters in all file names for consistency.
- Ensure order numbers are unique within a single day.
- Avoid spaces and special characters in descriptions.
  
## Basic Notation Structure

`V<Year><Month><Day>_<Order>__<Type>__<Object>__<Action>__<Description>.sql`

The `V` prefix (Version) denotes the migration version, aligning with standards used by migration tools like Flyway.

## Separators

- `__` (double underscore) — separates major semantic blocks for clear distinction of components.
- `_` (single underscore) — used within blocks (e.g., in dates or descriptions) to connect words.

## Block Details

### 1. Version and Order (`V<Year><Month><Day>_<Order>`)

- `V20250921` — Date of script creation in YYYYMMDD format, ensuring chronological order.
- `_1010` — Sequential order number within a day, a four-digit number with a step of 10 (e.g., 1010, 1020, 1030). This allows inserting migrations between existing ones, e.g., 1015 between 1010 and 1020.

Example: `V20250921_1010`

### 2. Script Type (`<Type>`)

A short designation of the operation type. Main options:

| Abbreviation | Full Name | Description |
| --- | --- | --- |
| DDL | Data Definition Language | Structural operations: CREATE, ALTER, DROP |
| DML | Data Manipulation Language | Data operations: INSERT, UPDATE, DELETE |
| F | Function | Function creation/modification |
| V | View | View creation/modification |
| SP | Stored Procedure | Stored procedure creation/modification |
| TR | Trigger | Trigger creation/modification |
| SCH | Schema | Database schema operations |
| REF | Reference Data | Populating reference data (e.g., types, options) |
| CF | Configuration | Configuration data |
| SEC | Security | Granting permissions, roles |

Example: `V20250921_1010__DDL`

### 3. Object (`<Object>`)

Name of the table, schema, or other database object being modified. For reference data, use a specific entity name (e.g., `country`, `currency`) or the generic `reference` if the entity is not tied to a specific table.

Examples:

- `users`
- `product`
- `order`
- `schemaname` (for schema operations)
- `country` (for reference data)

Example: `V20250921_1010__DDL__users`

### 4. Action (`<Action>`)

Type of operation performed on the object.

| Abbreviation | Full Name | Description |
| --- | --- | --- |
| create | CREATE | Creating a new object |
| alter | ALTER | Modifying an existing object |
| drop | DROP | Deleting an object |
| add | ADD | Adding a column/constraint |
| fk | Foreign Key | Adding a foreign key |
| idx | Index | Creating an index |
| insert | INSERT | Inserting data |
| update | UPDATE | Updating data |
| delete | DELETE | Deleting data |
| grant | GRANT | Granting privileges |

Example: `V20250921_1010__DDL__users__create`

### 5. Description (`<Description>`)

A brief English description explaining the change. Use meaningful names, keeping descriptions concise (recommended 5-7 words). Separate words with single underscores.

Examples:

- `add_email_verification`
- `new_product_categories`
- `fix_incorrect_prices`

Example: `V20250921_1010__DDL__users__create__add_email_verification.sql`

## Example Migration Names

- Creating a users table:\
  `V20250921_1010__DDL__users__create.sql`
- Adding a phone_number column:\
  `V20250921_1020__DDL__users__add_phone_number.sql`
- Creating an index on email:\
  `V20250921_1030__DDL__users__idx_email.sql`
- Populating the country table (reference data):\
  `V20250921_1040__REF__country__insert.sql`
- Creating a stored procedure for reporting:\
  `V20250921_1050__SP__user_report__create.sql`
- Granting read permissions:\
  `V20250921_1060__SEC__readers_role__grant.sql`
- Creating a trigger for change logging:\
  `V20250921_1070__TR__users__create_log_trigger.sql`
- Updating configuration data:\
  `V20250921_1080__CF__settings__update_default_values.sql`

## General Guidelines

- Use lowercase letters in file names for consistency.
- Avoid spaces and special characters in `<Description>`.
- Ensure the order number is unique within a single day.
- If a new operation type arises, coordinate with the team and update the type table.