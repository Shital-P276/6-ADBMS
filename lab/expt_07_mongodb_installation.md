# Expt 07: Installation of MongoDB NoSQL Database

## Objective
Install MongoDB Community Edition and verify daemon + shell.

## Ubuntu/Debian Commands
```bash
sudo apt update
sudo apt install -y mongodb

# Start and enable service
sudo systemctl start mongodb
sudo systemctl enable mongodb

# Check status
sudo systemctl status mongodb --no-pager

# Open shell test
mongosh --eval "db.runCommand({ ping: 1 })"
```

## Optional Basic DB Check
```bash
mongosh --eval "show dbs"
```
