# Neo4j ADBMS Lab — Syntax Quick Reference
> Experiment 11 | CRUD + Relationships + Pattern Matching + Aggregation | For external exam recall

---

## Hierarchy (Viva)

```
Neo4j:  Node  →  Relationship  →  Property  →  Label
RDBMS:  Row   →  Foreign Key   →  Column    →  Table
```

---

## Cypher Symbols

```
()          node
[]          relationship
-->  <--    direction
:Label      label on node or relationship
{}          properties
```

---

## CREATE

### One Node
```cypher
CREATE (s:Student {
    roll: 101,
    name: "Shital",
    city: "Pune",
    marks: 80
});
```

### Multiple Nodes
```cypher
CREATE
(s1:Student { roll: 101, name: "Shital" }),
(s2:Student { roll: 102, name: "Rahul" });
```

---

## READ

```cypher
MATCH (n) RETURN n;                          -- all nodes

MATCH (s:Student) RETURN s;                  -- all students

MATCH (s:Student { roll: 101 }) RETURN s;    -- one student
```

**Memory:** `MATCH → RETURN` always together

---

## UPDATE

```cypher
-- Change existing property
MATCH (s:Student { roll: 101 })
SET s.city = "Kolhapur"
RETURN s;

-- Add new property
MATCH (s:Student { roll: 101 })
SET s.age = 21
RETURN s;

-- Update multiple properties
MATCH (s:Student { roll: 101 })
SET s.city = "Kolhapur", s.marks = 90
RETURN s;
```

**Memory:** `MATCH → SET → RETURN`

---

## DELETE

```cypher
-- Delete node (no relationships)
MATCH (s:Student { roll: 101 })
DELETE s;

-- Delete node + its relationships
MATCH (s:Student { roll: 101 })
DETACH DELETE s;
```

**Viva:** Always use `DETACH DELETE` if node has relationships, else error.

| DELETE          | DETACH DELETE              |
|-----------------|----------------------------|
| Node only       | Node + all its relationships |
| Fails if has relationships | Safe always     |

---

## RELATIONSHIPS

### Create Relationship
```cypher
-- First match both nodes, then create relationship
MATCH
    (a:Student { name: "Shital" }),
    (b:Student { name: "Rahul" })
CREATE (a)-[:FRIEND]->(b);
```

### Relationship with Property
```cypher
MATCH
    (a:Student { name: "Shital" }),
    (b:Student { name: "Rahul" })
CREATE (a)-[:FRIEND { since: 2024 }]->(b);
```

### View All Relationships
```cypher
MATCH (a)-[r]->(b) RETURN a, r, b;
```

---

## PATTERN MATCHING

```cypher
-- Find all friend pairs
MATCH (a:Student)-[:FRIEND]->(b)
RETURN a, b;

-- Find who is friend of Rahul
MATCH (a)-[:FRIEND]->(b { name: "Rahul" })
RETURN a, b;

-- Any relationship (direction doesn't matter)
MATCH (n)--(m) RETURN n, m;
```

---

## WHERE CLAUSE

```cypher
MATCH (s:Student)
WHERE s.marks > 70
RETURN s;

-- AND
MATCH (s:Student)
WHERE s.city = "Pune" AND s.marks > 70
RETURN s;

-- OR
MATCH (s:Student)
WHERE s.city = "Pune" OR s.city = "Mumbai"
RETURN s;
```

---

## COMPARISON OPERATORS

| Cypher | Meaning       |
|--------|---------------|
| `>`    | greater than  |
| `<`    | less than     |
| `>=`   | greater equal |
| `<=`   | less equal    |
| `=`    | equal         |
| `<>`   | not equal     |

---

## SORTING, LIMIT, SKIP

```cypher
-- Ascending
MATCH (s:Student) RETURN s ORDER BY s.marks;

-- Descending
MATCH (s:Student) RETURN s ORDER BY s.marks DESC;

-- Top 1 (highest scorer)
MATCH (s:Student) RETURN s ORDER BY s.marks DESC LIMIT 1;

-- Skip first 2
MATCH (s:Student) RETURN s SKIP 2;
```

---

## AGGREGATION

```cypher
MATCH (s:Student) RETURN COUNT(s);        -- count
MATCH (s:Student) RETURN MAX(s.marks);    -- max
MATCH (s:Student) RETURN MIN(s.marks);    -- min
MATCH (s:Student) RETURN AVG(s.marks);    -- avg
MATCH (s:Student) RETURN SUM(s.marks);    -- sum

-- Group by city (count city-wise)
MATCH (s:Student)
RETURN s.city, COUNT(*)
-- SQL: SELECT city, COUNT(*) FROM student GROUP BY city
```

---

## GRAPH TRAVERSAL

```cypher
-- All paths between any two students
MATCH p = (a:Student)-[*]->(b:Student)
RETURN p;

-- Shortest path
MATCH p = shortestPath((a)-[*]->(b))
RETURN p;
```

**Viva use cases for shortestPath:** GPS, Social Networks, Recommendation Systems

---

## SQL vs Cypher (Viva Table)

| SQL              | Cypher                         |
|------------------|--------------------------------|
| SELECT *         | MATCH (n) RETURN n             |
| WHERE marks > 70 | WHERE s.marks > 70             |
| INSERT           | CREATE                         |
| UPDATE SET       | SET                            |
| DELETE           | DELETE / DETACH DELETE         |
| JOIN             | Relationship traversal `-[]->`  |
| ORDER BY DESC    | ORDER BY field DESC            |
| LIMIT            | LIMIT                          |
| COUNT(*)         | COUNT(s)                       |
| GROUP BY city    | RETURN s.city, COUNT(*)        |

---

## Common External Programs

### Program 1 — Create and Display
```cypher
CREATE (s:Student { roll: 101, name: "Shital" });
MATCH (s) RETURN s;
```

### Program 2 — Create Friendship
```cypher
CREATE (a:Student { name: "Shital" });
CREATE (b:Student { name: "Rahul" });

MATCH
    (x:Student { name: "Shital" }),
    (y:Student { name: "Rahul" })
CREATE (x)-[:FRIEND]->(y);

MATCH (n) RETURN n;
```

### Program 3 — Update
```cypher
MATCH (s:Student { name: "Shital" })
SET s.city = "Pune"
RETURN s;
```

### Program 4 — Delete
```cypher
MATCH (s:Student { name: "Shital" })
DETACH DELETE s;
```

---

## 30-Second Recall

```
SYMBOLS:     ()=node  []=relationship  :Label  {}=properties

CREATE:      CREATE (s:Student { roll:101, name:"Shital" });

READ:        MATCH (n) RETURN n;
             MATCH (s:Student { roll:101 }) RETURN s;

UPDATE:      MATCH (s:Student { roll:101 })
             SET s.city = "Pune"
             RETURN s;

DELETE:      DETACH DELETE s;    ← always use DETACH

RELATION:    MATCH (a:Student{name:"X"}),(b:Student{name:"Y"})
             CREATE (a)-[:FRIEND]->(b);

PATTERN:     MATCH (a)-[:FRIEND]->(b) RETURN a,b;

WHERE:       WHERE s.marks > 70
             WHERE s.city="Pune" AND s.marks > 70

SORT/LIMIT:  ORDER BY s.marks DESC   LIMIT 1   SKIP 2

AGGREGATES:  COUNT  MAX  MIN  AVG  SUM

TRAVERSAL:   shortestPath((a)-[*]->(b))

KEY RULE:    MATCH + RETURN always go together
             Use DETACH DELETE when relationships exist
```
