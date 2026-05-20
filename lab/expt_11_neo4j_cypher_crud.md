# Expt 11: CRUD on Graph Database using Cypher Query Language

## Objective
Perform CRUD operations using Neo4j Cypher.

## Sample Graph + CRUD
```cypher
// Create
CREATE (s1:Student {roll: 1, name: 'Asha', dept: 'CSE'});
CREATE (s2:Student {roll: 2, name: 'Ravi', dept: 'ECE'});
CREATE (s3:Student {roll: 3, name: 'Ira', dept: 'IT'});

CREATE (c1:Course {cid: 'DBMS', title: 'Advanced DBMS'});
CREATE (c2:Course {cid: 'NOSQL', title: 'NoSQL Systems'});

MATCH (s:Student {roll: 1}), (c:Course {cid: 'DBMS'})
CREATE (s)-[:ENROLLED_IN]->(c);

// Read
MATCH (s:Student) RETURN s;
MATCH (s:Student)-[r:ENROLLED_IN]->(c:Course) RETURN s.name, c.title;

// Update
MATCH (s:Student {roll: 2})
SET s.dept = 'AIML';

// Delete
MATCH (s:Student {roll: 3})
DETACH DELETE s;
```
