# Expt 08: CRUD on Document Database using MongoDB

## Objective
Perform CRUD operations on MongoDB collection.

## Database and Collection
- Database: `adbms_lab`
- Collection: `students`

## Sample Data + CRUD (mongosh)
```javascript
use adbms_lab

db.students.insertMany([
  { roll: 1, name: "Asha", dept: "CSE", cgpa: 8.4 },
  { roll: 2, name: "Ravi", dept: "ECE", cgpa: 7.9 },
  { roll: 3, name: "Ira", dept: "IT",  cgpa: 8.8 }
])

// Read
db.students.find({}, { _id: 0 })

// Update
db.students.updateOne(
  { roll: 2 },
  { $set: { cgpa: 8.1 } }
)

// Delete
db.students.deleteOne({ roll: 3 })
```
