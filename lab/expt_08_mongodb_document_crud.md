# Expt 08: Perform CRUD on Document Database using MongoDB

## Objective
Execute complete CRUD operations in MongoDB with sample student documents.

## Complete mongosh Script
```javascript
use adbms_lab

// 1) Create collection explicitly (optional)
db.createCollection("students")

// 2) Insert sample rows (4 docs)
db.students.insertMany([
  { roll: 1, name: "Asha", dept: "CSE", cgpa: 8.4 },
  { roll: 2, name: "Ravi", dept: "ECE", cgpa: 7.9 },
  { roll: 3, name: "Ira", dept: "IT", cgpa: 8.8 },
  { roll: 4, name: "Neha", dept: "MECH", cgpa: 7.5 }
])

// 3) Read all
db.students.find({}, { _id: 0 })

// 4) Read with filter
db.students.find({ dept: "CSE" }, { _id: 0 })

// 5) Update one
db.students.updateOne(
  { roll: 2 },
  { $set: { dept: "AIML", cgpa: 8.1 } }
)

// 6) Update many
db.students.updateMany(
  { cgpa: { $lt: 8.0 } },
  { $set: { remark: "Improve" } }
)

// 7) Delete one
db.students.deleteOne({ roll: 4 })

// 8) Final output
db.students.find({}, { _id: 0 })
```
