use B77

//insert one
db.Sample.insertOne({
  name:"Alice",
  age:28,
  status:"Active"
})

//insert many
db.Sample.insertMany([
  {name:"Bob",age:32,status:"Inactive"},
  {name:"Charlie",age:24,status:"Inactive"}
])

db.Sample.find().pretty()

//updateone with filter and change
db.Sample.updateOne(
  {name:"Bob"}
  {$set: {status: "Active"}}
)

//update many
db.Sample.updateMany(
  {status:"Active"},
  { $set: {action:"deployed"}
)


db.Sample.find({status:"Active"})

//delete one with filter
db.Sample.deleteOne({ name: "Charlie" })

//implicit and in find
db.Sample.find({ 
  name: "Alice", 
  status: "Active" 
})

//explicit and in find
db.Sample.find({
  $and: [
    { age: { $gt: 20 } },
    { age: { $lt: 30 } }
  ]
})

//explicit or in find
db.Sample.find({
  $or: [
    { name: "Alice" },
    { name: "Bob" }
  ]
})

//explicit find in same field with diff values
db.Sample.find({ name: { $in: ["Alice", "Bob"] } })

