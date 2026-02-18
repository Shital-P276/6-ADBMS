# SQL Dialect Analysis

Based on the SQL scripts in this repository, the dialect is **Oracle SQL / Oracle Object-Relational SQL (Oracle Database)**.

## Evidence by file

### `B77_LAB02_28Jan.sql`
- Uses Oracle object types with `CREATE TYPE ... AS OBJECT`.
- Uses SQL*Plus-style `/` statement terminator after type definitions.
- Uses object table syntax `CREATE TABLE ... OF <object_type>`.
- Uses object constructors in `INSERT` statements.

### `B77_LAB03_04Feb.sql`
- Uses Oracle-specific subtype inheritance: `CREATE TYPE ... UNDER ...`.
- Uses Oracle type modifiers `NOT FINAL`.
- Uses Oracle DDL options `DROP TYPE ... FORCE` and `DROP TABLE ... CASCADE CONSTRAINTS`.
- Uses object-relational table syntax `CREATE TABLE ... OF <subtype>`.

### `B77_LAB03-02_04Feb.sql`
- Uses Oracle `REF` and `DEREF` semantics for object references.
- Uses object navigation `s.address_ref.city` (Oracle object-relational feature).
- Uses `CREATE TABLE ... OF <object_type>` and object inheritance with `UNDER`.

## Conclusion
These scripts are written for **Oracle Database** and specifically use Oracle's object-relational extensions, not generic ANSI SQL.
