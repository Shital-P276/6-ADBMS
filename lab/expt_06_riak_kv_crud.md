# Expt 06: Perform CRUD on Key-Value Database using Riak

## Objective
Run full CRUD operations on Riak KV with JSON values.

## Complete Commands (Copy Directly)
```bash
# 1) Create / Insert
curl -i -X PUT http://127.0.0.1:8098/buckets/students/keys/s1 \
  -H "Content-Type: application/json" \
  -d '{"roll":1,"name":"Asha","branch":"CSE"}'

curl -i -X PUT http://127.0.0.1:8098/buckets/students/keys/s2 \
  -H "Content-Type: application/json" \
  -d '{"roll":2,"name":"Ravi","branch":"ECE"}'

curl -i -X PUT http://127.0.0.1:8098/buckets/students/keys/s3 \
  -H "Content-Type: application/json" \
  -d '{"roll":3,"name":"Ira","branch":"IT"}'

curl -i -X PUT http://127.0.0.1:8098/buckets/students/keys/s4 \
  -H "Content-Type: application/json" \
  -d '{"roll":4,"name":"Neha","branch":"MECH"}'

# 2) Read
curl -i -X GET http://127.0.0.1:8098/buckets/students/keys/s1
curl -i -X GET http://127.0.0.1:8098/buckets/students/keys/s2
curl -i -X GET http://127.0.0.1:8098/buckets/students/keys/s3
curl -i -X GET http://127.0.0.1:8098/buckets/students/keys/s4

# 3) Update
curl -i -X PUT http://127.0.0.1:8098/buckets/students/keys/s2 \
  -H "Content-Type: application/json" \
  -d '{"roll":2,"name":"Ravi","branch":"AIML"}'

# 4) Delete
curl -i -X DELETE http://127.0.0.1:8098/buckets/students/keys/s4

# 5) Re-read after update/delete
curl -i -X GET http://127.0.0.1:8098/buckets/students/keys/s2
curl -i -X GET http://127.0.0.1:8098/buckets/students/keys/s4
```
