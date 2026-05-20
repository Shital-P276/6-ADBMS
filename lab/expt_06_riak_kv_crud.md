# Expt 06: CRUD on Key-Value Database using Riak

## Objective
Perform create, read, update, delete in Riak KV.

## Bucket and Key Example
- Bucket: `students`
- Keys: `s1`, `s2`, `s3`

## CRUD Syntax (HTTP)
```bash
# Create
curl -X PUT http://127.0.0.1:8098/buckets/students/keys/s1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Asha","branch":"CSE"}'

curl -X PUT http://127.0.0.1:8098/buckets/students/keys/s2 \
  -H "Content-Type: application/json" \
  -d '{"name":"Ravi","branch":"ECE"}'

curl -X PUT http://127.0.0.1:8098/buckets/students/keys/s3 \
  -H "Content-Type: application/json" \
  -d '{"name":"Ira","branch":"MECH"}'

# Read
curl -X GET http://127.0.0.1:8098/buckets/students/keys/s1

# Update
curl -X PUT http://127.0.0.1:8098/buckets/students/keys/s1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Asha","branch":"AIML"}'

# Delete
curl -X DELETE http://127.0.0.1:8098/buckets/students/keys/s3
```
