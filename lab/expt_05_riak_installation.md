# Expt 05: Installation of Riak NoSQL Database

## Objective
Install Riak and verify the service.

## Software
- Riak KV
- `riak` command-line tools

## Basic Steps
1. Install Riak package.
2. Start service: `riak start`
3. Verify status: `riak ping`
4. Open HTTP API endpoint (default port 8098).

## Verification
```bash
riak ping
curl http://127.0.0.1:8098/ping
```

Expected successful response: `OK` / `pong`.
