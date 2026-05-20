# Expt 11: Perform CRUD on Graph Database using Cypher Query Language

## Objective
Create graph data and perform full CRUD operations in Neo4j.

## Complete Cypher Script
```cypher
// 1) Clean old sample graph
MATCH (n:Student) DETACH DELETE n;
MATCH (n:Course) DETACH DELETE n;

// 2) Create nodes
CREATE (s1:Student {roll: 1, name: 'Asha', dept: 'CSE'});
CREATE (s2:Student {roll: 2, name: 'Ravi', dept: 'ECE'});
CREATE (s3:Student {roll: 3, name: 'Ira', dept: 'IT'});
CREATE (s4:Student {roll: 4, name: 'Neha', dept: 'MECH'});

CREATE (c1:Course {cid: 'DBMS', title: 'Advanced DBMS'});
CREATE (c2:Course {cid: 'NOSQL', title: 'NoSQL Systems'});

// 3) Create relationships
MATCH (s:Student {roll: 1}), (c:Course {cid: 'DBMS'})
CREATE (s)-[:ENROLLED_IN]->(c);

MATCH (s:Student {roll: 2}), (c:Course {cid: 'NOSQL'})
CREATE (s)-[:ENROLLED_IN]->(c);

// 4) Read queries
MATCH (s:Student) RETURN s ORDER BY s.roll;
MATCH (c:Course) RETURN c;
MATCH (s:Student)-[:ENROLLED_IN]->(c:Course)
RETURN s.name AS student, c.title AS course;

// 5) Update node property
MATCH (s:Student {roll: 2})
SET s.dept = 'AIML';

// 6) Delete one student node
MATCH (s:Student {roll: 4})
DETACH DELETE s;

// 7) Final output
MATCH (s:Student) RETURN s ORDER BY s.roll;
```

## Useful execution command
```bash
cypher-shell -u neo4j -p <password> -f expt11.cypher
```
