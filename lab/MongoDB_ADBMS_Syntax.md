# MongoDB ADBMS Lab — Syntax Quick Reference
> Experiment 8 | CRUD + Retrieval + Aggregation | For external exam recall

---

## Hierarchy (Viva)

```
Database → Collection → Document → Fields
RDBMS:  Database → Table    → Row      → Columns
```

---

## Setup

```js
use CollegeDB                          // create/switch database
db.createCollection("student")         // create collection
```

---

## CREATE

### Insert One
```js
db.student.insertOne({
    roll: 101,
    name: "Shital",
    city: "Pune",
    marks: 80
})
```

### Insert Many
```js
db.student.insertMany([
    { roll: 102, name: "Rahul", city: "Mumbai", marks: 70 },
    { roll: 103, name: "Amit",  city: "Pune",   marks: 90 }
])
```

---

## READ

```js
db.student.find()                      // all documents
db.student.find().pretty()             // formatted output

db.student.find({ roll: 101 })         // find by field

// Projection: show only name and city, hide _id
db.student.find(
    {},                                // filter (empty = all)
    { name: 1, city: 1, _id: 0 }      // 1 = show, 0 = hide
)
```

**Memory:** `find(filter, projection)` — two arguments

---

## UPDATE

### Update One
```js
db.student.updateOne(
    { roll: 101 },                     // filter (who)
    { $set: { city: "Kolhapur" } }     // what to change
)
```

### Update Many
```js
db.student.updateMany(
    { city: "Pune" },
    { $set: { state: "Maharashtra" } }
)
```

**Memory:** Always `{ $set: { field: value } }` — never skip `$set`

---

## DELETE

```js
db.student.deleteOne({ roll: 101 })    // delete first match
db.student.deleteMany({ city: "Pune"}) // delete all matches
```

---

## COMPARISON OPERATORS

| Operator | Meaning           | SQL Equivalent |
|----------|-------------------|----------------|
| `$gt`    | greater than      | `> `           |
| `$lt`    | less than         | `< `           |
| `$gte`   | greater or equal  | `>=`           |
| `$lte`   | less or equal     | `<=`           |
| `$ne`    | not equal         | `<>`           |

```js
db.student.find({ marks: { $gt: 70 } })     // marks > 70
db.student.find({ marks: { $gte: 70 } })    // marks >= 70
db.student.find({ marks: { $lt: 50 } })     // marks < 50
db.student.find({ roll:  { $ne: 101 } })    // roll != 101
```

---

## LOGICAL OPERATORS

### AND (just use comma)
```js
db.student.find({ city: "Pune", marks: { $gt: 70 } })
// SQL: WHERE city='Pune' AND marks>70
```

### OR
```js
db.student.find({
    $or: [
        { city: "Pune" },
        { city: "Mumbai" }
    ]
})
// SQL: WHERE city='Pune' OR city='Mumbai'
```

### IN
```js
db.student.find({
    city: { $in: ["Pune", "Mumbai"] }
})
// SQL: WHERE city IN ('Pune','Mumbai')
```

---

## SORTING, LIMIT, SKIP

```js
db.student.find().sort({ marks: 1 })      // ASC  (1 = ascending)
db.student.find().sort({ marks: -1 })     // DESC (-1 = descending)

db.student.find().limit(3)                // top 3
db.student.find().skip(2)                 // skip first 2

// Top scorer
db.student.find().sort({ marks: -1 }).limit(1)

// Pune students sorted by marks descending
db.student.find({ city: "Pune" }).sort({ marks: -1 })
```

**Memory:** `1 = ASC`, `-1 = DESC`

---

## CHAINED QUERY (Full Example)

```js
db.student.find(
    { marks: { $gt: 70 } },            // filter
    { name: 1, marks: 1, _id: 0 }      // projection
)
.sort({ marks: -1 })                   // sort
.limit(3)                              // top 3
```

**Order:** `find → sort → limit → skip`

---

## AGGREGATION

### Basic Syntax
```js
db.student.aggregate([
    { stage1 },
    { stage2 },
    ...
])
```

### Count all
```js
db.student.countDocuments()
```

### $match (= WHERE)
```js
db.student.aggregate([
    { $match: { city: "Pune" } }
])
```

### $group (= GROUP BY)
```js
// Group by city, count each
db.student.aggregate([
    {
        $group: {
            _id: "$city",              // group by field (needs $)
            count: { $sum: 1 }
        }
    }
])
// SQL: SELECT city, COUNT(*) FROM student GROUP BY city
```

### All Aggregates at once
```js
db.student.aggregate([
    {
        $group: {
            _id: null,                 // null = entire collection
            total:   { $sum: "$marks" },
            average: { $avg: "$marks" },
            highest: { $max: "$marks" },
            lowest:  { $min: "$marks" }
        }
    }
])
```

### $match + $group (= WHERE + GROUP BY)
```js
db.student.aggregate([
    { $match: { marks: { $gt: 70 } } },   // filter first
    {
        $group: {
            _id: "$city",
            count: { $sum: 1 }
        }
    }
])
```

### $sort inside aggregate
```js
db.student.aggregate([
    { $group: { _id: "$city", count: { $sum: 1 } } },
    { $sort:  { count: -1 } }             // sort by count DESC
])
```

**Aggregation Order:** `$match → $group → $sort`

---

## SQL vs MongoDB (Viva Table)

| SQL          | MongoDB                  |
|--------------|--------------------------|
| SELECT *     | find()                   |
| WHERE        | filter / `$match`        |
| GROUP BY     | `$group`                 |
| ORDER BY ASC | sort({ field: 1 })       |
| ORDER BY DESC| sort({ field: -1 })      |
| LIMIT        | limit()                  |
| OFFSET       | skip()                   |
| COUNT(*)     | countDocuments() / $sum:1|
| SUM          | `$sum`                   |
| AVG          | `$avg`                   |
| MAX          | `$max`                   |
| MIN          | `$min`                   |

---

## 30-Second Recall

```
SETUP:       use DB  →  createCollection

INSERT:      insertOne({ })   insertMany([ {},{} ])

READ:        find()   find({filter})   find({},{projection})

UPDATE:      updateOne({filter}, {$set:{field:val}})
             updateMany({filter},{$set:{field:val}})

DELETE:      deleteOne({filter})   deleteMany({filter})

OPERATORS:   $gt  $lt  $gte  $lte  $ne
             $or:[{},{}]   $in:[val,val]

SORT/LIMIT:  sort({field:1})   sort({field:-1})
             limit(n)   skip(n)

AGGREGATE:   aggregate([])
             $match  →  $group  →  $sort
             $sum  $avg  $max  $min
             _id:"$field"  to group
             _id:null  for whole collection

KEY:         1 = ASC,  -1 = DESC
             _id:0  to hide object id in projection
             $ prefix on field name inside $group
```
