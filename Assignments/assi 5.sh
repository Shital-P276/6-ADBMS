// Shital Patil
// B77  B-II 
// MongoDB CRUD - Hostel Management

// switch to hostelDB
use hosteldb

switched to db hosteldb



// insert one -----------------------------------------------------------------
db.hostels.insertOne({
  hostel_id: "H1",
  hostel_name: "Boys Hostel A",
  no_of_rooms: 2,
  no_of_students: 3,
  rooms: [
    {
      room_id: "R101",
      capacity: 3,
      occupied: 2,
      furniture: [
        { furniture_id: "F1", type: "Bed" },
        { furniture_id: "F2", type: "Table" }
      ]
    },
    {
      room_id: "R102",
      capacity: 2,
      occupied: 1,
      furniture: [
        { furniture_id: "F3", type: "Bed" }
      ]
    }
  ]
})

{
  acknowledged: true,
  insertedId: ObjectId('69dfb60e0671fff6e64cdedf')
}


db.students.insertOne({
  student_id: "S201",
  fname: "Neha",
  lname: "Kulkarni",
  mob_no: "9000000001",
  dept: "IT",
  year_of_study: 3,
  hostel_id: "H1",
  room_id: "R101",
  visitors: []
})

{
  acknowledged: true,
  insertedId: ObjectId('69dfb6620671fff6e64cdee0')
}


// insert many 
db.students.insertMany([
  {
    student_id: "S202",
    fname: "Rohit",
    lname: "Patil",
    mob_no: "9000000002",
    dept: "CSE",
    year_of_study: 2,
    hostel_id: "H1",
    room_id: "R101",
    visitors: []
  },
  {
    student_id: "S203",
    fname: "Sneha",
    lname: "Jadhav",
    mob_no: "9000000003",
    dept: "ENTC",
    year_of_study: 1,
    hostel_id: "H1",
    room_id: "R102",
    visitors: []
  }
])

{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('69dfb6690671fff6e64cdee1'),
    '1': ObjectId('69dfb6690671fff6e64cdee2')
  }
}


// find --------------------------------------------------------------------

// all students
db.students.find()

{
  _id: ObjectId('69dfb6620671fff6e64cdee0'),
  student_id: 'S201',
  fname: 'Neha',
  lname: 'Kulkarni',
  mob_no: '9000000001',
  dept: 'IT',
  year_of_study: 3,
  hostel_id: 'H1',
  room_id: 'R101',
  visitors: []
}
{
  _id: ObjectId('69dfb6690671fff6e64cdee1'),
  student_id: 'S202',
  fname: 'Rohit',
  lname: 'Patil',
  mob_no: '9000000002',
  dept: 'CSE',
  year_of_study: 2,
  hostel_id: 'H1',
  room_id: 'R101',
  visitors: []
}
{
  _id: ObjectId('69dfb6690671fff6e64cdee2'),
  student_id: 'S203',
  fname: 'Sneha',
  lname: 'Jadhav',
  mob_no: '9000000003',
  dept: 'ENTC',
  year_of_study: 1,
  hostel_id: 'H1',
  room_id: 'R102',
  visitors: []
}


// specific condition
db.students.find({ dept: "CSE" })

{
  _id: ObjectId('69dfb6690671fff6e64cdee1'),
  student_id: 'S202',
  fname: 'Rohit',
  lname: 'Patil',
  mob_no: '9000000002',
  dept: 'CSE',
  year_of_study: 2,
  hostel_id: 'H1',
  room_id: 'R101',
  visitors: []
}


// projection
db.students.find(
  { hostel_id: "H1" },
  { fname: 1, room_id: 1, _id: 0 }
)

{
  fname: 'Neha',
  room_id: 'R101'
}
{
  fname: 'Rohit',
  room_id: 'R101'
}
{
  fname: 'Sneha',
  room_id: 'R102'
}



// update one ---------------------------------------------------------------------
db.students.updateOne(
  { student_id: "S201" },
  { $set: { room_id: "R102" } }
)

{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}



// update many 
db.students.updateMany(
  { hostel_id: "H1" },
  { $set: { hostel_id: "H2" } }
)

{
  acknowledged: true,
  insertedId: null,
  matchedCount: 3,
  modifiedCount: 3,
  upsertedCount: 0
}




// delete One -------------------------------------------------------
db.students.deleteOne({ student_id: "S203" })

{
  acknowledged: true,
  deletedCount: 1
}


// delete Many
db.students.deleteMany({ hostel_id: "H2" })

{
  acknowledged: true,
  deletedCount: 2
}
