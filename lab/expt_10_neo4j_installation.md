# Expt 10: Installation of Neo4j NoSQL Database

## Objective
Install Neo4j, start server, and verify using browser/cypher-shell.

## Ubuntu/Debian (Typical) Commands
```bash
sudo apt update
sudo apt install -y neo4j

# Start + check
sudo systemctl start neo4j
sudo systemctl enable neo4j
sudo systemctl status neo4j --no-pager

# CLI check (if cypher-shell is installed)
cypher-shell -u neo4j -p neo4j "RETURN 1 AS status;"
```

## Browser Check
- Open: `http://localhost:7474`
- Login and change default password on first login.
