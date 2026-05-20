# Expt 07: Installation of MongoDB NoSQL Database

## Objective
Install MongoDB and verify server + shell access.

## Software
- MongoDB Community Server
- `mongosh`

## Basic Steps
1. Install MongoDB packages.
2. Start service (`mongod`).
3. Connect using `mongosh`.

## Verification Commands
```bash
mongosh --eval "db.runCommand({ ping: 1 })"
```

Expected output includes `{ ok: 1 }`.
