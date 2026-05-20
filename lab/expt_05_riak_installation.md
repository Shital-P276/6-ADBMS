# Expt 05: Installation of Riak NoSQL Database

## Objective
Install Riak KV and verify service, ports, and HTTP API.

## Ubuntu/Debian Commands
```bash
# Add package and install (use your OS-appropriate package source if needed)
sudo apt update
sudo apt install -y riak

# Start riak
riak start

# Status and ping
riak-admin status
riak ping

# Verify HTTP API
curl http://127.0.0.1:8098/ping

# Optional: stop/restart
riak stop
riak restart
```

## What to Note in Record
- `riak ping` should return `pong`
- HTTP API `/ping` should return `OK`
